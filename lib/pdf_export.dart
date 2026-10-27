import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'data/db.dart';
import 'l10n/app_localizations.dart';
import 'photos.dart';
import 'screens/pet_detail_screen.dart' show recordLabel;
import 'screens/pets_screen.dart' show speciesLabel;

/// Builds the pet's health book (identity, vaccines/treatments, weights) as a
/// PDF and hands it to the system share / save dialog.
Future<void> exportHealthBookPdf(BuildContext context, Pet pet) async {
  final t = AppLocalizations.of(context);
  final fmt = DateFormat.yMd(Localizations.localeOf(context).toString());

  final records = await (db.select(db.healthRecords)
        ..where((r) => r.petId.equals(pet.id))
        ..orderBy([(r) => OrderingTerm.desc(r.date)]))
      .get();
  final weights = await (db.select(db.weights)
        ..where((w) => w.petId.equals(pet.id))
        ..orderBy([(w) => OrderingTerm.asc(w.date)]))
      .get();

  final photo = pet.photoPath == null ? null : photoFile(pet.photoPath!);
  final photoImage = photo != null && photo.existsSync() ? pw.MemoryImage(photo.readAsBytesSync()) : null;

  final info = <(String, String?)>[
    (t.species, speciesLabel(t, pet.species)),
    (t.breed, pet.breed),
    (t.birthDate, pet.birthDate == null ? null : fmt.format(pet.birthDate!)),
    (t.chip, pet.chip),
    (t.vetName, pet.vetName),
    (t.vetPhone, pet.vetPhone),
    (t.notes, pet.notes),
  ];

  final doc = pw.Document();
  doc.addPage(pw.MultiPage(
    build: (_) => [
      pw.Header(level: 0, text: '${pet.name} - ${t.healthBook}'),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        if (photoImage != null)
          pw.Container(
              width: 90,
              height: 90,
              margin: const pw.EdgeInsets.only(right: 16),
              child: pw.Image(photoImage, fit: pw.BoxFit.cover)),
        pw.Expanded(
          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            for (final (label, value) in info)
              if (value != null) pw.Text('$label: $value'),
          ]),
        ),
      ]),
      pw.SizedBox(height: 16),
      pw.Header(level: 1, text: t.healthBook),
      if (records.isEmpty)
        pw.Text(t.noRecords)
      else
        pw.TableHelper.fromTextArray(
          headers: ['', t.product, t.date, t.nextDue],
          data: [
            for (final r in records)
              [
                recordLabel(t, r.type),
                r.product,
                fmt.format(r.date),
                r.nextDue == null ? '-' : fmt.format(r.nextDue!),
              ],
          ],
        ),
      pw.SizedBox(height: 16),
      pw.Header(level: 1, text: t.weight),
      if (weights.isEmpty)
        pw.Text(t.noWeights)
      else
        pw.TableHelper.fromTextArray(
          headers: [t.date, t.weightKg],
          data: [
            for (final w in weights) [fmt.format(w.date), '${w.kg}'],
          ],
        ),
    ],
  ));

  // ASCII-only file name: accents and emoji are not safe in every file system
  final safe = pet.name.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
  await Printing.sharePdf(bytes: await doc.save(), filename: '$safe-health-book.pdf');
}
