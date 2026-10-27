import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/drift.dart' show InsertMode, Value;
import 'package:file_picker/file_picker.dart';

import 'data/db.dart';
import 'photos.dart';

const _format = 'pettime-backup';
const _version = 1;

/// All data plus photos as one JSON document, so a backup restores on any
/// platform (Android <-> iOS) and does not depend on the SQLite file layout.
Future<Map<String, Object?>> buildBackup() async {
  final pets = await db.select(db.pets).get();
  final photos = <String, String>{};
  for (final p in pets) {
    final name = p.photoPath;
    if (name == null) continue;
    final f = photoFile(name);
    if (f.existsSync()) photos[name] = base64Encode(f.readAsBytesSync());
  }
  return {
    'format': _format,
    'version': _version,
    'pets': [for (final p in pets) p.toJson()],
    'healthRecords': [for (final r in await db.select(db.healthRecords).get()) r.toJson()],
    'weights': [for (final w in await db.select(db.weights).get()) w.toJson()],
    'appointments': [for (final a in await db.select(db.appointments).get()) a.toJson()],
    'photos': photos,
  };
}

/// Replaces ALL current data with the backup. Throws [FormatException] on a
/// file that is not a PetTime backup; in that case nothing is changed.
Future<void> restoreBackup(Map<String, Object?> json) async {
  if (json['format'] != _format || json['version'] != _version) {
    throw const FormatException('not a PetTime backup');
  }
  List<Map<String, Object?>> rows(String key) =>
      [for (final e in json[key]! as List) (e as Map).cast<String, Object?>()];

  final photos = <String, List<int>>{
    for (final e in (json['photos']! as Map).entries)
      if (isValidPhotoName(e.key as String)) e.key as String: base64Decode(e.value as String),
  };
  // parse everything before touching the database
  final pets = [
    for (final r in rows('pets'))
      Pet.fromJson(r).copyWith(
        photoPath: Value(photos.containsKey(r['photoPath']) ? r['photoPath'] as String? : null),
      ),
  ];
  final records = [for (final r in rows('healthRecords')) HealthRecord.fromJson(r)];
  final weights = [for (final r in rows('weights')) Weight.fromJson(r)];
  final appointments = [for (final r in rows('appointments')) Appointment.fromJson(r)];

  await db.transaction(() async {
    await db.delete(db.pets).go(); // cascades to the other tables
    await db.batch((b) {
      b.insertAll(db.pets, pets, mode: InsertMode.insertOrReplace);
      b.insertAll(db.healthRecords, records, mode: InsertMode.insertOrReplace);
      b.insertAll(db.weights, weights, mode: InsertMode.insertOrReplace);
      b.insertAll(db.appointments, appointments, mode: InsertMode.insertOrReplace);
    });
  });
  replaceAllPhotos(photos);
}

/// Opens the system save dialog (on phones this reaches Drive / iCloud Drive).
/// Returns false if the user cancelled.
Future<bool> exportBackupFile() async {
  final bytes = Uint8List.fromList(utf8.encode(jsonEncode(await buildBackup())));
  final stamp = DateTime.now().toIso8601String().substring(0, 10);
  final saved = await FilePicker.saveFile(fileName: 'pettime-$stamp.pettime', bytes: bytes);
  return saved != null;
}

/// Lets the user pick a backup and returns its parsed content, or null if cancelled.
Future<Map<String, Object?>?> pickBackupFile() async {
  final file = await FilePicker.pickFile();
  if (file == null) return null;
  final decoded = jsonDecode(utf8.decode(await file.xFile.readAsBytes()));
  if (decoded is! Map) throw const FormatException('not a PetTime backup');
  return decoded.cast<String, Object?>();
}
