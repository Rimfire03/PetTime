import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'db.g.dart';

enum RecordType { vaccine, dewormer, flea }

class Pets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get species => text().withDefault(const Constant('dog'))();
  TextColumn get breed => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get chip => text().nullable()();
  TextColumn get vetName => text().nullable()();
  TextColumn get vetPhone => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class HealthRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  IntColumn get type => intEnum<RecordType>()();
  TextColumn get product => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get nextDue => dateTime().nullable()();
  IntColumn get remindDaysBefore => integer().withDefault(const Constant(7))();
}

class Weights extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  RealColumn get kg => real()();
}

class Appointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();
  TextColumn get title => text()();
  TextColumn get place => text().nullable()();
  IntColumn get remindDaysBefore => integer().withDefault(const Constant(1))();
}

final db = AppDb();

@DriftDatabase(tables: [Pets, HealthRecords, Weights, Appointments])
class AppDb extends _$AppDb {
  AppDb() : super(driftDatabase(name: 'pettime'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
      );

  Stream<List<Pet>> watchPets() => select(pets).watch();

  Stream<List<Weight>> watchWeights(int petId) => (select(weights)
        ..where((w) => w.petId.equals(petId))
        ..orderBy([(w) => OrderingTerm.asc(w.date)]))
      .watch();

  Stream<List<Appointment>> watchAppointments(int petId) => (select(appointments)
        ..where((a) => a.petId.equals(petId))
        ..orderBy([(a) => OrderingTerm.asc(a.at)]))
      .watch();

  Stream<List<HealthRecord>> watchRecords(int petId) => (select(healthRecords)
        ..where((r) => r.petId.equals(petId))
        ..orderBy([(r) => OrderingTerm.desc(r.date)]))
      .watch();
}
