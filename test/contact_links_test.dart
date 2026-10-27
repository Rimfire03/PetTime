import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/contact_links.dart';

void main() {
  group('phoneUri', () {
    test('keeps digits and a leading +', () {
      expect(phoneUri('+33 6 12 34 56 78').toString(), 'tel:+33612345678');
      expect(phoneUri('01.23.45.67.89').toString(), 'tel:0123456789');
    });
    test('refuses empty or too short input', () {
      expect(phoneUri(null), isNull);
      expect(phoneUri(''), isNull);
      expect(phoneUri('12'), isNull);
      expect(phoneUri('abc'), isNull);
    });
    test('strips anything that is not a digit, so nothing is injected', () {
      expect(phoneUri('0123;rm -rf').toString(), 'tel:0123');
    });
  });

  group('webUri', () {
    test('adds https when the scheme is missing', () {
      expect(webUri('example.com/book').toString(), 'https://example.com/book');
    });
    test('keeps http and https links', () {
      expect(webUri(' http://example.com ').toString(), 'http://example.com');
      expect(webUri('https://example.com/a?b=1').toString(), 'https://example.com/a?b=1');
    });
    test('refuses other schemes and empty input', () {
      expect(webUri('javascript:alert(1)'), isNull);
      expect(webUri('file:///etc/passwd'), isNull);
      expect(webUri('intent://x#Intent;end'), isNull);
      expect(webUri(''), isNull);
      expect(webUri(null), isNull);
    });
  });
}
