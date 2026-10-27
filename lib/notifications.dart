import 'dart:ui';

import 'package:drift/drift.dart' show innerJoin;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'data/db.dart';
import 'l10n/app_localizations.dart';
import 'screens/pet_detail_screen.dart' show recordLabel;

final _plugin = FlutterLocalNotificationsPlugin();

const _hour = 9; // reminders fire at 09:00 local time

Future<void> initNotifications() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation((await FlutterTimezone.getLocalTimezone()).identifier));
  await _plugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    ),
  );
  await _plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  await _plugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
}

/// Cancels everything and re-schedules one notification per future reminder.
/// Idempotent, so it is simply re-run whenever pets or records change.
Future<void> rescheduleAll() async {
  final t = _l10n();
  final fmt = DateFormat.yMd(PlatformDispatcher.instance.locale.toString());
  final now = tz.TZDateTime.now(tz.local);
  final rows = await (db.select(db.healthRecords).join([
    innerJoin(db.pets, db.pets.id.equalsExp(db.healthRecords.petId)),
  ])
        ..where(db.healthRecords.nextDue.isNotNull()))
      .get();

  await _plugin.cancelAll();
  for (final row in rows) {
    final r = row.readTable(db.healthRecords);
    final pet = row.readTable(db.pets);
    final due = r.nextDue!;
    final fireDay = DateTime(due.year, due.month, due.day - r.remindDaysBefore);
    var fireAt = tz.TZDateTime(tz.local, fireDay.year, fireDay.month, fireDay.day, _hour);
    // reminder day already passed but due date still ahead: remind shortly
    if (fireAt.isBefore(now)) {
      if (!tz.TZDateTime(tz.local, due.year, due.month, due.day, _hour).isAfter(now)) continue;
      fireAt = now.add(const Duration(minutes: 1));
    }
    await _plugin.zonedSchedule(
      id: r.id,
      scheduledDate: fireAt,
      title: '${pet.name} - ${recordLabel(t, r.type)}',
      body: '${r.product} - ${t.dueOn(fmt.format(due))}',
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails('reminders', t.reminderChannel),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}

AppLocalizations _l10n() {
  try {
    return lookupAppLocalizations(PlatformDispatcher.instance.locale);
  } catch (_) {
    return lookupAppLocalizations(const Locale('en')); // unsupported language
  }
}

/// Re-schedules whenever pets or health records change.
void watchReminders() {
  Future<void> run() => rescheduleAll().catchError((Object e) => debugPrint('reminders: $e'));
  db.select(db.healthRecords).watch().listen((_) => run());
  db.select(db.pets).watch().listen((_) => run());
}
