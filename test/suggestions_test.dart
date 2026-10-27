import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/suggestions.dart';

void main() {
  test('foldText drops case and accents', () => expect(foldText('Épagneul Bréton'), 'epagneul breton'));

  group('filterSuggestions', () {
    const all = ['Golden', 'Brindle', 'Bleu', 'Noir et blanc', 'Blanc'];
    test('starts-with before contains', () => expect(filterSuggestions(all, 'bl'), ['Bleu', 'Blanc', 'Noir et blanc']));
    test('accent and case insensitive', () => expect(filterSuggestions(['Crème'], 'CREM'), ['Crème']));
    test('exact match returns nothing', () => expect(filterSuggestions(all, 'blanc'), isEmpty));
    test('empty query', () {
      expect(filterSuggestions(all, ''), isEmpty);
      expect(filterSuggestions(all, ' ', allWhenEmpty: true), all);
    });
    test('limit', () => expect(filterSuggestions(all, '', allWhenEmpty: true, limit: 2), ['Golden', 'Brindle']));
  });

  test('colorsFor', () {
    expect(colorsFor('dog', 'fr'), contains('Noir'));
    expect(colorsFor('dog', 'de'), contains('Black'));
    expect(colorsFor('other', 'fr'), isEmpty);
  });

  test('reasonsFor', () {
    expect(reasonsFor('fr'), contains('Vaccination'));
    expect(reasonsFor('en'), contains('Annual check-up'));
    expect(reasonsFor('fr').length, reasonsFor('en').length);
  });
}
