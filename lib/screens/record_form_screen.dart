import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';
import 'pet_detail_screen.dart' show recordLabel;

class RecordFormScreen extends StatefulWidget {
  const RecordFormScreen({super.key, required this.petId, this.record});
  final int petId;
  final HealthRecord? record;

  @override
  State<RecordFormScreen> createState() => _RecordFormScreenState();
}

class _RecordFormScreenState extends State<RecordFormScreen> {
  final _key = GlobalKey<FormState>();
  late final _product = TextEditingController(text: widget.record?.product);
  late final _days = TextEditingController(text: '${widget.record?.remindDaysBefore ?? 7}');
  late RecordType _type = widget.record?.type ?? RecordType.vaccine;
  late DateTime _date = widget.record?.date ?? DateTime.now();
  late DateTime? _next = widget.record?.nextDue;

  Future<DateTime?> _pick(DateTime initial) => showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  Future<void> _save() async {
    if (!_key.currentState!.validate()) return;
    final c = HealthRecordsCompanion(
      petId: Value(widget.petId),
      type: Value(_type),
      product: Value(_product.text.trim()),
      date: Value(_date),
      nextDue: Value(_next),
      remindDaysBefore: Value(int.tryParse(_days.text) ?? 7),
    );
    final id = widget.record?.id;
    if (id == null) {
      await db.into(db.healthRecords).insert(c);
    } else {
      await (db.update(db.healthRecords)..where((r) => r.id.equals(id))).write(c);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await (db.delete(db.healthRecords)..where((r) => r.id.equals(widget.record!.id))).go();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final fmt = DateFormat.yMd(Localizations.localeOf(context).toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(t.addRecord),
        actions: [
          if (widget.record != null)
            IconButton(
                tooltip: t.delete,
                icon: const Icon(Icons.delete_outline),
                onPressed: _delete),
        ],
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<RecordType>(
              segments: [
                for (final r in RecordType.values)
                  ButtonSegment(value: r, label: Text(recordLabel(t, r))),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _product,
              decoration: InputDecoration(labelText: t.product),
              validator: (v) => (v == null || v.trim().isEmpty) ? t.required : null,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.date),
              subtitle: Text(fmt.format(_date)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await _pick(_date);
                if (d != null) setState(() => _date = d);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.nextDue),
              subtitle: Text(_next == null ? '-' : fmt.format(_next!)),
              trailing: const Icon(Icons.event),
              onTap: () async {
                final d = await _pick(_next ?? _date);
                if (d != null) setState(() => _next = d);
              },
            ),
            TextFormField(
              controller: _days,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: t.remindDaysBefore),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(t.save)),
          ],
        ),
      ),
    );
  }
}
