import 'package:drift/drift.dart' show Value;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';

const _msPerDay = 86400000.0;

class WeightsTab extends StatelessWidget {
  const WeightsTab({super.key, required this.petId});
  final int petId;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final fmt = DateFormat.yMd(locale);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<List<Weight>>(
        stream: db.watchWeights(petId),
        builder: (context, snap) {
          final ws = snap.data ?? [];
          if (ws.isEmpty) return Center(child: Text(t.noWeights));
          return ListView(
            children: [
              if (ws.length > 1) _Chart(weights: ws, locale: locale),
              for (final w in ws.reversed)
                ListTile(
                  title: Text('${w.kg} kg'),
                  subtitle: Text(fmt.format(w.date)),
                  onTap: () => _edit(context, petId, w),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addWeight,
        onPressed: () => _edit(context, petId),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.weights, required this.locale});
  final List<Weight> weights;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final spots = [
      for (final w in weights) FlSpot(w.date.millisecondsSinceEpoch / _msPerDay, w.kg),
    ];
    final span = spots.last.x - spots.first.x;
    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 24, 8),
        child: LineChart(LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: span < 3 ? 1 : span / 3,
                reservedSize: 28,
                getTitlesWidget: (v, meta) {
                  // the interval rarely divides the span exactly: skip a label that would sit on top of the last one
                  if (v != meta.max && meta.max - v < meta.appliedInterval * 0.5) return const SizedBox.shrink();
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      DateFormat.Md(locale).format(
                          DateTime.fromMillisecondsSinceEpoch((v * _msPerDay).round())),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
        )),
      ),
    );
  }
}

Future<void> _edit(BuildContext context, int petId, [Weight? w]) {
  return showDialog<void>(
    context: context,
    builder: (_) => _WeightDialog(petId: petId, weight: w),
  );
}

class _WeightDialog extends StatefulWidget {
  const _WeightDialog({required this.petId, this.weight});
  final int petId;
  final Weight? weight;

  @override
  State<_WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<_WeightDialog> {
  late final _kg = TextEditingController(text: widget.weight?.kg.toString());
  late DateTime _date = widget.weight?.date ?? DateTime.now();

  final _kgFocus = FocusNode();
  String? _lastSaved;

  @override
  void dispose() {
    _kgFocus.dispose();
    super.dispose();
  }

  Future<void> _save({bool another = false}) async {
    // accept both "4.2" and "4,2"
    final kg = double.tryParse(_kg.text.replaceAll(',', '.'));
    if (kg == null || kg <= 0) return;
    final c = WeightsCompanion(petId: Value(widget.petId), date: Value(_date), kg: Value(kg));
    final id = widget.weight?.id;
    if (id == null) {
      await db.into(db.weights).insert(c);
    } else {
      await (db.update(db.weights)..where((w) => w.id.equals(id))).write(c);
    }
    if (!mounted) return;
    if (another) {
      // keep the date: entering a series of old weights means changing only the value and the day
      final fmt = DateFormat.yMd(Localizations.localeOf(context).toString());
      setState(() {
        _lastSaved = '$kg kg - ${fmt.format(_date)}';
        _kg.clear();
      });
      _kgFocus.requestFocus();
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _delete() async {
    await (db.delete(db.weights)..where((w) => w.id.equals(widget.weight!.id))).go();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final fmt = DateFormat.yMd(Localizations.localeOf(context).toString());
    return AlertDialog(
      title: Text(t.addWeight),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _kg,
              focusNode: _kgFocus,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: t.weightKg),
            ),
            const SizedBox(height: 16),
            // today by default, but a field that clearly invites a tap: any older day can be chosen
            InkWell(
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now(),
                );
                if (d != null) setState(() => _date = d);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: t.weighedOn,
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(),
                ),
                child: Text(fmt.format(_date)),
              ),
            ),
            if (_lastSaved != null) ...[
              const SizedBox(height: 12),
              Row(children: [
                const Icon(Icons.check_circle, size: 16),
                const SizedBox(width: 6),
                Expanded(child: Text(t.savedLine(_lastSaved!), style: Theme.of(context).textTheme.bodySmall)),
              ]),
            ],
          ],
        ),
      ),
      actions: [
        if (widget.weight != null) TextButton(onPressed: _delete, child: Text(t.delete)),
        if (widget.weight == null) TextButton(onPressed: () => _save(another: true), child: Text(t.saveAndAddAnother)),
        FilledButton(onPressed: _save, child: Text(t.save)),
      ],
    );
  }
}
