import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/data/db.dart';
import 'package:pettime/due_items.dart';

HealthRecord rec(int id, String product, DateTime date, DateTime? next, {RecordType type = RecordType.vaccine}) => HealthRecord(
    id: id, petId: 1, type: type, product: product, date: date, nextDue: next, remindDaysBefore: 7);

Appointment appt(int id, DateTime at) => Appointment(id: id, petId: 1, at: at, title: 'Vet', remindDaysBefore: 1);

void main() {
  final now = DateTime(2026, 10, 30, 12);

  test('a past next due date is overdue; today and the future are not', () {
    final r = [
      rec(1, 'Rage', DateTime(2025, 3, 1), DateTime(2026, 3, 1)),
      rec(2, 'Lyme', DateTime(2025, 10, 30), DateTime(2026, 10, 30)), // due today
      rec(3, 'TC', DateTime(2026, 1, 1), DateTime(2027, 1, 1)),
    ];
    expect(overdueCares(r, now).map((o) => o.record.product), ['Rage']);
  });

  test('a care renewed by a later entry of the same product is no longer overdue', () {
    final r = [
      rec(1, 'Rage', DateTime(2024, 3, 1), DateTime(2025, 3, 1)),
      rec(2, ' rage ', DateTime(2025, 3, 5), DateTime(2026, 3, 5)), // renewed, but this one is now late too
    ];
    expect(overdueCares(r, now).map((o) => o.record.id), [2]);
    r.add(rec(3, 'Rage', DateTime(2026, 4, 1), DateTime(2027, 4, 1)));
    expect(overdueCares(r, now), isEmpty);
  });

  test('a different type with the same name does not renew', () {
    final r = [
      rec(1, 'X', DateTime(2025, 1, 1), DateTime(2026, 1, 1)),
      rec(2, 'X', DateTime(2026, 2, 1), null, type: RecordType.flea),
    ];
    expect(overdueCares(r, now).length, 1);
  });

  test('appointment check ignores past appointments', () {
    expect(hasUpcomingAppointment([appt(1, DateTime(2026, 10, 1))], now), isFalse);
    expect(hasUpcomingAppointment([appt(1, DateTime(2026, 11, 5))], now), isTrue);
    expect(hasUpcomingAppointment(const [], now), isFalse);
  });

  test('upcoming entries mix cares and appointments, soonest first, limited', () {
    final r = [
      rec(1, 'A', DateTime(2026, 1, 1), DateTime(2026, 12, 1)),
      rec(2, 'B', DateTime(2026, 1, 1), DateTime(2026, 11, 20)),
      rec(3, 'Old', DateTime(2025, 1, 1), DateTime(2026, 1, 1)), // overdue: not listed
      rec(4, 'C', DateTime(2026, 1, 1), DateTime(2027, 5, 1)),
    ];
    final a = [appt(1, DateTime(2026, 11, 5, 10)), appt(2, DateTime(2026, 9, 1))];
    final u = upcomingEntries(r, a, now);
    expect(u.length, 3);
    expect(u[0].appointment?.id, 1);
    expect(u[1].record?.product, 'B');
    expect(u[2].record?.product, 'A');
  });
}
