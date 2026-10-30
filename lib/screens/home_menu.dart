import 'package:flutter/material.dart';

import '../ads.dart';
import '../backup.dart';
import '../l10n/app_localizations.dart';
import '../purchases.dart';
import '../sync/sync_service.dart'
    show deleteAccount, describeError, signOutAndWipe, syncAvailable, syncUser, unsyncedCount;
import 'share_dialogs.dart';

enum _Action { join, export, import, removeAds, restore, privacy, logout, deleteAccount }

/// The "..." menu of the home screen: sharing, backup, purchase and account actions.
/// Each entry only shows when it applies (no purchase entry once ads are removed, no logout when signed out...).
class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([privacyOptionsRequired, adsRemoved, removeAdsPrice, syncUser]),
      builder: (_, _) => PopupMenuButton<_Action>(
        onSelected: (a) => _run(context, a),
        itemBuilder: (_) => [
          if (syncAvailable.value) PopupMenuItem(value: _Action.join, child: Text(t.joinWithCode)),
          PopupMenuItem(value: _Action.export, child: Text(t.backupExport)),
          PopupMenuItem(value: _Action.import, child: Text(t.backupImport)),
          // only when the store really offers the product, and not to someone who already bought it
          if (!adsRemoved.value && removeAdsPrice.value != null) ...[
            PopupMenuItem(value: _Action.removeAds, child: Text(t.removeAds(removeAdsPrice.value!))),
            PopupMenuItem(value: _Action.restore, child: Text(t.restorePurchases)),
          ],
          if (privacyOptionsRequired.value) PopupMenuItem(value: _Action.privacy, child: Text(t.privacySettings)),
          if (syncUser.value != null) PopupMenuItem(value: _Action.logout, child: Text(t.logout)),
          if (syncUser.value != null) PopupMenuItem(value: _Action.deleteAccount, child: Text(t.deleteAccount)),
        ],
      ),
    );
  }

  static Future<void> _run(BuildContext context, _Action action) => switch (action) {
        _Action.join => showJoinDialog(context),
        _Action.export || _Action.import => _backup(context, action),
        _Action.removeAds => buyRemoveAds(),
        _Action.restore => restorePurchases(),
        _Action.privacy => Future.sync(showPrivacyOptions),
        _Action.logout => _logout(context),
        _Action.deleteAccount => _deleteAccount(context),
      };

  static Future<void> _logout(BuildContext context) async {
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

  static Future<void> _deleteAccount(BuildContext context) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.deleteAccount),
        content: Text(t.deleteAccountConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await deleteAccount();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('${t.syncFailed}\n${describeError(e)}')));
    }
  }

  static Future<void> _backup(BuildContext context, _Action action) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    void say(String s) => messenger.showSnackBar(SnackBar(content: Text(s)));
    try {
      if (action == _Action.export) {
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
}