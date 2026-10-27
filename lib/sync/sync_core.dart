import 'package:drift/drift.dart' show OrderingTerm, Value, Variable;

import '../data/db.dart';

/// Pure database side of the sync: no Firestore here, so it can be unit-tested with an in-memory db.
/// Wire format (field names, ms timestamps, enum indices) is already in production: do not change it.

int _nowMs() => DateTime.now().millisecondsSinceEpoch;
int? _ms(DateTime? d) => d?.millisecondsSinceEpoch;
DateTime? _date(Object? ms) => ms == null ? null : DateTime.fromMillisecondsSinceEpoch((ms as num).toInt());

Map<String, Object?> petWire(Pet p, {int Function() now = _nowMs}) => {
      'name': p.name,
      'species': p.species,
      'breed': p.breed,
      'birthDate': _ms(p.birthDate),
      'chip': p.chip,
      'vetName': p.vetName,
      'vetPhone': p.vetPhone,
      'notes': p.notes,
      'sex': p.sex,
      'color': p.color,
      'updatedAt': p.updatedAt ?? now(),
      'deleted': false,
    };

/// A dirty child row, reduced to what the push needs.
class _Row {
  _Row(this.id, this.petId, this.remoteId, this.updatedAt, this.wire);
  final int id, petId;
  final String? remoteId;
  final int? updatedAt;
  final Map<String, Object?> wire; // without updatedAt/deleted
}

/// One per sub-collection: replaces four copies of the same decide/insert/update/delete code.
class ChildKind {
  const ChildKind(this.collection, this.table, this._dirtyRows, this._upsert);

  final String collection; // Firestore sub-collection
  final String table; // SQL table
  final Future<List<_Row>> Function(AppDb db) _dirtyRows;
  // localId == null inserts; otherwise updates that row. Photos and other local-only columns stay untouched.
  final Future<void> Function(AppDb db, Map<String, dynamic> d, String rid, int petId, int? localId, int ts) _upsert;
}

int _remind(Map<String, dynamic> d, int fallback) => (d['remindDaysBefore'] as num?)?.toInt() ?? fallback;

