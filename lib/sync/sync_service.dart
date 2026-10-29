import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' show Value;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../data/db.dart';
import '../photos.dart' show replaceAllPhotos;
import 'sync_core.dart';

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
  final auth = FirebaseAuth.instance;
  syncUser.value = await auth.authStateChanges().first; // restored session, or null on first launch
  _sync = syncUser.value == null ? null : _Sync(syncUser.value!.uid);
  auth.authStateChanges().skip(1).listen((user) {
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

final _publishing = <int, Future<void>>{};

/// Gives a local pet its cloud id and sends it, with everything it owns, to the server.
/// Every pet goes through here: new pets are published automatically, "share" only adds an invite code.
/// With [wait] the call returns once the server has the pet (and throws if it cannot be reached).
Future<void> _publishPet(int localPetId, String uid, {required bool wait}) =>
    _publishing[localPetId] ??= _doPublish(localPetId, uid, wait).whenComplete(() => _publishing.remove(localPetId));

Future<void> _doPublish(int localPetId, String uid, bool wait) async {
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  if (pet.remoteId != null) return; // already in the cloud
  final id = _uuid();
  // 1. Local id FIRST. When the server copy appears, the sync listener must recognise it as this very
  //    pet; otherwise it adds a second, duplicate pet.
  await db.applyingRemote(() => (db.update(db.pets)..where((p) => p.id.equals(localPetId)))
      .write(PetsCompanion(remoteId: Value(id))));
  // 2. The pet document must exist before its children (their rules check membership on it).
  //    Firestore keeps this write queued while offline and sends writes in order, so the children
  //    can follow even when we do not wait for the answer.
  final create = _pets.doc(id).set({
    ...petWire(pet),
    'members': [uid],
    'ownerUid': uid,
    'memberInfo': {uid: _userLabel(FirebaseAuth.instance.currentUser)},
  });
  if (wait) {
    await create.timeout(const Duration(seconds: 20));
  } else {
    unawaited(create.catchError((Object e) => _log(e)));
  }
  // 3. Upload everything the pet owns.
  final now = _nowMs();
  await db.applyingRemote(() async {
    await (db.update(db.pets)..where((p) => p.id.equals(localPetId)))
        .write(PetsCompanion(updatedAt: Value(now), dirty: const Value(true)));
    for (final t in [for (final k in childKinds) k.table]) {
      await db.customStatement('UPDATE $t SET dirty = 1, updated_at = ? WHERE pet_id = ?', [now, localPetId]);
    }
  });
}

/// Returns an invite code valid for 7 days. The pet is published first if it is not in the cloud yet.
Future<String> sharePet(int localPetId) async {
  final user = await ensureSignedIn();
  await _publishPet(localPetId, user.uid, wait: true);
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  final code = _inviteCode();
  await _fs.collection('invites').doc(code).set({
    'petId': pet.remoteId,
    'ownerUid': user.uid,
    'expiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
  }).timeout(const Duration(seconds: 20));
  return code;
}

/// What other members see for this account: the e-mail address, else the display name.
String _userLabel(User? u) => u?.email ?? u?.displayName ?? '';

class ShareMember {
  const ShareMember({required this.uid, required this.label, required this.isOwner, required this.isMe});
  final String uid, label;
  final bool isOwner, isMe;
}

class ShareInvite {
  const ShareInvite({required this.code, required this.expiresAt});
  final String code;
  final DateTime expiresAt;
}

class Shares {
  const Shares({required this.members, required this.invites, required this.iAmOwner});
  final List<ShareMember> members;
  final List<ShareInvite> invites;
  final bool iAmOwner;
}

/// Who can see this pet, plus the live invitation codes (only the owner creates codes).
/// Returns null when the pet is not in the cloud yet.
Future<Shares?> loadShares(int localPetId) async {
  final user = await ensureSignedIn();
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  final remote = pet.remoteId;
  if (remote == null) return null;
  final doc = await _pets.doc(remote).get().timeout(const Duration(seconds: 20));
  final d = doc.data();
  if (d == null) return null;
  final owner = d['ownerUid'] as String?;
  final info = Map<String, dynamic>.from(d['memberInfo'] as Map? ?? const {});
  final uids = List<String>.from(d['members'] as List? ?? const []);
  // pets shared before names were stored: each member fills their own entry in when they look here
  if ((info[user.uid] as String?)?.isEmpty ?? true) {
    final label = _userLabel(user);
    if (label.isNotEmpty) {
      info[user.uid] = label;
      unawaited(_pets.doc(remote).update({'memberInfo.${user.uid}': label}).catchError(_log));
    }
  }
  final now = DateTime.now();
  final invites = <ShareInvite>[];
  if (owner == user.uid) {
    final q = await _fs
        .collection('invites')
        .where('ownerUid', isEqualTo: user.uid)
        .where('petId', isEqualTo: remote)
        .get()
        .timeout(const Duration(seconds: 20));
    for (final i in q.docs) {
      final at = (i.data()['expiresAt'] as Timestamp).toDate();
      if (at.isAfter(now)) invites.add(ShareInvite(code: i.id, expiresAt: at));
    }
    invites.sort((a, b) => a.expiresAt.compareTo(b.expiresAt));
  }
  return Shares(
    iAmOwner: owner == user.uid,
    invites: invites,
    members: [
      for (final u in uids)
        ShareMember(uid: u, label: (info[u] as String?) ?? '', isOwner: u == owner, isMe: u == user.uid),
    ],
  );
}

/// Owner only: removes [uid]'s access. Their phone drops its copy when the server tells it.
Future<void> revokeMember(int localPetId, String uid) async {
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  await _pets.doc(pet.remoteId).update({
    'members': FieldValue.arrayRemove([uid]),
    'memberInfo.$uid': FieldValue.delete(),
  }).timeout(const Duration(seconds: 20));
}

/// Owner only: [newOwnerUid] (already a member) becomes the owner. With [leave] the former owner then
/// gives up their own access too, which makes it a full hand-over of the pet.
Future<void> transferOwnership(int localPetId, String newOwnerUid, {required bool leave}) async {
  final user = await ensureSignedIn();
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  final ref = _pets.doc(pet.remoteId);
  await ref.update({'ownerUid': newOwnerUid}).timeout(const Duration(seconds: 20));
  if (!leave) return;
  await ref.update({
    'members': FieldValue.arrayRemove([user.uid]),
    'memberInfo.${user.uid}': FieldValue.delete(),
  }).timeout(const Duration(seconds: 20));
}

/// Owner only: the code stops working at once.
Future<void> revokeInvite(String code) =>
    _fs.collection('invites').doc(code).delete().timeout(const Duration(seconds: 20));

/// A member gives up their own access; the pet stays for everybody else. Needs the server, and
/// removes the local copy straight away (the sync must not treat that as a delete).
Future<void> leaveShare(int localPetId) async {
  final user = await ensureSignedIn();
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingle();
  await _pets.doc(pet.remoteId).update({
    'members': FieldValue.arrayRemove([user.uid]),
    'memberInfo.${user.uid}': FieldValue.delete(),
  }).timeout(const Duration(seconds: 20));
  await db.applyingRemote(() => (db.delete(db.pets)..where((p) => p.id.equals(localPetId))).go());
}

enum PetRole { local, owner, member }

/// Whether the pet is only on this phone, owned by this account, or shared with it by someone else.
/// Only the owner may delete a pet, so when the answer cannot be found (offline and not cached) this
/// says [PetRole.member]: refusing a delete is safer than letting a shared pet be removed by mistake.
Future<PetRole> petRole(int localPetId) async {
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(localPetId))).getSingleOrNull();
  if (pet == null) return PetRole.local;
  if (pet.remoteId == null || !syncAvailable.value) return PetRole.local;
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return PetRole.member;
  Map<String, dynamic>? d;
  try {
    d = (await _pets.doc(pet.remoteId).get().timeout(const Duration(seconds: 5))).data();
  } catch (_) {
    try {
      d = (await _pets.doc(pet.remoteId).get(const GetOptions(source: Source.cache))).data();
    } catch (_) {
      return PetRole.member;
    }
  }
  if (d == null) return PetRole.member;
  final members = List<String>.from(d['members'] as List? ?? const []);
  if (d['ownerUid'] != user.uid) return PetRole.member;
  return members.length <= 1 ? PetRole.local : PetRole.owner; // nobody else has access: plain delete
}

