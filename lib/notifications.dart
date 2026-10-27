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
import 'reminder_time.dart';
import 'screens/pet_detail_screen.dart' show recordLabel;

final _plugin = FlutterLocalNotificationsPlugin();

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
  final now = DateTime.now();
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
    final fireAt = reminderTime(due, r.remindDaysBefore, now);
    if (fireAt == null) continue;
    await _plugin.zonedSchedule(
      id: r.id,
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
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
  // chained so two runs never overlap and a stale read cannot land last
  var last = Future<void>.value();
  void run() => last = last
      .then((_) => rescheduleAll())
      .catchError((Object e) => debugPrint('reminders: $e'));
  db.select(db.healthRecords).watch().listen((_) => run());
  db.select(db.pets).watch().listen((_) => run());
}
