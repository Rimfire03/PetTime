import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../care_catalog.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../labels.dart' show recordLabel;

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
  final _productFocus = FocusNode();
  String _species = 'other'; // decides which suggestions are offered
  int? _autoMonths; // set while the next due date comes from a suggestion; it then follows the care date

  @override
  void initState() {
    super.initState();
    (db.select(db.pets)..where((p) => p.id.equals(widget.petId))).getSingleOrNull().then((p) {
      if (p != null && mounted) setState(() => _species = p.species);
    });
  }

  @override
  void dispose() {
    _productFocus.dispose();
    super.dispose();
  }

  void _applySuggestion(CareSuggestion s) {
    final months = s.repeatMonths;
    setState(() {
      // never overwrite a date the person typed by hand
      if (_next == null || _autoMonths != null) {
        _autoMonths = months;
        _next = months == null ? null : addMonths(_date, months);
      }
    });
  }

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
      remindDaysBefore: Value((int.tryParse(_days.text) ?? 7).clamp(0, 365)),
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
    final lang = Localizations.localeOf(context).languageCode;
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
            DropdownButtonFormField<RecordType>(
              initialValue: _type,
              decoration: InputDecoration(labelText: t.recordType),
              items: [
                for (final r in RecordType.values)
                  DropdownMenuItem(value: r, child: Text(recordLabel(t, r))),
              ],
              onChanged: (r) => setState(() => _type = r!),
            ),
            const SizedBox(height: 12),
            // catalogue of usual vaccines / treatments for this species; any other name can be typed
            RawAutocomplete<CareSuggestion>(
              textEditingController: _product,
              focusNode: _productFocus,
              displayStringForOption: (s) => s.nameFor(lang),
              optionsBuilder: (v) => suggestCare(_species, _type, v.text, lang),
              onSelected: _applySuggestion,
              fieldViewBuilder: (context, controller, focusNode, onSubmit) => TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(labelText: t.product),
                validator: (v) => (v == null || v.trim().isEmpty) ? t.required : null,
              ),
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 280, maxWidth: 380),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        for (final o in options)
                          ListTile(
                            dense: true,
                            title: Text(o.nameFor(lang)),
                            subtitle: o.repeatMonths == null ? null : Text(t.repeatEvery(o.repeatMonths!)),
                            onTap: () => onSelected(o),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.date),
              subtitle: Text(fmt.format(_date)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await _pick(_date);
                if (d == null) return;
                setState(() {
                  _date = d;
                  if (_autoMonths != null) _next = addMonths(d, _autoMonths!); // suggested date follows
                });
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.nextDue),
              subtitle: Text(_next == null ? '-' : fmt.format(_next!)),
              trailing: const Icon(Icons.event),
              onTap: () async {
                final d = await _pick(_next ?? _date);
                if (d != null) {
                  setState(() {
                    _next = d;
                    _autoMonths = null; // chosen by hand: stop following the care date
                  });
                }
              },
            ),
            if (_autoMonths != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(t.suggestionNote, style: Theme.of(context).textTheme.bodySmall),
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
