import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({super.key, required this.petId});
  final int petId;

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  late final Stream<List<Appointment>> _stream = db.watchAppointments(widget.petId);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final fmt = DateFormat.yMd(Localizations.localeOf(context).toString()).add_Hm();
    return Scaffold(
      body: StreamBuilder<List<Appointment>>(
        stream: _stream,
        builder: (context, snap) {
          final list = snap.data ?? [];
          if (list.isEmpty) return Center(child: Text(t.noAppointments));
          return ListView(
            children: [
              for (final a in list)
                ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(a.title),
                  subtitle: Text([fmt.format(a.at), if (a.place != null) a.place!].join(' - ')),
                  onTap: () => _edit(context, widget.petId, a),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addAppointment,
        onPressed: () => _edit(context, widget.petId),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _edit(BuildContext context, int petId, [Appointment? a]) =>
    showDialog<void>(context: context, builder: (_) => _AppointmentDialog(petId: petId, appointment: a));

class _AppointmentDialog extends StatefulWidget {
  const _AppointmentDialog({required this.petId, this.appointment});
  final int petId;
  final Appointment? appointment;

  @override
  State<_AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<_AppointmentDialog> {
  late final _title = TextEditingController(text: widget.appointment?.title);
  late final _place = TextEditingController(text: widget.appointment?.place);
  late final _days = TextEditingController(text: '${widget.appointment?.remindDaysBefore ?? 1}');
  late DateTime _at = widget.appointment?.at ?? DateTime.now().add(const Duration(days: 1));
  bool _titleMissing = false;

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) return setState(() => _titleMissing = true);
    final place = _place.text.trim();
    final c = AppointmentsCompanion(
      petId: Value(widget.petId),
      at: Value(_at),
      title: Value(title),
      place: Value(place.isEmpty ? null : place),
      remindDaysBefore: Value((int.tryParse(_days.text) ?? 1).clamp(0, 365)),
    );
    final id = widget.appointment?.id;
    if (id == null) {
      await db.into(db.appointments).insert(c);
    } else {
      await (db.update(db.appointments)..where((x) => x.id.equals(id))).write(c);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await (db.delete(db.appointments)..where((x) => x.id.equals(widget.appointment!.id))).go();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    return AlertDialog(
      title: Text(t.addAppointment),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _title,
              autofocus: true,
              decoration: InputDecoration(
                labelText: t.appointmentTitle,
                errorText: _titleMissing ? t.required : null,
              ),
            ),
            TextField(controller: _place, decoration: InputDecoration(labelText: t.place)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.date),
              subtitle: Text(DateFormat.yMd(locale).format(_at)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _at,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _at = DateTime(d.year, d.month, d.day, _at.hour, _at.minute));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.time),
              subtitle: Text(DateFormat.Hm(locale).format(_at)),
              trailing: const Icon(Icons.schedule),
              onTap: () async {
                final tm = await showTimePicker(
                    context: context, initialTime: TimeOfDay.fromDateTime(_at));
                if (tm != null) setState(() => _at = DateTime(_at.year, _at.month, _at.day, tm.hour, tm.minute));
              },
            ),
            TextField(
              controller: _days,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: t.remindDaysBefore),
            ),
          ],
        ),
      ),
      actions: [
        if (widget.appointment != null) TextButton(onPressed: _delete, child: Text(t.delete)),
        FilledButton(onPressed: _save, child: Text(t.save)),
      ],
    );
  }
}
