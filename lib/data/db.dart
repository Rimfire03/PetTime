import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'db.g.dart';

// new values go at the END: the index is what is stored in the database and on the server
enum RecordType { vaccine, dewormer, flea, operation }

/// Habitual services around the pet. Same rule: append only.
enum ContactKind { groomer, petSitter, boarding, other }

/// Sync bookkeeping. All three are null for data that never left this phone.
/// updatedAt (ms) and dirty are maintained by SQL triggers (see AppDb), so
/// every local edit is tracked without touching the screens.
mixin SyncColumns on Table {
  TextColumn get remoteId => text().nullable()();
  IntColumn get updatedAt => integer().nullable()();
  BoolColumn get dirty => boolean().nullable()();
}

class Pets extends Table with SyncColumns {
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
  TextColumn get sex => text().nullable()(); // 'male' | 'female', null = unknown
  TextColumn get color => text().nullable()();
}

class HealthRecords extends Table with SyncColumns {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  IntColumn get type => intEnum<RecordType>()();
  TextColumn get product => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get nextDue => dateTime().nullable()();
  IntColumn get remindDaysBefore => integer().withDefault(const Constant(7))();
}

class Weights extends Table with SyncColumns {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  RealColumn get kg => real()();
}

class Appointments extends Table with SyncColumns {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();
  TextColumn get title => text()();
  TextColumn get place => text().nullable()();
  IntColumn get remindDaysBefore => integer().withDefault(const Constant(1))();
}

/// A groomer, pet sitter or boarding the pet usually goes to.
class PetContacts extends Table with SyncColumns {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get petId => integer().references(Pets, #id, onDelete: KeyAction.cascade)();
  IntColumn get kind => intEnum<ContactKind>()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get notes => text().nullable()();
}

/// Rows deleted locally that the server must still hear about.
/// [kind] is the table name ('pets', 'health_records', 'weights', 'appointments').
class SyncDeletes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind => text()();
  TextColumn get petRemoteId => text()();
  TextColumn get remoteId => text()();
}

/// One row. applying = 1 while remote changes are written locally, so the
/// triggers do not mistake them for user edits.
class SyncFlags extends Table {
  IntColumn get applying => integer().withDefault(const Constant(0))();
}

/// The app's database. Not final only so a test can swap in an in-memory one.
AppDb db = AppDb();

const _syncTables = ['pets', 'health_records', 'weights', 'appointments'];

@DriftDatabase(tables: [Pets, HealthRecords, Weights, Appointments, PetContacts, SyncDeletes, SyncFlags])
class AppDb extends _$AppDb {
  AppDb() : super(driftDatabase(name: 'pettime'));

  /// For tests: pass e.g. NativeDatabase.memory().
  AppDb.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _initSync();
          await _createSyncTriggers('pet_contacts');
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(pets, pets.remoteId);
            await m.addColumn(pets, pets.updatedAt);
            await m.addColumn(pets, pets.dirty);
            await m.addColumn(healthRecords, healthRecords.remoteId);
            await m.addColumn(healthRecords, healthRecords.updatedAt);
            await m.addColumn(healthRecords, healthRecords.dirty);
            await m.addColumn(weights, weights.remoteId);
            await m.addColumn(weights, weights.updatedAt);
            await m.addColumn(weights, weights.dirty);
            await m.addColumn(appointments, appointments.remoteId);
            await m.addColumn(appointments, appointments.updatedAt);
            await m.addColumn(appointments, appointments.dirty);
            await m.createTable(syncDeletes);
            await m.createTable(syncFlags);
            await _initSync();
          }
          if (from < 3) {
            await m.createTable(petContacts);
            await _createSyncTriggers('pet_contacts');
          }
          if (from < 4) {
            await m.addColumn(pets, pets.sex);
            await m.addColumn(pets, pets.color);
          }
        },
        beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
      );

  Future<void> _initSync() async {
    await customStatement('INSERT INTO sync_flags (applying) VALUES (0)');
    for (final t in _syncTables) {
      await _createSyncTriggers(t);
    }
  }

  Future<void> _createSyncTriggers(String t) async {
    const applying = '(SELECT applying FROM sync_flags) = 0';
    const now = "CAST(strftime('%s','now') AS INTEGER) * 1000";
    for (final op in ['INSERT', 'UPDATE']) {
      await customStatement('CREATE TRIGGER ${t}_${op.toLowerCase()}_sync AFTER $op ON $t '
          'WHEN $applying BEGIN '
          'UPDATE $t SET dirty = 1, updated_at = $now WHERE id = NEW.id; END');
    }
    // a child's tombstone needs its pet's remote id; a pet is its own parent
    final parent = t == 'pets'
        ? "SELECT OLD.remote_id, OLD.remote_id"
        : 'SELECT remote_id, OLD.remote_id FROM pets WHERE id = OLD.pet_id AND remote_id IS NOT NULL';
    await customStatement('CREATE TRIGGER ${t}_delete_sync AFTER DELETE ON $t '
        'WHEN $applying AND OLD.remote_id IS NOT NULL BEGIN '
        "INSERT INTO sync_deletes (kind, pet_remote_id, remote_id) SELECT '$t', * FROM ($parent); END");
  }

  /// Runs [body] with the triggers silenced: use for every write that comes
  /// from the server or from sync bookkeeping, never for user edits.
  Future<T> applyingRemote<T>(Future<T> Function() body) => transaction(() async {
        await customStatement('UPDATE sync_flags SET applying = 1');
        try {
          return await body();
        } finally {
          await customStatement('UPDATE sync_flags SET applying = 0');
        }
      });

  Stream<List<Pet>> watchPets() => select(pets).watch();

  Stream<List<PetContact>> watchContacts(int petId) => (select(petContacts)
        ..where((c) => c.petId.equals(petId))
        ..orderBy([(c) => OrderingTerm.asc(c.kind), (c) => OrderingTerm.asc(c.name)]))
      .watch();

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
