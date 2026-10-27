import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/data/db.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late AppDb db;
  setUp(() => db = AppDb.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<Pet> onlyPet() async => (await db.select(db.pets).get()).single;

  test('a local insert is marked dirty with a timestamp', () async {
    await db.into(db.pets).insert(PetsCompanion.insert(name: 'Rex'));
    final p = await onlyPet();
    expect(p.dirty, isTrue);
    expect(p.updatedAt, greaterThan(0));
  });

  test('writes inside applyingRemote are not marked dirty', () async {
    await db.applyingRemote(() => db.into(db.pets).insert(PetsCompanion.insert(
        name: 'FromServer', remoteId: const Value('abc'), updatedAt: const Value(5))));
    final p = await onlyPet();
    expect(p.dirty, isNull);
    expect(p.updatedAt, 5);
  });

  test('a local edit of a synced row marks it dirty again', () async {
    await db.applyingRemote(() => db.into(db.pets).insert(
        PetsCompanion.insert(name: 'Rex', remoteId: const Value('abc'), updatedAt: const Value(5))));
    await (db.update(db.pets)).write(const PetsCompanion(name: Value('Rexy')));
    final p = await onlyPet();
    expect(p.dirty, isTrue);
    expect(p.updatedAt, greaterThan(5));
  });

  test('deleting a synced child leaves a tombstone, an unsynced one does not', () async {
    late int petId;
    await db.applyingRemote(() async {
      petId = await db.into(db.pets).insert(
          PetsCompanion.insert(name: 'Rex', remoteId: const Value('pet-1')));
      await db.into(db.weights).insert(WeightsCompanion.insert(
          petId: petId, date: DateTime(2026), kg: 3, remoteId: const Value('w-1')));
    });
    await db.into(db.weights).insert(WeightsCompanion.insert(petId: petId, date: DateTime(2026), kg: 4));

    await db.delete(db.weights).go();

    final t = await db.select(db.syncDeletes).get();
    expect(t.single.kind, 'weights');
    expect(t.single.petRemoteId, 'pet-1');
    expect(t.single.remoteId, 'w-1');
  });

  test('deleting a synced pet leaves one pet tombstone; remote deletes leave none', () async {
    await db.applyingRemote(() => db.into(db.pets).insert(
        PetsCompanion.insert(name: 'Rex', remoteId: const Value('pet-1'))));
    await db.delete(db.pets).go();
    expect((await db.select(db.syncDeletes).get()).map((d) => d.kind), ['pets']);

    await db.applyingRemote(() => db.into(db.pets).insert(
        PetsCompanion.insert(name: 'Max', remoteId: const Value('pet-2'))));
    await db.applyingRemote(() => db.delete(db.pets).go());
    expect((await db.select(db.syncDeletes).get()).length, 1);
  });
}
