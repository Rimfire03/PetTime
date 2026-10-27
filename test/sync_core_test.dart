import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/data/db.dart';
import 'package:pettime/sync/sync_core.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late AppDb db;
  setUp(() => db = AppDb.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  Map<String, dynamic> petDoc({String name = 'Rex', int ts = 10, bool deleted = false}) =>
      {'name': name, 'species': 'cat', 'updatedAt': ts, 'deleted': deleted};
  Future<List<Pet>> pets() => db.select(db.pets).get();
  Future<List<Weight>> weights() => db.select(db.weights).get();
  Map<String, dynamic> weightDoc({double kg = 4, int ts = 10, bool deleted = false}) =>
      {'date': 1000, 'kg': kg, 'updatedAt': ts, 'deleted': deleted};
  final weightKind = childKind('weights');

  Future<int> localPet({String remote = 'p1', int ts = 5}) => db.applyingRemote(() => db.into(db.pets).insert(
      PetsCompanion.insert(name: 'Local', remoteId: Value(remote), updatedAt: Value(ts), dirty: const Value(false))));

  group('applyRemotePet', () {
    test('creates a new pet clean', () async {
      await applyRemotePet(db, 'p1', petDoc());
      final p = (await pets()).single;
      expect([p.name, p.species, p.remoteId, p.updatedAt, p.dirty], ['Rex', 'cat', 'p1', 10, false]);
    });

    test('newer remote overwrites a clean local row and keeps the photo', () async {
      final id = await localPet();
      await db.applyingRemote(
          () => (db.update(db.pets)..where((p) => p.id.equals(id))).write(const PetsCompanion(photoPath: Value('a.jpg'))));
      await applyRemotePet(db, 'p1', petDoc(name: 'Remote', ts: 9));
      final p = (await pets()).single;
      expect([p.id, p.name, p.updatedAt, p.photoPath], [id, 'Remote', 9, 'a.jpg']);
    });

    test('dirty and newer local row is left alone', () async {
      await localPet(ts: 20);
      await db.customStatement('UPDATE pets SET dirty = 1');
      await applyRemotePet(db, 'p1', petDoc(name: 'Remote', ts: 10));
      expect((await pets()).single.name, 'Local');
    });

    test('older remote does not overwrite a newer dirty row, but does a clean one (server is truth)', () async {
      await localPet(ts: 20);
      await applyRemotePet(db, 'p1', petDoc(name: 'Remote', ts: 10));
      expect((await pets()).single.name, 'Remote');
      await db.customStatement("UPDATE pets SET name = 'Local', dirty = 1, updated_at = 20");
      await applyRemotePet(db, 'p1', petDoc(name: 'Older', ts: 10));
      expect((await pets()).single.name, 'Local');
    });

    test('equal timestamp on a clean row is skipped', () async {
      await localPet(ts: 10);
      await applyRemotePet(db, 'p1', petDoc(name: 'Remote', ts: 10));
      expect((await pets()).single.name, 'Local');
    });

    test('duplicate local copies of one remoteId are reduced to the oldest', () async {
      final first = await localPet();
      await localPet();
      await applyRemotePet(db, 'p1', petDoc(ts: 9));
      final all = await pets();
      expect(all.single.id, first);
      expect(all.single.name, 'Rex');
    });
  });

  group('applyRemoteChild', () {
    test('creates, then newer remote updates the same row', () async {
      final pid = await localPet();
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc());
      var w = (await weights()).single;
      expect([w.petId, w.kg, w.remoteId, w.updatedAt, w.dirty], [pid, 4.0, 'w1', 10, false]);
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc(kg: 5, ts: 11));
      w = (await weights()).single;
      expect([w.kg, w.updatedAt], [5.0, 11]);
    });

    test('dirty newer and equal-clean local rows are left alone', () async {
      await localPet();
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc(ts: 10));
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc(kg: 9, ts: 10)); // equal, clean
      expect((await weights()).single.kg, 4.0);
      await db.customStatement('UPDATE weights SET dirty = 1, updated_at = 50');
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc(kg: 9, ts: 40)); // dirty and newer
      expect((await weights()).single.kg, 4.0);
    });

    test('remote deleted flag removes the row without a tombstone', () async {
      await localPet();
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc());
      await applyRemoteChild(db, weightKind, 'p1', 'w1', weightDoc(ts: 20, deleted: true));
      expect(await weights(), isEmpty);
      expect(await db.select(db.syncDeletes).get(), isEmpty);
    });

    test('a child for an unknown pet is ignored', () async {
      await applyRemoteChild(db, weightKind, 'nope', 'w1', weightDoc());
      expect(await weights(), isEmpty);
    });

    test('applies defaults and enum indices for the other kinds', () async {
      await localPet();
      await applyRemoteChild(db, childKind('records'), 'p1', 'r1',
          {'type': 2, 'product': 'X', 'date': 1000, 'updatedAt': 10});
      await applyRemoteChild(db, childKind('appointments'), 'p1', 'a1', {'at': 1000, 'title': 'Vet', 'updatedAt': 10});
      await applyRemoteChild(db, childKind('contacts'), 'p1', 'c1', {'kind': 1, 'name': 'Sit', 'updatedAt': 10});
      final r = (await db.select(db.healthRecords).get()).single;
      expect([r.type, r.remindDaysBefore], [RecordType.flea, 7]);
      expect((await db.select(db.appointments).get()).single.remindDaysBefore, 1);
      expect((await db.select(db.petContacts).get()).single.kind, ContactKind.petSitter);
    });
  });

  group('collectOutgoing', () {
    var n = 0;
    String newId() => 'id${n++}';
    int now() => 777;

    test('contains exactly the dirty rows of shared pets with the wire field names', () async {
      n = 0;
      final shared = await localPet();
      await db.customStatement('UPDATE pets SET dirty = 1, updated_at = 6');
      final unshared = await db.into(db.pets).insert(PetsCompanion.insert(name: 'Mine')); // no remoteId
      final t = DateTime.fromMillisecondsSinceEpoch(1000);
      await db.into(db.healthRecords).insert(HealthRecordsCompanion.insert(
          petId: shared, type: RecordType.vaccine, product: 'V', date: t, nextDue: Value(t)));
      await db.into(db.weights).insert(WeightsCompanion.insert(petId: shared, date: t, kg: 3));
      await db.into(db.appointments).insert(AppointmentsCompanion.insert(petId: shared, at: t, title: 'T'));
      await db.into(db.petContacts)
          .insert(PetContactsCompanion.insert(petId: shared, kind: ContactKind.boarding, name: 'B'));
      await db.into(db.weights).insert(WeightsCompanion.insert(petId: unshared, date: t, kg: 9));
      await db.customStatement('UPDATE weights SET remote_id = NULL, dirty = 1, updated_at = 1 WHERE pet_id = $unshared');

      final out = await collectOutgoing(db, newId: newId, now: now);
      final byPath = {for (final w in out.writes) w.path: w.data};
      final keys = {for (final e in byPath.entries) e.key.split('/').skip(2).take(1).join(): e.value.keys.toSet()};
      expect(byPath.length, 5);
      expect(byPath.keys.first, 'pets/p1');
      expect(byPath['pets/p1']!.keys.toSet(), {
        'name', 'species', 'breed', 'birthDate', 'chip', 'vetName', 'vetPhone', 'notes', 'sex', 'color',
        'updatedAt', 'deleted',
      });
      expect(keys['records'], {'type', 'product', 'date', 'nextDue', 'remindDaysBefore', 'updatedAt', 'deleted'});
      expect(keys['weights'], {'date', 'kg', 'updatedAt', 'deleted'});
      expect(keys['appointments'], {'at', 'title', 'place', 'remindDaysBefore', 'updatedAt', 'deleted'});
      expect(keys['contacts'],
          {'kind', 'name', 'address', 'phone', 'website', 'notes', 'updatedAt', 'deleted'});
      expect(byPath.entries.firstWhere((e) => e.key.contains('/records/')).value['type'], 0);
      expect(byPath.entries.firstWhere((e) => e.key.contains('/contacts/')).value['kind'], 2);
      expect(byPath.entries.firstWhere((e) => e.key.contains('/weights/')).value['date'], 1000);
    });

    test('done() marks clean and stores the new remoteId', () async {
      final pid = await localPet();
      await db.into(db.weights).insert(WeightsCompanion.insert(petId: pid, date: DateTime(2026), kg: 3));
      final out = await collectOutgoing(db, newId: () => 'new1', now: now);
      expect(out.writes.single.path, 'pets/p1/weights/new1');
      await out.writes.single.done();
      final w = (await weights()).single;
      expect([w.remoteId, w.dirty], ['new1', false]);
    });

    test('marking clean is skipped when the row changed meanwhile', () async {
      final pid = await localPet();
      await db.into(db.weights).insert(WeightsCompanion.insert(petId: pid, date: DateTime(2026), kg: 3));
      final out = await collectOutgoing(db, newId: () => 'new1', now: now);
      await db.applyingRemote(() => db.customStatement('UPDATE weights SET kg = 8, updated_at = 999999'));
      await out.writes.single.done();
      final w = (await weights()).single;
      expect(w.dirty, isTrue);
      expect(w.remoteId, isNull);
    });

    test('tombstones become deleted writes and pet removals', () async {
      final pid = await localPet();
      await db.applyingRemote(() => db.into(db.weights).insert(WeightsCompanion.insert(
          petId: pid, date: DateTime(2026), kg: 3, remoteId: const Value('w1'))));
      await db.delete(db.weights).go();
      await db.delete(db.pets).go();
      final out = await collectOutgoing(db, newId: newId, now: now);
      final w = out.writes.single;
      expect([w.path, w.data], ['pets/p1/weights/w1', {'deleted': true, 'updatedAt': 777}]);
      expect(out.removals.single.remoteId, 'p1');
      await w.done();
      await out.removals.single.done();
      expect(await db.select(db.syncDeletes).get(), isEmpty);
    });
  });
}
