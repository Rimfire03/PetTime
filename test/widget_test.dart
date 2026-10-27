import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/l10n/app_localizations.dart';

void main() {
  test('all 6 locales supported', () {
    expect(AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
        {'en', 'fr', 'es', 'de', 'it', 'pt'});
  });
}
