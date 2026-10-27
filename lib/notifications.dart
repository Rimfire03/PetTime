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
import 'labels.dart' show recordLabel;

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

  final appts = await (db.select(db.appointments).join([
    innerJoin(db.pets, db.pets.id.equalsExp(db.appointments.petId)),
  ])).get();

  await _plugin.cancelAll();

  Future<void> schedule(int id, DateTime? fireAt, String title, String body) async {
    if (fireAt == null) return;
    await _plugin.zonedSchedule(
      id: id,
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
      title: title,
      body: body,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails('reminders', t.reminderChannel),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  for (final row in rows) {
    final r = row.readTable(db.healthRecords);
    final pet = row.readTable(db.pets);
    await schedule(
      r.id,
      reminderTime(r.nextDue!, r.remindDaysBefore, now),
      '${pet.name} - ${recordLabel(t, r.type)}',
      '${r.product} - ${t.dueOn(fmt.format(r.nextDue!))}',
    );
  }
  final dateTime = DateFormat.yMd(PlatformDispatcher.instance.locale.toString()).add_Hm();
  for (final row in appts) {
    final a = row.readTable(db.appointments);
    final pet = row.readTable(db.pets);
    await schedule(
      appointmentNotificationBase + a.id, // ids must not collide with health record ids
      appointmentReminderTime(a.at, a.remindDaysBefore, now),
      '${pet.name} - ${a.title}',
      [dateTime.format(a.at), if (a.place != null) a.place!].join(' - '),
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
  db.select(db.appointments).watch().listen((_) => run());
}
