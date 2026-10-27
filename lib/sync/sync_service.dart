import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../data/db.dart';

/// True once Firebase is configured and running (Android/iOS only).
final syncAvailable = ValueNotifier<bool>(false);

/// The signed-in Google account, or null.
final syncUser = ValueNotifier<User?>(null);

_Sync? _sync;

FirebaseFirestore get _fs => FirebaseFirestore.instance;
CollectionReference<Map<String, dynamic>> get _pets => _fs.collection('pets');

void _log(Object e) => debugPrint('sync: $e');

/// Starts sync if the platform has a Firebase config. Safe to call anywhere:
/// without config the app simply stays local-only.
Future<void> initSync() async {
  if (!(Platform.isAndroid || Platform.isIOS)) return;
  await Firebase.initializeApp();
  syncAvailable.value = true;
  FirebaseAuth.instance.authStateChanges().listen((user) {
    syncUser.value = user;
    _sync?.dispose();
    _sync = user == null ? null : _Sync(user.uid);
  });
}

Future<User> ensureSignedIn() async {
  final current = FirebaseAuth.instance.currentUser;
  if (current != null) return current;
  final cred = await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  return cred.user!;
}

class JoinFailed implements Exception {}

/// Short technical reason shown under the generic message, so a failure on a
/// user's phone can be reported without needing a debugger.
String describeError(Object e) =>
    e is FirebaseException ? '${e.plugin}/${e.code}: ${e.message ?? ''}' : e.toString();

String _uuid() {
  final r = Random.secure();
  return List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}

// no 0/O/1/I: codes get read out loud and typed by hand
const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
String _inviteCode() {
  final r = Random.secure();
  return List.generate(8, (_) => _codeAlphabet[r.nextInt(_codeAlphabet.length)]).join();
}

int _nowMs() => DateTime.now().millisecondsSinceEpoch;
int? _ms(DateTime? d) => d?.millisecondsSinceEpoch;
DateTime? _date(Object? ms) => ms == null ? null : DateTime.fromMillisecondsSinceEpoch((ms as num).toInt());

Map<String, Object?> _petMap(Pet p) => {
      'name': p.name,
      'species': p.species,
      'breed': p.breed,
      'birthDate': _ms(p.birthDate),
      'chip': p.chip,
      'vetName': p.vetName,
      'vetPhone': p.vetPhone,
      'notes': p.notes,
      'updatedAt': p.updatedAt ?? _nowMs(),
      'deleted': false,
    };

/// Makes [localPetId] a shared pet (uploading it on first use) and returns an
/// invite code valid for 7 days.
Future<String> sharePet(int localPetId) async {
  final user = await ensureSignedIn();
  var pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  if (pet.remoteId == null) {
    final id = _uuid();
    // 1. Give the local pet its shared id FIRST. When the server copy appears, the sync listener
    //    must recognise it as this very pet; otherwise it adds a second, duplicate pet.
    await db.applyingRemote(() => (db.update(db.pets)..where((p) => p.id.equals(localPetId)))
        .write(PetsCompanion(remoteId: Value(id))));
    try {
      // 2. The pet document must exist before its children: their rules check membership on it
      await _pets.doc(id).set({
        ..._petMap(pet),
        'members': [user.uid],
        'ownerUid': user.uid,
      }).timeout(const Duration(seconds: 20));
    } catch (_) {
      // offline or refused: the pet is not shared after all
      await db.applyingRemote(() => (db.update(db.pets)..where((p) => p.id.equals(localPetId)))
          .write(const PetsCompanion(remoteId: Value(null))));
      rethrow;
    }
    // 3. Now that the server has the pet, upload everything it owns
    final now = _nowMs();
    await db.applyingRemote(() async {
      await (db.update(db.pets)..where((p) => p.id.equals(localPetId)))
          .write(PetsCompanion(updatedAt: Value(now), dirty: const Value(true)));
      for (final t in ['health_records', 'weights', 'appointments']) {
        await db.customStatement('UPDATE $t SET dirty = 1, updated_at = ? WHERE pet_id = ?', [now, localPetId]);
      }
    });
    pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  }
  final code = _inviteCode();
  await _fs.collection('invites').doc(code).set({
    'petId': pet.remoteId,
    'ownerUid': user.uid,
    'expiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
  }).timeout(const Duration(seconds: 20));
  return code;
}