final childKinds = <ChildKind>[
  ChildKind(
    'records',
    'health_records',
    (db) async => [
      for (final r in await (db.select(db.healthRecords)..where((r) => r.dirty.equals(true))).get())
        _Row(r.id, r.petId, r.remoteId, r.updatedAt, {
          'type': r.type.index,
          'product': r.product,
          'date': _ms(r.date),
          'nextDue': _ms(r.nextDue),
          'remindDaysBefore': r.remindDaysBefore,
        }),
    ],
    (db, d, rid, petId, id, ts) => db.into(db.healthRecords).insertOnConflictUpdate(HealthRecordsCompanion(
          id: Value.absentIfNull(id),
          petId: Value(petId),
          type: Value(RecordType.values[(d['type'] as num).toInt()]),
          product: Value(d['product'] as String),
          date: Value(_date(d['date'])!),
          nextDue: Value(_date(d['nextDue'])),
          remindDaysBefore: Value(_remind(d, 7)),
          remoteId: Value(rid),
          updatedAt: Value(ts),
          dirty: const Value(false),
        )),
  ),
  ChildKind(
    'weights',
    'weights',
    (db) async => [
      for (final w in await (db.select(db.weights)..where((w) => w.dirty.equals(true))).get())
        _Row(w.id, w.petId, w.remoteId, w.updatedAt, {'date': _ms(w.date), 'kg': w.kg}),
    ],
    (db, d, rid, petId, id, ts) => db.into(db.weights).insertOnConflictUpdate(WeightsCompanion(
          id: Value.absentIfNull(id),
          petId: Value(petId),
          date: Value(_date(d['date'])!),
          kg: Value((d['kg'] as num).toDouble()),
          remoteId: Value(rid),
          updatedAt: Value(ts),
          dirty: const Value(false),
        )),
  ),
  ChildKind(
    'appointments',
    'appointments',
    (db) async => [
      for (final a in await (db.select(db.appointments)..where((a) => a.dirty.equals(true))).get())
        _Row(a.id, a.petId, a.remoteId, a.updatedAt, {
          'at': _ms(a.at),
          'title': a.title,
          'place': a.place,
          'remindDaysBefore': a.remindDaysBefore,
        }),
    ],
    (db, d, rid, petId, id, ts) => db.into(db.appointments).insertOnConflictUpdate(AppointmentsCompanion(
          id: Value.absentIfNull(id),
          petId: Value(petId),
          at: Value(_date(d['at'])!),
          title: Value(d['title'] as String),
          place: Value(d['place'] as String?),
          remindDaysBefore: Value(_remind(d, 1)),
          remoteId: Value(rid),
          updatedAt: Value(ts),
          dirty: const Value(false),
        )),
  ),
  ChildKind(
    'contacts',
    'pet_contacts',
    (db) async => [
      for (final c in await (db.select(db.petContacts)..where((c) => c.dirty.equals(true))).get())
        _Row(c.id, c.petId, c.remoteId, c.updatedAt, {
          'kind': c.kind.index,
          'name': c.name,
          'address': c.address,
          'phone': c.phone,
          'website': c.website,
          'notes': c.notes,
        }),
    ],
    (db, d, rid, petId, id, ts) => db.into(db.petContacts).insertOnConflictUpdate(PetContactsCompanion(
          id: Value.absentIfNull(id),
          petId: Value(petId),
          kind: Value(ContactKind.values[(d['kind'] as num).toInt()]),
          name: Value(d['name'] as String),
          address: Value(d['address'] as String?),
          phone: Value(d['phone'] as String?),
          website: Value(d['website'] as String?),
          notes: Value(d['notes'] as String?),
          remoteId: Value(rid),
          updatedAt: Value(ts),
          dirty: const Value(false),
        )),
  ),
];

ChildKind childKind(String collection) => childKinds.firstWhere((k) => k.collection == collection);

/// The local pet for a shared id. An earlier version could create a second copy of a pet right
/// after sharing it; if two exist, the original (lowest id) is kept and the copies are removed.
/// Must run inside [AppDb.applyingRemote] so the removal is not reported to the server.
Future<Pet?> localPet(AppDb db, String remoteId) async {
  final all = await (db.select(db.pets)
        ..where((p) => p.remoteId.equals(remoteId))
        ..orderBy([(p) => OrderingTerm.asc(p.id)]))
      .get();
  for (final copy in all.skip(1)) {
    await (db.delete(db.pets)..where((p) => p.id.equals(copy.id))).go();
  }
  return all.isEmpty ? null : all.first;
}

// true when the local copy must not be overwritten: it is newer and still to be pushed,
// or it is the very same version and already clean
bool _keepLocal(int? localTs, bool? dirty, int remoteTs) =>
    (dirty == true && (localTs ?? 0) > remoteTs) || (localTs == remoteTs && dirty != true);

int _remoteTs(Map<String, dynamic> d) => (d['updatedAt'] as num?)?.toInt() ?? 0;

Future<void> applyRemotePet(AppDb db, String remoteId, Map<String, dynamic> d) async {
  final ts = _remoteTs(d);
  await db.applyingRemote(() async {
    final local = await localPet(db, remoteId);
    if (local != null && _keepLocal(local.updatedAt, local.dirty, ts)) return;
    // photoPath is never part of the wire format, so it is neither sent nor overwritten
    await db.into(db.pets).insertOnConflictUpdate(PetsCompanion(
      id: Value.absentIfNull(local?.id),
      name: Value(d['name'] as String),
      species: Value(d['species'] as String? ?? 'dog'),
      breed: Value(d['breed'] as String?),
      birthDate: Value(_date(d['birthDate'])),
      chip: Value(d['chip'] as String?),
      vetName: Value(d['vetName'] as String?),
      vetPhone: Value(d['vetPhone'] as String?),
      notes: Value(d['notes'] as String?),
      sex: Value(d['sex'] as String?),
      color: Value(d['color'] as String?),
      remoteId: Value(remoteId),
      updatedAt: Value(ts),
      dirty: const Value(false),
    ));
  });
}

