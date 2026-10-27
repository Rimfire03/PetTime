const reminderHour = 9; // reminders fire at 09:00 local time

/// Notification ids for appointments start here so they never clash with record ids.
const appointmentNotificationBase = 1000000;

/// Same day-based rule as [reminderTime], but a same-day appointment (0 days)
/// is announced 1 hour before it starts instead of at 09:00.
DateTime? appointmentReminderTime(DateTime at, int daysBefore, DateTime now) {
  if (daysBefore > 0) return reminderTime(at, daysBefore, now);
  final fire = at.subtract(const Duration(hours: 1));
  return fire.isAfter(now) ? fire : null;
}

/// When to notify for a due date, or null if that moment is already past.
/// Past reminders are skipped (not fired late) so reopening the app never
/// repeats an alert.
DateTime? reminderTime(DateTime due, int daysBefore, DateTime now) {
  final at = DateTime(due.year, due.month, due.day - daysBefore, reminderHour);
  return at.isAfter(now) ? at : null;
}
