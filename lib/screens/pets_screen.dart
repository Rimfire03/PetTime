import 'package:flutter/material.dart';

import '../ads.dart';
import '../backup.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import '../purchases.dart';
import '../watermark.dart';
import '../sync/sync_service.dart' show signOutAndWipe, syncAvailable, syncUser, unsyncedCount;
import 'share_dialogs.dart';
import 'pet_detail_screen.dart';
import 'pet_form_screen.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.myPets), actions: [
        ListenableBuilder(
          listenable: Listenable.merge([privacyOptionsRequired, adsRemoved, removeAdsPrice, syncUser]),
          builder: (_, _) => PopupMenuButton<_Backup>(
            onSelected: (m) => switch (m) {
              _Backup.privacy => showPrivacyOptions(),
              _Backup.join => showJoinDialog(context),
              _Backup.removeAds => buyRemoveAds(),
              _Backup.restore => restorePurchases(),
              _Backup.logout => _logout(context),
              _ => _runBackup(context, m),
            },
            itemBuilder: (_) => [
              if (syncAvailable.value)
                PopupMenuItem(value: _Backup.join, child: Text(t.joinWithCode)),
              PopupMenuItem(value: _Backup.export, child: Text(t.backupExport)),
              PopupMenuItem(value: _Backup.import, child: Text(t.backupImport)),
              // only when the store really offers the product, and not to someone who already bought it
              if (!adsRemoved.value && removeAdsPrice.value != null) ...[
                PopupMenuItem(value: _Backup.removeAds, child: Text(t.removeAds(removeAdsPrice.value!))),
                PopupMenuItem(value: _Backup.restore, child: Text(t.restorePurchases)),
              ],
              if (privacyOptionsRequired.value)
                PopupMenuItem(value: _Backup.privacy, child: Text(t.privacySettings)),
              if (syncUser.value != null)
                PopupMenuItem(value: _Backup.logout, child: Text(t.logout)),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: const AdBanner(),
      body: PawBackdrop(child: StreamBuilder<List<Pet>>(
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
      )),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addPet,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PetFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum _Backup { export, import, privacy, join, removeAds, restore, logout }

Future<void> _logout(BuildContext context) async {
  final t = AppLocalizations.of(context);
  final unsent = await unsyncedCount(); // local changes the cloud has not received yet
  if (!context.mounted) return;
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(t.logout),
      content: Text(unsent > 0 ? '${t.logoutConfirm}\n\n${t.logoutUnsynced(unsent)}' : t.logoutConfirm),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.logout)),
      ],
    ),
  );
  if (ok == true) await signOutAndWipe();
}

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
      'rabbit' => t.rabbit,
      _ => t.other,
    };
