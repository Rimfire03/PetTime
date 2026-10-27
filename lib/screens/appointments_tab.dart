import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../calendar_link.dart';
import '../contact_links.dart' show openUri;
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../suggestions.dart';
import '../widgets/suggest_field.dart';

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
      backgroundColor: Colors.transparent,
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
                  trailing: IconButton(
                    tooltip: t.addToCalendar,
                    icon: const Icon(Icons.edit_calendar),
                    onPressed: () async => openUri(await appointmentCalendarUri(a)),
                  ),
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
  final _form = GlobalKey<FormState>();
  List<String> _reasons = const [], _places = const [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final reasons = await usedValues('appointments', 'title');
    final places = await usedValues('appointments', 'place');
    final pet = await (db.select(db.pets)..where((p) => p.id.equals(widget.petId))).getSingleOrNull();
    final vet = pet?.vetName?.trim();
    if (!mounted) return;
    setState(() {
      _reasons = reasons;
      _places = [if (vet != null && vet.isNotEmpty) vet, ...places.where((p) => p != vet)];
    });
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final title = _title.text.trim();
    final place = _place.text.trim();
    final c = AppointmentsCompanion(
      petId: Value(widget.petId),
      at: Value(_at),
      title: Value(title),
      place: Value(place.isEmpty ? null : place),
      remindDaysBefore: Value((int.tryParse(_days.text) ?? 1).clamp(0, 365)),
    );
    final id = widget.appointment?.id;
    final messenger = ScaffoldMessenger.of(context);
    final t = AppLocalizations.of(context);
    final isNew = id == null;
    final newId = isNew ? await db.into(db.appointments).insert(c) : id;
    if (!isNew) await (db.update(db.appointments)..where((x) => x.id.equals(id))).write(c);
    if (mounted) Navigator.pop(context);
    if (isNew) {
      // offer the calendar right after creating it, from the screen behind the closed dialog
      messenger.showSnackBar(SnackBar(
        content: Text(t.appointmentSaved),
        duration: const Duration(seconds: 8),
        action: SnackBarAction(
          label: t.addToCalendar,
          onPressed: () async {
            final saved = await (db.select(db.appointments)..where((x) => x.id.equals(newId))).getSingle();
            await openUri(await appointmentCalendarUri(saved));
          },
        ),
      ));
    }
  }

  Future<void> _delete() async {
    await (db.delete(db.appointments)..where((x) => x.id.equals(widget.appointment!.id))).go();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final lang = Localizations.localeOf(context).languageCode;
    return AlertDialog(
      title: Text(t.addAppointment),
      content: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SuggestField(
              controller: _title,
              autofocus: true,
              label: t.appointmentTitle,
              validator: (v) => (v == null || v.trim().isEmpty) ? t.required : null,
              options: (q) => filterSuggestions([...reasonsFor(lang), ..._reasons], q, allWhenEmpty: true),
            ),
            SuggestField(controller: _place, label: t.place, options: (q) => filterSuggestions(_places, q)),
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
      ),
      actions: [
        if (widget.appointment != null) TextButton(onPressed: _delete, child: Text(t.delete)),
        FilledButton(onPressed: _save, child: Text(t.save)),
      ],
    );
  }
}