/// Number of local changes the server has not received yet.
Future<int> unsyncedCount() async {
  final row = await db.customSelect('SELECT '
      '(SELECT COUNT(*) FROM pets WHERE dirty = 1 OR remote_id IS NULL) + '
      '(SELECT COUNT(*) FROM health_records WHERE dirty = 1) + '
      '(SELECT COUNT(*) FROM weights WHERE dirty = 1) + '
      '(SELECT COUNT(*) FROM appointments WHERE dirty = 1) + '
      '(SELECT COUNT(*) FROM pet_contacts WHERE dirty = 1) + '
      '(SELECT COUNT(*) FROM sync_deletes) AS n').getSingle();
  return row.read<int>('n');
}

/// Signs out and removes this account's data from the phone (it stays in the cloud).
/// Without that wipe, the next account to sign in would adopt these pets into its own cloud.
Future<void> signOutAndWipe() async {
  _sync?.dispose();
  _sync = null;
  await db.applyingRemote(() async {
    await db.delete(db.pets).go(); // children go with it
    await db.delete(db.syncDeletes).go();
  });
  replaceAllPhotos({});
  await FirebaseAuth.instance.signOut();
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
      'memberInfo.${user.uid}': _userLabel(user),
    }).timeout(const Duration(seconds: 20));
  } on FirebaseException {
    throw JoinFailed(); // rules refused: wrong or expired code
  }
}