/// Joins the pet behind [code]. It then appears locally through the normal sync.
Future<void> joinWithCode(String code) async {
  final user = await ensureSignedIn();
  code = code.trim().toUpperCase();
  try {
    final invite = await _fs.collection('invites').doc(code).get();
    final data = invite.data();
    if (data == null || (data['expiresAt'] as Timestamp).toDate().isBefore(DateTime.now())) {
      throw JoinFailed();
    }
    await _pets.doc(data['petId'] as String).update({
      'members': FieldValue.arrayUnion([user.uid]),
      'joinCode': code,
    }).timeout(const Duration(seconds: 20));
  } on FirebaseException {
    throw JoinFailed(); // rules refused: wrong or expired code
  }
}

const _kinds = ['records', 'weights', 'appointments'];
String _kindOf(String table) => switch (table) {
      'health_records' => 'records',
      _ => table,
    };

/// Two-way sync for every pet that has a remoteId. Conflict rule: the most
/// recent edit (updatedAt) wins, per row.
class _Sync {
  _Sync(this.uid) {
    _subs.add(_pets.where('members', arrayContains: uid).snapshots().listen(_onPets, onError: _log));
    for (final s in [
      db.select(db.pets).watch(),
      db.select(db.healthRecords).watch(),
      db.select(db.weights).watch(),
      db.select(db.appointments).watch(),
    ]) {
      _subs.add(s.listen((_) => _schedulePush()));
    }
  }

  final String uid;
  final _subs = <StreamSubscription<Object?>>[];
  final _childSubs = <String, List<StreamSubscription<Object?>>>{};
  Future<void> _last = Future.value();
  Timer? _debounce;

  void dispose() {
    _debounce?.cancel();
    for (final s in _subs) {
      s.cancel();
    }
    for (final l in _childSubs.values) {
      for (final s in l) {
        s.cancel();
      }
    }
  }

  // one job at a time, so a stale read can never land after a newer one
  void _enqueue(Future<void> Function() job) =>
      _last = _last.then((_) => job()).catchError((Object e) => _log(e));

