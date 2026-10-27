import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/care_catalog.dart';
import 'package:pettime/data/db.dart';

void main() {
  group('catalogue', () {
    test('every vaccine suggestion proposes a repeat rhythm, every operation is a one-off', () {
      for (final species in careCatalog.values) {
        for (final v in species[RecordType.vaccine] ?? const <CareSuggestion>[]) {
          expect(v.repeatMonths, isNotNull, reason: v.en);
        }
        for (final o in species[RecordType.operation] ?? const <CareSuggestion>[]) {
          expect(o.repeatMonths, isNull, reason: o.en);
        }
      }
    });

    test('names exist in French and English, without duplicates in a list', () {
      for (final species in careCatalog.entries) {
        for (final list in species.value.values) {
          expect(list.map((s) => s.fr).toSet().length, list.length, reason: species.key);
          for (final s in list) {
            expect(s.fr.trim(), isNotEmpty);
            expect(s.en.trim(), isNotEmpty);
          }
        }
      }
    });

    test('language: French for French, English otherwise', () {
      const s = CareSuggestion('Rage', 'Rabies', repeatMonths: 12);
      expect(s.nameFor('fr'), 'Rage');
      expect(s.nameFor('en'), 'Rabies');
      expect(s.nameFor('de'), 'Rabies');
    });
  });

  group('suggestCare', () {
    test('an empty query offers the whole list of that species and kind of care', () {
      expect(suggestCare('dog', RecordType.vaccine, '', 'fr').length, greaterThan(3));
    });

    test('depends on species and kind of care', () {
      expect(suggestCare('rabbit', RecordType.vaccine, 'myxo', 'fr').map((s) => s.fr), contains('Myxomatose'));
      expect(suggestCare('cat', RecordType.vaccine, 'lyme', 'fr'), isEmpty);
      expect(suggestCare('rabbit', RecordType.flea, '', 'fr'), isEmpty);
      expect(suggestCare('other', RecordType.vaccine, '', 'fr'), isEmpty);
    });

    test('matches French or English names, ignoring case and accents', () {
      expect(suggestCare('dog', RecordType.vaccine, 'RABIES', 'fr').map((s) => s.fr), contains('Rage'));
      expect(suggestCare('dog', RecordType.vaccine, 'borreliose', 'en'), isNotEmpty);
      expect(suggestCare('dog', RecordType.operation, 'sterilisation', 'fr'), isNotEmpty);
    });
  });

  group('addMonths', () {
    test('adds whole months', () {
      expect(addMonths(DateTime(2026, 3, 15), 12), DateTime(2027, 3, 15));
      expect(addMonths(DateTime(2026, 11, 10), 3), DateTime(2027, 2, 10));
      expect(addMonths(DateTime(2026, 1, 1), 1), DateTime(2026, 2, 1));
    });

    test('keeps the last day of a shorter month', () {
      expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
      expect(addMonths(DateTime(2027, 12, 31), 2), DateTime(2028, 2, 29));
      expect(addMonths(DateTime(2026, 8, 31), 6), DateTime(2027, 2, 28));
    });
  });
}
