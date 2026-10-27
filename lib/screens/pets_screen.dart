import 'package:flutter/material.dart';

import '../ads.dart';
import '../backup.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import 'pet_detail_screen.dart';
import 'pet_form_screen.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.myPets), actions: [
        ValueListenableBuilder<bool>(
          valueListenable: privacyOptionsRequired,
          builder: (_, privacy, _) => PopupMenuButton<_Backup>(
            onSelected: (m) =>
                m == _Backup.privacy ? showPrivacyOptions() : _runBackup(context, m),
            itemBuilder: (_) => [
              PopupMenuItem(value: _Backup.export, child: Text(t.backupExport)),
              PopupMenuItem(value: _Backup.import, child: Text(t.backupImport)),
              if (privacy) PopupMenuItem(value: _Backup.privacy, child: Text(t.privacySettings)),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: const AdBanner(),
      body: StreamBuilder<List<Pet>>(
        stream: db.watchPets(),
        builder: (context, snap) {
          final pets = snap.data ?? [];
          if (pets.isEmpty) return Center(child: Text(t.noPets));
          return ListView(
            children: [
              for (final p in pets)
                ListTile(
                  leading: PetAvatar(name: p.name, photo: p.photoPath),
                  title: Text(p.name),
                  subtitle: Text(p.breed ?? speciesLabel(t, p.species)),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PetDetailScreen(petId: p.id))),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addPet,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PetFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum _Backup { export, import, privacy }

Future<void> _runBackup(BuildContext context, _Backup action) async {
  final t = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  void say(String s) => messenger.showSnackBar(SnackBar(content: Text(s)));
  try {
    if (action == _Backup.export) {
      if (await exportBackupFile()) say(t.backupSaved);
      return;
    }
    final json = await pickBackupFile();
    if (json == null || !context.mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(t.restoreConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.backupImport)),
        ],
      ),
    );
    if (ok != true) return;
    await restoreBackup(json);
    say(t.backupRestored);
  } catch (_) {
    say(t.backupInvalid);
  }
}

String speciesLabel(AppLocalizations t, String s) => switch (s) {
      'dog' => t.dog,
      'cat' => t.cat,
      _ => t.other,
    };
