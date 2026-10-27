import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/reminder_time.dart';

void main() {
  final now = DateTime(2026, 10, 27, 12);

  test('fires N days before at 09:00', () {
    expect(reminderTime(DateTime(2026, 11, 10), 7, now), DateTime(2026, 11, 3, 9));
  });

  test('0 days means the due day itself', () {
    expect(reminderTime(DateTime(2026, 10, 28), 0, now), DateTime(2026, 10, 28, 9));
  });

  test('crosses month and year boundaries', () {
    expect(reminderTime(DateTime(2027, 1, 2), 5, DateTime(2026, 12, 1)), DateTime(2026, 12, 28, 9));
  });

  test('past reminder is skipped, even if due date is ahead', () {
    expect(reminderTime(DateTime(2026, 10, 30), 7, now), isNull);
  });

  test('today 09:00 already passed is skipped', () {
    expect(reminderTime(DateTime(2026, 10, 27), 0, now), isNull);
  });
}