  void _schedulePush() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () => _enqueue(_push));
  }

  // ---------------------------------------------------------------- remote -> local

  void _onPets(QuerySnapshot<Map<String, dynamic>> snap) => _enqueue(() async {
        for (final ch in snap.docChanges) {
          final id = ch.doc.id;
          final d = ch.doc.data();
          if (ch.type == DocumentChangeType.removed || d == null || d['deleted'] == true) {
            // deleted by the owner, or I left: drop my copy
            await _dropLocal(id);
            for (final s in _childSubs.remove(id) ?? const <StreamSubscription<Object?>>[]) {
              await s.cancel();
            }
            continue;
          }
          await _applyPet(id, d);
          _watchChildren(id);
        }
      });

  Future<void> _dropLocal(String petRemoteId) => db.applyingRemote(() async {
        await (db.delete(db.pets)..where((p) => p.remoteId.equals(petRemoteId))).go();
      });

  /// The local pet for a shared id. An earlier version could create a second copy of a pet right
  /// after sharing it; if two exist, the original (lowest id) is kept and the copies are removed.
  /// Must run inside [AppDb.applyingRemote] so the removal is not reported to the server.
  Future<Pet?> _localPet(String remoteId) async {
    final all = await (db.select(db.pets)
          ..where((p) => p.remoteId.equals(remoteId))
          ..orderBy([(p) => OrderingTerm.asc(p.id)]))
        .get();
    for (final copy in all.skip(1)) {
      await (db.delete(db.pets)..where((p) => p.id.equals(copy.id))).go();
    }
    return all.isEmpty ? null : all.first;
  }

  // true when the local copy must be left alone (it is newer and still to be pushed)
  bool _localWins(int? localTs, bool? dirty, int remoteTs) => dirty == true && (localTs ?? 0) > remoteTs;

  Future<void> _applyPet(String id, Map<String, dynamic> d) async {
    final ts = (d['updatedAt'] as num?)?.toInt() ?? 0;
    await db.applyingRemote(() async {
      final local = await _localPet(id);
      if (local != null && (_localWins(local.updatedAt, local.dirty, ts) || (local.updatedAt == ts && local.dirty != true))) {
        return;
      }
      final c = PetsCompanion(
        name: Value(d['name'] as String),
        species: Value(d['species'] as String? ?? 'dog'),
        breed: Value(d['breed'] as String?),
        birthDate: Value(_date(d['birthDate'])),
        chip: Value(d['chip'] as String?),
        vetName: Value(d['vetName'] as String?),
        vetPhone: Value(d['vetPhone'] as String?),
        notes: Value(d['notes'] as String?),
        remoteId: Value(id),
        updatedAt: Value(ts),
        dirty: const Value(false),
      );
      if (local == null) {
        await db.into(db.pets).insert(c);
      } else {
        await (db.update(db.pets)..where((p) => p.id.equals(local.id))).write(c);
      }
    });
  }

  void _watchChildren(String petId) {
    if (_childSubs.containsKey(petId)) return;
    _childSubs[petId] = [
      for (final kind in _kinds)
        _pets.doc(petId).collection(kind).snapshots().listen(
              (s) => _enqueue(() => _applyChildren(petId, kind, s)),
              onError: _log,
            ),
    ];
  }

  Future<void> _applyChildren(String petRemote, String kind, QuerySnapshot<Map<String, dynamic>> snap) async {
    for (final ch in snap.docChanges) {
      final d = ch.doc.data();
      if (d == null || ch.type == DocumentChangeType.removed) continue;
      try {
        await _applyChild(petRemote, kind, ch.doc.id, d);
      } catch (e) {
        _log('skipped malformed $kind/${ch.doc.id}: $e'); // one bad document must not block the rest
      }
    }
  }

  Future<void> _applyChild(String petRemote, String kind, String id, Map<String, dynamic> d) async {
    final ts = (d['updatedAt'] as num?)?.toInt() ?? 0;
    final gone = d['deleted'] == true;
    await db.applyingRemote(() async {
      final pet = await _localPet(petRemote);
      if (pet == null) return;
      switch (kind) {
        case 'records':
          final local = await (db.select(db.healthRecords)..where((r) => r.remoteId.equals(id))).getSingleOrNull();
          if (gone) {
            await (db.delete(db.healthRecords)..where((r) => r.remoteId.equals(id))).go();
            return;
          }
          if (local != null && (_localWins(local.updatedAt, local.dirty, ts) || (local.updatedAt == ts && local.dirty != true))) return;
          final c = HealthRecordsCompanion(
            petId: Value(pet.id),
            type: Value(RecordType.values[(d['type'] as num).toInt()]),
            product: Value(d['product'] as String),
            date: Value(_date(d['date'])!),
            nextDue: Value(_date(d['nextDue'])),
            remindDaysBefore: Value((d['remindDaysBefore'] as num?)?.toInt() ?? 7),
            remoteId: Value(id),
            updatedAt: Value(ts),
            dirty: const Value(false),
          );
          if (local == null) {
            await db.into(db.healthRecords).insert(c);
          } else {
            await (db.update(db.healthRecords)..where((r) => r.id.equals(local.id))).write(c);
          }
        case 'weights':
          final local = await (db.select(db.weights)..where((w) => w.remoteId.equals(id))).getSingleOrNull();
          if (gone) {
            await (db.delete(db.weights)..where((w) => w.remoteId.equals(id))).go();
            return;
          }
          if (local != null && (_localWins(local.updatedAt, local.dirty, ts) || (local.updatedAt == ts && local.dirty != true))) return;
          final c = WeightsCompanion(
            petId: Value(pet.id),
            date: Value(_date(d['date'])!),
            kg: Value((d['kg'] as num).toDouble()),
            remoteId: Value(id),
            updatedAt: Value(ts),
            dirty: const Value(false),
          );
          if (local == null) {
            await db.into(db.weights).insert(c);
          } else {
            await (db.update(db.weights)..where((w) => w.id.equals(local.id))).write(c);
          }
        case 'appointments':
          final local = await (db.select(db.appointments)..where((a) => a.remoteId.equals(id))).getSingleOrNull();
          if (gone) {
            await (db.delete(db.appointments)..where((a) => a.remoteId.equals(id))).go();
            return;
          }
          if (local != null && (_localWins(local.updatedAt, local.dirty, ts) || (local.updatedAt == ts && local.dirty != true))) return;
          final c = AppointmentsCompanion(
            petId: Value(pet.id),
            at: Value(_date(d['at'])!),
            title: Value(d['title'] as String),
            place: Value(d['place'] as String?),
            remindDaysBefore: Value((d['remindDaysBefore'] as num?)?.toInt() ?? 1),
            remoteId: Value(id),
            updatedAt: Value(ts),
            dirty: const Value(false),
          );
          if (local == null) {
            await db.into(db.appointments).insert(c);
          } else {
            await (db.update(db.appointments)..where((a) => a.id.equals(local.id))).write(c);
          }
      }
    });
  }

  // ---------------------------------------------------------------- local -> remote

  // Writes are not awaited: Firestore queues them on disk and sends them when
  // the phone is online, so an offline edit is never lost.
  Future<void> _push() async {
    final pets = await db.select(db.pets).get();
    final byLocalId = {for (final p in pets) p.id: p};
    for (final p in pets.where((p) => p.remoteId != null && p.dirty == true)) {
      unawaited(_pets.doc(p.remoteId!).set(_petMap(p), SetOptions(merge: true)).catchError(_log));
      await _markClean(p.id, p.updatedAt);
    }

    final records = await (db.select(db.healthRecords)..where((r) => r.dirty.equals(true))).get();
    for (final r in records) {
      final pet = byLocalId[r.petId];
      if (pet?.remoteId == null) continue; // not a shared pet
      final id = r.remoteId ?? _uuid();
      unawaited(_pets.doc(pet!.remoteId!).collection('records').doc(id).set({
        'type': r.type.index,
        'product': r.product,
        'date': _ms(r.date),
        'nextDue': _ms(r.nextDue),
        'remindDaysBefore': r.remindDaysBefore,
        'updatedAt': r.updatedAt ?? _nowMs(),
        'deleted': false,
      }, SetOptions(merge: true)).catchError(_log));
      await _markChildClean('health_records', r.id, id, r.updatedAt);
    }

    final weights = await (db.select(db.weights)..where((w) => w.dirty.equals(true))).get();
    for (final w in weights) {
      final pet = byLocalId[w.petId];
      if (pet?.remoteId == null) continue;
      final id = w.remoteId ?? _uuid();
      unawaited(_pets.doc(pet!.remoteId!).collection('weights').doc(id).set({
        'date': _ms(w.date),
        'kg': w.kg,
        'updatedAt': w.updatedAt ?? _nowMs(),
        'deleted': false,
      }, SetOptions(merge: true)).catchError(_log));
      await _markChildClean('weights', w.id, id, w.updatedAt);
    }

    final appts = await (db.select(db.appointments)..where((a) => a.dirty.equals(true))).get();
    for (final a in appts) {
      final pet = byLocalId[a.petId];
      if (pet?.remoteId == null) continue;
      final id = a.remoteId ?? _uuid();
      unawaited(_pets.doc(pet!.remoteId!).collection('appointments').doc(id).set({
        'at': _ms(a.at),
        'title': a.title,
        'place': a.place,
        'remindDaysBefore': a.remindDaysBefore,
        'updatedAt': a.updatedAt ?? _nowMs(),
        'deleted': false,
      }, SetOptions(merge: true)).catchError(_log));
      await _markChildClean('appointments', a.id, id, a.updatedAt);
    }

    for (final t in await db.select(db.syncDeletes).get()) {
      try {
        if (t.kind == 'pets') {
          await _removePet(t.remoteId);
        } else {
          unawaited(_pets
              .doc(t.petRemoteId)
              .collection(_kindOf(t.kind))
              .doc(t.remoteId)
              .set({'deleted': true, 'updatedAt': _nowMs()}, SetOptions(merge: true)).catchError(_log));
        }
        await (db.delete(db.syncDeletes)..where((x) => x.id.equals(t.id))).go();
      } catch (e) {
        _log('delete $t kept for retry: $e');
      }
    }
  }

  // Clean only if the row was not edited again while we were sending it.
  Future<void> _markClean(int id, int? ts) => db.applyingRemote(() async {
        await db.customStatement('UPDATE pets SET dirty = 0 WHERE id = ? AND updated_at IS ?', [id, ts]);
      });

  Future<void> _markChildClean(String table, int id, String remoteId, int? ts) => db.applyingRemote(() async {
        await db.customStatement(
            'UPDATE $table SET remote_id = ?, dirty = 0 WHERE id = ? AND updated_at IS ?', [remoteId, id, ts]);
      });
  /// Owner deleting a shared pet removes it for everybody; anyone else just leaves it.
  Future<void> _removePet(String remoteId) async {
    final ref = _pets.doc(remoteId);
    final doc = await ref.get();
    final data = doc.data();
    if (data == null) return;
    if (data['ownerUid'] == uid) {
      await ref.update({'deleted': true, 'updatedAt': _nowMs()});
    } else {
      await ref.update({'members': FieldValue.arrayRemove([uid])});
    }
  }
}
