import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../pdf_export.dart';
import '../sync/sync_service.dart' show syncAvailable;
import 'share_dialogs.dart';
import '../photos.dart';
import 'appointments_tab.dart';
import 'pet_form_screen.dart';
import 'pets_screen.dart' show speciesLabel;
import 'record_form_screen.dart';
import 'weights_tab.dart';

String recordLabel(AppLocalizations t, RecordType r) => switch (r) {
      RecordType.vaccine => t.vaccine,
      RecordType.dewormer => t.dewormer,
      RecordType.flea => t.flea,
    };

class PetDetailScreen extends StatefulWidget {
  const PetDetailScreen({super.key, required this.petId});
  final int petId;

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  int get petId => widget.petId;
  // created once: a stream built inside build() would re-subscribe on every redraw
  late final Stream<Pet> _pet = (db.select(db.pets)..where((p) => p.id.equals(petId)))
      .watchSingleOrNull()
      .where((p) => p != null)
      .cast<Pet>();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return StreamBuilder<Pet>(
      stream: _pet,
      builder: (context, snap) {
        final pet = snap.data;
        if (pet == null) return const Scaffold(body: SizedBox());
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(pet.name),
              bottom: TabBar(isScrollable: true, tabs: [
                Tab(text: t.info),
                Tab(text: t.healthBook),
                Tab(text: t.weight),
                Tab(text: t.appointments),
              ]),
              actions: [
                ValueListenableBuilder<bool>(
                  valueListenable: syncAvailable,
                  builder: (_, on, _) => on
                      ? IconButton(
                          tooltip: t.sharePet,
                          icon: const Icon(Icons.group_add),
                          onPressed: () => showShareDialog(context, petId),
                        )
                      : const SizedBox.shrink(),
                ),
                IconButton(
                  tooltip: t.exportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: () => exportHealthBookPdf(context, pet),
                ),
                IconButton(
                  tooltip: t.editPet,
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PetFormScreen(pet: pet))),
                ),
              ],
            ),
            body: TabBarView(children: [
              _Info(pet: pet),
              _Records(petId: petId),
              WeightsTab(petId: petId),
              AppointmentsTab(petId: petId),
            ]),
          ),
        );
      },
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.pet});
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final rows = <(String, String?)>[
      (t.species, speciesLabel(t, pet.species)),
      (t.breed, pet.breed),
      (t.birthDate, pet.birthDate == null ? null : DateFormat.yMd(locale).format(pet.birthDate!)),
      (t.chip, pet.chip),
      (t.vetName, pet.vetName),
      (t.vetPhone, pet.vetPhone),
      (t.notes, pet.notes),
    ];
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(child: PetAvatar(name: pet.name, photo: pet.photoPath, radius: 56)),
        ),
        for (final (label, value) in rows)
          if (value != null) ListTile(title: Text(label), subtitle: Text(value)),
      ],
    );
  }
}

class _Records extends StatelessWidget {
  const _Records({required this.petId});
  final int petId;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final fmt = DateFormat.yMd(locale);
    return Scaffold(
      body: StreamBuilder<List<HealthRecord>>(
        stream: db.watchRecords(petId),
        builder: (context, snap) {
          final records = snap.data ?? [];
          if (records.isEmpty) return Center(child: Text(t.noRecords));
          return ListView(
            children: [
              for (final r in records)
                ListTile(
                  leading: Icon(switch (r.type) {
                    RecordType.vaccine => Icons.vaccines,
                    RecordType.dewormer => Icons.bug_report,
                    RecordType.flea => Icons.pest_control,
                  }),
                  title: Text('${recordLabel(t, r.type)} - ${r.product}'),
                  subtitle: Text([
                    fmt.format(r.date),
                    if (r.nextDue != null) t.dueOn(fmt.format(r.nextDue!)),
                  ].join(' · ')),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RecordFormScreen(petId: petId, record: r))),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addRecord,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => RecordFormScreen(petId: petId))),
        child: const Icon(Icons.add),
      ),
    );
  }
}
