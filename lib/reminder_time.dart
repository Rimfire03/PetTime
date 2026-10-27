const reminderHour = 9; // reminders fire at 09:00 local time

/// When to notify for a due date, or null if that moment is already past.
/// Past reminders are skipped (not fired late) so reopening the app never
/// repeats an alert.
DateTime? reminderTime(DateTime due, int daysBefore, DateTime now) {
  final at = DateTime(due.year, due.month, due.day - daysBefore, reminderHour);
  return at.isAfter(now) ? at : null;
}
