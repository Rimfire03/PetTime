// Renders the app's real screens with sample data to PNG files for the Play Store listing.
// Not part of the normal test run: STORE_SHOTS=1 flutter test test/store_screenshots_test.dart
// Output: build/store_screenshots/*.png (1080x1920).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/data/db.dart';
import 'package:pettime/l10n/app_localizations.dart';
import 'package:pettime/screens/pet_detail_screen.dart';
import 'package:pettime/screens/pet_wizard_screen.dart';
import 'package:pettime/screens/pets_screen.dart';

const _sdkFonts = r'C:\src\flutter\bin\cache\artifacts\material_fonts';

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final f in files) {
    final bytes = File('$_sdkFonts\\$f').readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

void main() {
  final enabled = Platform.environment['STORE_SHOTS'] == '1';

  testWidgets('store screenshots', (tester) async {
    await _loadFont('Roboto', ['roboto-regular.ttf', 'roboto-medium.ttf', 'roboto-bold.ttf'].where((f) => File('$_sdkFonts\\$f').existsSync()).toList());
    await _loadFont('MaterialIcons', ['materialicons-regular.otf']);
    final emoji = File(r'C:\Windows\Fonts\seguiemj.ttf'); // colour emoji for the species tiles
    if (emoji.existsSync()) {
      final l = FontLoader('Emoji')..addFont(Future.value(ByteData.sublistView(emoji.readAsBytesSync())));
      await l.load();
    }

    FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTouch; // no keyboard focus ring on the buttons
    db = AppDb.forTesting(NativeDatabase.memory());
    final t = lookupAppLocalizations(const Locale('fr'));
    await _seed();

    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final key = GlobalKey();
    Future<void> show(Widget home) async {
      await tester.pumpWidget(RepaintBoundary(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('fr'),
          theme: ThemeData(colorSchemeSeed: const Color(0xFFF2784B), useMaterial3: true, fontFamily: 'Roboto', fontFamilyFallback: const ['Emoji'], focusColor: Colors.transparent, floatingActionButtonTheme: const FloatingActionButtonThemeData(focusColor: Colors.transparent, focusElevation: 6)),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        ),
      ));
      await settle();
    }

    final out = Directory('build/store_screenshots')..createSync(recursive: true);
    Future<void> shot(String name) async {
      FocusManager.instance.primaryFocus?.unfocus();
      await settle();
      await tester.runAsync(() async {
        final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 3);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        File('${out.path}/$name.png').writeAsBytesSync(data!.buffer.asUint8List());
      });
    }

    Future<void> tapText(String text) async {
      await tester.tap(find.text(text).first);
      await settle();
    }

    // 1. pet list
    await show(const PetsScreen());
    await shot('01_mes_animaux');

    // 2-6. one pet, every tab
    final pets = await db.select(db.pets).get();
    final biscotte = pets.firstWhere((p) => p.name == 'Biscotte');
    await show(PetDetailScreen(petId: biscotte.id));
    await shot('02_fiche_animal');
    await tapText(t.healthBook);
    await shot('03_carnet_de_sante');
    await tapText(t.weight);
    await shot('04_courbe_de_poids');
    await tapText(t.appointments);
    await shot('05_rendez_vous');
    await tapText(t.services);
    await shot('06_services');

    // 7. creation wizard
    await show(const PetWizardScreen());
    await tester.enterText(find.byType(TextField).first, 'Biscotte');
    await settle();
    await tapText(t.next);
    await shot('07_creation_pas_a_pas');
  }, skip: !enabled);
}

/// Lets drift's streams and the widgets catch up (real timers need runAsync).
Future<void> settle() async {
  final binding = TestWidgetsFlutterBinding.instance;
  for (var i = 0; i < 6; i++) {
    await binding.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 60)));
    await binding.pump(const Duration(milliseconds: 120));
  }
}

Future<void> _seed() async {
  Future<int> pet(String name, String species, String breed, String sex, DateTime birth, {String? vet, String? vetPhone, String? chip, String? color}) =>
      db.into(db.pets).insert(PetsCompanion.insert(
            name: name,
            species: Value(species),
            breed: Value(breed),
            sex: Value(sex),
            birthDate: Value(birth),
            color: Value(color),
            chip: Value(chip),
            vetName: Value(vet),
            vetPhone: Value(vetPhone),
          ));

  final biscotte = await pet('Biscotte', 'dog', 'Golden retriever', 'female', DateTime(2021, 3, 12),
      vet: 'Clinique vétérinaire des Lilas', vetPhone: '01 23 45 67 89', chip: '250268500123456', color: 'Doré');
  final pixel = await pet('Pixel', 'cat', 'Européen', 'male', DateTime(2022, 7, 2), color: 'Gris tigré');
  // late and no appointment planned: shows the notice on the pet list
  await db.into(db.healthRecords).insert(HealthRecordsCompanion.insert(
      petId: pixel, type: RecordType.vaccine, product: 'Typhus, coryza, leucose (TCL)', date: DateTime(2025, 9, 10), nextDue: Value(DateTime(2026, 9, 10))));
  await pet('Noisette', 'rabbit', 'Bélier nain', 'female', DateTime(2024, 1, 20), color: 'Marron');

  Future<void> record(RecordType type, String product, DateTime date, DateTime? next) => db.into(db.healthRecords).insert(
      HealthRecordsCompanion.insert(petId: biscotte, type: type, product: product, date: date, nextDue: Value(next)));
  await record(RecordType.vaccine, 'CHPPiL (carré, hépatite, parvovirose, parainfluenza, leptospirose)', DateTime(2026, 3, 15), DateTime(2027, 3, 15));
  await record(RecordType.vaccine, 'Rage', DateTime(2026, 3, 15), DateTime(2027, 3, 15));
  await record(RecordType.dewormer, 'Milbemax', DateTime(2026, 9, 2), DateTime(2026, 12, 2));
  await record(RecordType.flea, 'NexGard Spectra', DateTime(2026, 10, 10), DateTime(2026, 11, 10));
  await record(RecordType.operation, 'Stérilisation', DateTime(2022, 5, 4), null);

  final kg = [27.6, 27.9, 28.1, 28.0, 28.4, 28.6, 28.5, 28.9, 29.0, 29.2, 29.1, 29.4];
  for (var i = 0; i < kg.length; i++) {
    await db.into(db.weights).insert(WeightsCompanion.insert(petId: biscotte, date: DateTime(2025, 11 + i, 1), kg: kg[i]));
  }

  await db.into(db.appointments).insert(AppointmentsCompanion.insert(
      petId: biscotte, at: DateTime(2026, 11, 18, 10, 30), title: 'Visite annuelle', place: const Value('Clinique vétérinaire des Lilas')));
  await db.into(db.appointments).insert(AppointmentsCompanion.insert(
      petId: biscotte, at: DateTime(2026, 12, 6, 14, 0), title: 'Toilettage', place: const Value('Salon Les Poils Soyeux')));

  Future<void> contact(ContactKind kind, String name, String phone, String address) => db.into(db.petContacts).insert(
      PetContactsCompanion.insert(petId: biscotte, kind: kind, name: name, phone: Value(phone), address: Value(address)));
  await contact(ContactKind.groomer, 'Salon Les Poils Soyeux', '01 98 76 54 32', '12 rue des Acacias, Lyon');
  await contact(ContactKind.petSitter, 'Camille, pet sitter', '06 12 34 56 78', 'Lyon 6e');
  await contact(ContactKind.boarding, 'Pension Le Chêne', '04 11 22 33 44', 'Route de Vienne, Chaponnay');
}