/// Two-way sync for every pet that has a remoteId. Conflict rule: the most
/// recent edit (updatedAt) wins, per row.
class _Sync {
  _Sync(this.uid) {
    _subs.add(_pets.where('members', arrayContains: uid).snapshots().listen(_onPets, onError: _log));
    for (final s in [
      db.select(db.pets).watch(),
      db.select(db.healthRecords).watch(),
      db.select(db.petContacts).watch(),
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
          await applyRemotePet(db, id, d);
          _watchChildren(id);
        }
      });

  Future<void> _dropLocal(String petRemoteId) => db.applyingRemote(() async {
        await (db.delete(db.pets)..where((p) => p.remoteId.equals(petRemoteId))).go();
      });

  void _watchChildren(String petId) {
    if (_childSubs.containsKey(petId)) return;
    _childSubs[petId] = [
      for (final kind in childKinds)
        _pets.doc(petId).collection(kind.collection).snapshots().listen(
              (s) => _enqueue(() => _applyChildren(petId, kind, s)),
              onError: _log,
            ),
    ];
  }

  Future<void> _applyChildren(String petRemote, ChildKind kind, QuerySnapshot<Map<String, dynamic>> snap) async {
    for (final ch in snap.docChanges) {
      final d = ch.doc.data();
      if (d == null || ch.type == DocumentChangeType.removed) continue;
      try {
        await applyRemoteChild(db, kind, petRemote, ch.doc.id, d);
      } catch (e) {
        _log('skipped malformed ${kind.collection}/${ch.doc.id}: $e'); // one bad document must not block the rest
      }
    }
  }

  // ---------------------------------------------------------------- local -> remote

  // Writes are not awaited: Firestore queues them on disk and sends them when
  // the phone is online, so an offline edit is never lost.
  Future<void> _push() async {
    await _adoptUnsharedPets();
    final out = await collectOutgoing(db, newId: _uuid);
    for (final w in out.writes) {
      try {
        unawaited(_fs.doc(w.path).set(w.data, SetOptions(merge: true)).catchError(_log));
        await w.done();
      } catch (e) {
        _log('write ${w.path} kept for retry: $e');
      }
    }
    for (final r in out.removals) {
      try {
        await _removePet(r.remoteId);
        await r.done();
      } catch (e) {
        _log('delete pets/${r.remoteId} kept for retry: $e');
      }
    }
  }

  /// Every pet belongs to the signed-in account: pets created on this phone are sent to the cloud
  /// automatically (that is what lets a new phone get them back after signing in).
  Future<void> _adoptUnsharedPets() async {
    final todo = await (db.select(db.pets)..where((p) => p.remoteId.isNull())).get();
    for (final p in todo) {
      try {
        await _publishPet(p.id, uid, wait: false);
      } catch (e) {
        _log('could not publish pet ${p.id}: $e');
      }
    }
  }

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
