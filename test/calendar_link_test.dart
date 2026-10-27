import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/calendar_link.dart';

void main() {
  test('points at Google Calendar over https with a prefilled event', () {
    final u = googleCalendarUri(
      title: 'Nala - Vaccin & contrôle',
      start: DateTime.utc(2026, 11, 5, 14, 30),
      place: 'Clinique des Lilas',
      details: 'PetTime',
    );
    expect(u.scheme, 'https');
    expect(u.host, 'calendar.google.com');
    expect(u.path, '/calendar/render');
    expect(u.queryParameters['action'], 'TEMPLATE');
    expect(u.queryParameters['text'], 'Nala - Vaccin & contrôle'); // the & survives encoding
    expect(u.queryParameters['location'], 'Clinique des Lilas');
  });

  test('dates are UTC stamps with a one hour default length', () {
    final u = googleCalendarUri(title: 'x', start: DateTime.utc(2026, 11, 5, 14, 30));
    expect(u.queryParameters['dates'], '20261105T143000Z/20261105T153000Z');
  });

  test('a longer event and midnight rollover', () {
    final u = googleCalendarUri(title: 'x', start: DateTime.utc(2026, 12, 31, 23, 0), length: const Duration(hours: 2));
    expect(u.queryParameters['dates'], '20261231T230000Z/20270101T010000Z');
  });

  test('empty place and details are left out', () {
    final u = googleCalendarUri(title: 'x', start: DateTime.utc(2026, 1, 1), place: '', details: null);
    expect(u.queryParameters.containsKey('location'), isFalse);
    expect(u.queryParameters.containsKey('details'), isFalse);
  });
}
