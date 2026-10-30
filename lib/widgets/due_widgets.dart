import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../due_items.dart';
import '../l10n/app_localizations.dart';
import '../labels.dart' show recordLabel;
import '../screens/pet_detail_screen.dart';

/// Hidden for the rest of the session once the person closes the late-care notice.
final _overdueNoticeClosed = ValueNotifier<bool>(false);

/// On the pet list: cares whose due date has passed and for which no appointment is planned.
class OverdueNotice extends StatelessWidget {
  const OverdueNotice({super.key, required this.pets});
  final List<Pet> pets;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: _overdueNoticeClosed,
        builder: (context, closed, _) {
          if (closed || pets.isEmpty) return const SizedBox.shrink();
          return StreamBuilder<List<HealthRecord>>(
            stream: db.select(db.healthRecords).watch(),
            builder: (context, recSnap) => StreamBuilder<List<Appointment>>(
              stream: db.select(db.appointments).watch(),
              builder: (context, apSnap) {
                final records = recSnap.data ?? const <HealthRecord>[];
                final appts = apSnap.data ?? const <Appointment>[];
                final now = DateTime.now();
                final late = <(Pet, OverdueCare)>[
                  for (final p in pets)
                    if (!hasUpcomingAppointment(appts.where((a) => a.petId == p.id).toList(), now))
                      for (final o in overdueCares(records.where((r) => r.petId == p.id).toList(), now)) (p, o),
                ];
                if (late.isEmpty) return const SizedBox.shrink();
                return _NoticeCard(late: late);
              },
            ),
          );
        },
      );
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.late});
  final List<(Pet, OverdueCare)> late;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final fmt = DateFormat.yMd(Localizations.localeOf(context).toString());
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.errorContainer,
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.warning_amber_rounded, color: scheme.onErrorContainer),
            const SizedBox(width: 8),
            Expanded(
              child: Text(t.overdueTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onErrorContainer)),
            ),
            IconButton(
              tooltip: t.cancel,
              icon: Icon(Icons.close, color: scheme.onErrorContainer),
              onPressed: () => _overdueNoticeClosed.value = true,
            ),
          ]),
          for (final (pet, care) in late.take(5))
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetDetailScreen(petId: pet.id))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${pet.name} - ${recordLabel(t, care.record.type)} - ${care.record.product}',
                      style: TextStyle(color: scheme.onErrorContainer, fontWeight: FontWeight.w600)),
                  Text('${t.overdueSince(fmt.format(care.due))} - ${t.noAppointmentPlanned}',
                      style: TextStyle(color: scheme.onErrorContainer)),
                ]),
              ),
            ),
          if (late.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('+${late.length - 5}', style: TextStyle(color: scheme.onErrorContainer)),
            ),
        ]),
      ),
    );
  }
}

/// On a pet's first tab: the few next things coming up, and what is already late.
class PetDueSummary extends StatelessWidget {
  const PetDueSummary({super.key, required this.petId});
  final int petId;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<HealthRecord>>(
        stream: (db.select(db.healthRecords)..where((r) => r.petId.equals(petId))).watch(),
        builder: (context, recSnap) => StreamBuilder<List<Appointment>>(
          stream: (db.select(db.appointments)..where((a) => a.petId.equals(petId))).watch(),
          builder: (context, apSnap) {
            final records = recSnap.data ?? const <HealthRecord>[];
            final appts = apSnap.data ?? const <Appointment>[];
            final now = DateTime.now();
            final late = overdueCares(records, now);
            final next = upcomingEntries(records, appts, now);
            if (late.isEmpty && next.isEmpty) return const SizedBox.shrink();
            final t = AppLocalizations.of(context);
            final locale = Localizations.localeOf(context).toString();
            final date = DateFormat.yMd(locale);
            final dateTime = DateFormat.yMd(locale).add_Hm();
            final scheme = Theme.of(context).colorScheme;
            return Card(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.upcomingTitle, style: Theme.of(context).textTheme.titleMedium),
                  for (final o in late)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.warning_amber_rounded, color: scheme.error),
                      title: Text('${recordLabel(t, o.record.type)} - ${o.record.product}'),
                      subtitle: Text(t.overdueSince(date.format(o.due)), style: TextStyle(color: scheme.error)),
                    ),
                  for (final e in next)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(e.record != null ? Icons.vaccines : Icons.event),
                      title: Text(e.record != null ? '${recordLabel(t, e.record!.type)} - ${e.record!.product}' : e.appointment!.title),
                      subtitle: Text(e.record != null ? t.dueOn(date.format(e.when)) : dateTime.format(e.when)),
                    ),
                ]),
              ),
            );
          },
        ),
      );
}
