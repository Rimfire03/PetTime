import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/backup.dart';
import 'package:pettime/data/db.dart';
import 'package:pettime/photos.dart';

AppDb memoryDb() => AppDb.forTesting(NativeDatabase.memory());

void main() {
  late Directory photoDir;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true; // two in-memory dbs on purpose
    photoDir = Directory.systemTemp.createTempSync('pettime_photos_');
    initPhotosAt(photoDir);
  });
  tearDownAll(() => photoDir.deleteSync(recursive: true));

  test('export then import into another database restores everything', () async {
    final source = memoryDb();
    final target = memoryDb();
    addTearDown(source.close);
    addTearDown(target.close);

    const photo = '1700000000000001.jpg';
    photoFile(photo).writeAsBytesSync([1, 2, 3, 4]);

    final petId = await source.into(source.pets).insert(PetsCompanion.insert(
          name: 'Rex',
          breed: const Value('Labrador'),
          birthDate: Value(DateTime(2020, 5, 17)),
          photoPath: const Value(photo),
          notes: const Value('Allergic to chicken'),
        ));
    await source.into(source.healthRecords).insert(HealthRecordsCompanion.insert(
          petId: petId,
          type: RecordType.vaccine,
          product: 'Rabies',
          date: DateTime(2026, 1, 10),
          nextDue: Value(DateTime(2027, 1, 10)),
          remindDaysBefore: const Value(14),
        ));
    await source.into(source.weights).insert(
        WeightsCompanion.insert(petId: petId, date: DateTime(2026, 2, 1), kg: 31.5));
    await source.into(source.appointments).insert(AppointmentsCompanion.insert(
          petId: petId,
          at: DateTime(2026, 11, 5, 15, 30),
          title: 'Check-up',
          place: const Value('Vet clinic'),
        ));

    // data already on the target must be replaced, not merged
    await target.into(target.pets).insert(PetsCompanion.insert(name: 'Old pet'));

    // through real JSON text, like the file on disk
    final json = jsonDecode(jsonEncode(await buildBackup(source))) as Map<String, Object?>;
    photoFile(photo).deleteSync();
    await restoreBackup(json, target);

    final pets = await target.select(target.pets).get();
    expect(pets.map((p) => p.name), ['Rex']);
    expect(pets.single.breed, 'Labrador');
    expect(pets.single.birthDate, DateTime(2020, 5, 17));
    expect(pets.single.notes, 'Allergic to chicken');
    expect(pets.single.photoPath, photo);
    expect(photoFile(photo).readAsBytesSync(), [1, 2, 3, 4]);

    final record = (await target.select(target.healthRecords).get()).single;
    expect(record.petId, pets.single.id);
    expect(record.type, RecordType.vaccine);
    expect(record.product, 'Rabies');
    expect(record.nextDue, DateTime(2027, 1, 10));
    expect(record.remindDaysBefore, 14);

    expect((await target.select(target.weights).get()).single.kg, 31.5);
    final appt = (await target.select(target.appointments).get()).single;
    expect(appt.at, DateTime(2026, 11, 5, 15, 30));
    expect(appt.place, 'Vet clinic');
  });

  test('a photo name that is not one of ours is dropped on restore', () async {
    final target = memoryDb();
    addTearDown(target.close);
    final json = {
      'format': 'pettime-backup',
      'version': 1,
      'pets': [
        {'id': 1, 'name': 'Evil', 'species': 'dog', 'photoPath': '../escape.jpg'},
      ],
      'healthRecords': <Object>[],
      'weights': <Object>[],
      'appointments': <Object>[],
      'photos': {'../escape.jpg': base64Encode([9])},
    };
    await restoreBackup(json, target);

    expect((await target.select(target.pets).get()).single.photoPath, isNull);
    expect(File('${photoDir.parent.path}/escape.jpg').existsSync(), isFalse);
  });
}