Future<void> applyRemoteChild(
    AppDb db, ChildKind kind, String petRemoteId, String docId, Map<String, dynamic> d) async {
  final ts = _remoteTs(d);
  await db.applyingRemote(() async {
    final pet = await localPet(db, petRemoteId);
    if (pet == null) return;
    final local = await db
        .customSelect('SELECT id, updated_at, dirty FROM ${kind.table} WHERE remote_id = ?', variables: [
      Variable.withString(docId),
    ]).getSingleOrNull();
    if (d['deleted'] == true) {
      await db.customStatement('DELETE FROM ${kind.table} WHERE remote_id = ?', [docId]);
      return;
    }
    if (local != null && _keepLocal(local.read<int?>('updated_at'), local.read<int?>('dirty') == 1, ts)) return;
    await kind._upsert(db, d, docId, pet.id, local?.read<int>('id'), ts);
  });
}

/// A document to send. [done] marks the local row clean (or removes its tombstone) once handed over.
class OutWrite {
  OutWrite(this.path, this.data, this.done);
  final String path;
  final Map<String, Object?> data;
  final Future<void> Function() done;
}

/// A pet tombstone: the owner deletes the server copy, anyone else just leaves it.
class PetRemoval {
  PetRemoval(this.remoteId, this.done);
  final String remoteId;
  final Future<void> Function() done;
}

class Outgoing {
  final writes = <OutWrite>[]; // merge-set these, in order
  final removals = <PetRemoval>[];
}

/// Everything dirty on shared pets, plus tombstones. Pets without a remoteId are not sent.
Future<Outgoing> collectOutgoing(AppDb db, {required String Function() newId, int Function() now = _nowMs}) async {
  final out = Outgoing();
  final pets = await db.select(db.pets).get();
  final byLocalId = {for (final p in pets) p.id: p};

  // Clean only if the row was not edited again while we were sending it.
  Future<void> markClean(String table, int id, int? ts, [String? remoteId]) => db.applyingRemote(() async {
        await db.customStatement(
            'UPDATE $table SET ${remoteId == null ? '' : 'remote_id = ?, '}dirty = 0 WHERE id = ? AND updated_at IS ?',
            [?remoteId, id, ts]);
      });

  for (final p in pets.where((p) => p.remoteId != null && p.dirty == true)) {
    out.writes.add(OutWrite('pets/${p.remoteId}', petWire(p, now: now), () => markClean('pets', p.id, p.updatedAt)));
  }
  for (final kind in childKinds) {
    for (final r in await kind._dirtyRows(db)) {
      final petRemote = byLocalId[r.petId]?.remoteId;
      if (petRemote == null) continue; // not a shared pet
      final id = r.remoteId ?? newId();
      out.writes.add(OutWrite(
        'pets/$petRemote/${kind.collection}/$id',
        {...r.wire, 'updatedAt': r.updatedAt ?? now(), 'deleted': false},
        () => markClean(kind.table, r.id, r.updatedAt, id),
      ));
    }
  }
  for (final t in await db.select(db.syncDeletes).get()) {
    Future<void> done() => (db.delete(db.syncDeletes)..where((x) => x.id.equals(t.id))).go();
    if (t.kind == 'pets') {
      out.removals.add(PetRemoval(t.remoteId, done));
    } else {
      final collection = childKinds.where((k) => k.table == t.kind).firstOrNull?.collection ?? t.kind;
      out.writes.add(OutWrite('pets/${t.petRemoteId}/$collection/${t.remoteId}',
          {'deleted': true, 'updatedAt': now()}, done));
    }
  }
  return out;
}
