import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../sync/sync_service.dart';
import 'share_dialogs.dart';

/// Who can see a pet, with a way to remove them, and the invitation codes still alive.
class SharesScreen extends StatefulWidget {
  const SharesScreen({super.key, required this.petId});
  final int petId;

  @override
  State<SharesScreen> createState() => _SharesScreenState();
}

class _SharesScreenState extends State<SharesScreen> {
  late Future<Shares?> _shares = loadShares(widget.petId);

  void _reload() => setState(() => _shares = loadShares(widget.petId));

  Future<void> _run(Future<void> Function() action) async {
    final messenger = ScaffoldMessenger.of(context);
    final t = AppLocalizations.of(context);
    try {
      await action();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('${t.syncFailed}\n${describeError(e)}')));
    }
    if (mounted) _reload();
  }

  Future<void> _revokeMember(ShareMember m) async {
    final t = AppLocalizations.of(context);
    final name = m.label.isEmpty ? t.sharesUnknown : m.label;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.sharesRevoke),
        content: Text(t.sharesRevokeConfirm(name)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.sharesRevoke)),
        ],
      ),
    );
    if (ok == true) await _run(() => revokeMember(widget.petId, m.uid));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final date = DateFormat.yMd(Localizations.localeOf(context).toString()).add_Hm();
    return Scaffold(
      appBar: AppBar(title: Text(t.sharesTitle)),
      body: FutureBuilder<Shares?>(
        future: _shares,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.syncFailed),
                const SizedBox(height: 8),
                SelectableText(describeError(snap.error!), style: Theme.of(context).textTheme.bodySmall),
                IconButton(onPressed: _reload, icon: const Icon(Icons.refresh)),
              ]),
            );
          }
          final s = snap.data;
          if (s == null) return Padding(padding: const EdgeInsets.all(16), child: Text(t.sharesOffline));
          final heading = Theme.of(context).textTheme.titleMedium;
          return ListView(padding: const EdgeInsets.all(16), children: [
            Text(t.sharesMembers, style: heading),
            for (final m in s.members)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(m.isOwner ? Icons.verified_user : Icons.person),
                title: Text(m.label.isEmpty ? t.sharesUnknown : m.label),
                subtitle: Text([if (m.isOwner) t.sharesOwnerTag, if (m.isMe) t.sharesYouTag].join(' - ')),
                trailing: s.iAmOwner && !m.isOwner
                    ? TextButton(onPressed: () => _revokeMember(m), child: Text(t.sharesRevoke))
                    : null,
              ),
            if (s.iAmOwner) ...[
              const SizedBox(height: 24),
              Text(t.sharesInvites, style: heading),
              if (s.invites.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(t.sharesNoInvites)),
              for (final i in s.invites)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: SelectableText(i.code, style: const TextStyle(letterSpacing: 3, fontWeight: FontWeight.w600)),
                  subtitle: Text(t.sharesInviteExpires(date.format(i.expiresAt))),
                  trailing: TextButton(
                    onPressed: () => _run(() => revokeInvite(i.code)),
                    child: Text(t.sharesRevoke),
                  ),
                ),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              icon: const Icon(Icons.group_add),
              label: Text(t.sharesNewCode),
              onPressed: () async {
                await showShareDialog(context, widget.petId);
                if (mounted) _reload();
              },
            ),
          ]);
        },
      ),
    );
  }
}
