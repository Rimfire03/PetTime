import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/breeds.dart';

void main() {
  test('every species with suggestions has a sizeable, duplicate-free list', () {
    for (final entry in breedsBySpecies.entries) {
      expect(entry.value.length, greaterThan(20), reason: entry.key);
      expect(entry.value.toSet().length, entry.value.length, reason: '${entry.key} has duplicates');
    }
  });

  test('names starting with the typed text come first', () {
    expect(suggestBreeds('dog', 'lab').first, 'Labrador Retriever');
    expect(suggestBreeds('cat', 'mai'), contains('Maine Coon'));
  });

  test('then names that merely contain it', () {
    final r = suggestBreeds('dog', 'retriever');
    expect(r, containsAll(['Golden Retriever', 'Labrador Retriever']));
  });

  test('ignores case and accents', () {
    expect(suggestBreeds('dog', 'EPAGNEUL'), contains('Épagneul breton'));
    expect(suggestBreeds('dog', 'berger'), contains('Berger allemand'));
    expect(suggestBreeds('cat', 'sacre'), contains('Sacré de Birmanie'));
  });

  test('suggestions depend on the species', () {
    expect(suggestBreeds('cat', 'labrador'), isEmpty);
    expect(suggestBreeds('rabbit', 'nain'), isNotEmpty);
  });

  test('no suggestion for nothing typed, an unknown species, or an exact match', () {
    expect(suggestBreeds('dog', ''), isEmpty);
    expect(suggestBreeds('dog', '   '), isEmpty);
    expect(suggestBreeds('other', 'a'), isEmpty);
    expect(suggestBreeds('dog', 'Beagle'), isEmpty);
  });

  test('at most the limit', () {
    expect(suggestBreeds('dog', 'a').length, lessThanOrEqualTo(8));
    expect(suggestBreeds('dog', 'a', limit: 3).length, 3);
  });
}
