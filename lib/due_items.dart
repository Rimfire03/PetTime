import 'data/db.dart';

/// A care whose next due date has passed.
class OverdueCare {
  const OverdueCare(this.record);
  final HealthRecord record;
  DateTime get due => record.nextDue!;
}

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

String _key(HealthRecord r) => '${r.type.index}|${r.product.trim().toLowerCase()}';

/// Cares of one pet that are past due and not already redone by a later entry of the same care.
/// Renewing a vaccine adds a new record, so the old one keeps its past "next due" date for ever: it must not
/// count as late once a newer record of the same type and product exists.
List<OverdueCare> overdueCares(List<HealthRecord> records, DateTime now) {
  final today = _day(now);
  final late = <OverdueCare>[];
  for (final r in records) {
    final due = r.nextDue;
    if (due == null || !_day(due).isBefore(today)) continue;
    final renewed = records.any((o) => o.id != r.id && _key(o) == _key(r) && o.date.isAfter(r.date));
    if (!renewed) late.add(OverdueCare(r));
  }
  late.sort((a, b) => a.due.compareTo(b.due));
  return late;
}

/// True when the pet has an appointment that has not started yet.
bool hasUpcomingAppointment(List<Appointment> appointments, DateTime now) => appointments.any((a) => !a.at.isBefore(now));

/// A line of the short "what is coming" summary: a care due date or an appointment.
class UpcomingEntry {
  const UpcomingEntry({required this.when, required this.record, required this.appointment});
  final DateTime when;
  final HealthRecord? record;
  final Appointment? appointment;
}

/// The next [limit] cares due (today or later, not already renewed) and appointments, soonest first.
List<UpcomingEntry> upcomingEntries(List<HealthRecord> records, List<Appointment> appointments, DateTime now, {int limit = 3}) {
  final today = _day(now);
  final out = <UpcomingEntry>[
    for (final r in records)
      if (r.nextDue != null &&
          !_day(r.nextDue!).isBefore(today) &&
          !records.any((o) => o.id != r.id && _key(o) == _key(r) && o.date.isAfter(r.date)))
        UpcomingEntry(when: r.nextDue!, record: r, appointment: null),
    for (final a in appointments)
      if (!a.at.isBefore(now)) UpcomingEntry(when: a.at, record: null, appointment: a),
  ]..sort((a, b) => a.when.compareTo(b.when));
  return out.take(limit).toList();
}
