import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../sync/sync_service.dart';

/// Signs in with Google if needed, uploads the pet and shows an invite code.
Future<void> showShareDialog(BuildContext context, int petId) =>
    showDialog<void>(context: context, builder: (_) => _ShareDialog(petId: petId));

class _ShareDialog extends StatefulWidget {
  const _ShareDialog({required this.petId});
  final int petId;

  @override
  State<_ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<_ShareDialog> {
  late final Future<String> _code = sharePet(widget.petId);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(t.sharePet),
      content: FutureBuilder<String>(
        future: _code,
        builder: (context, snap) {
          if (snap.hasError) {
            return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.syncFailed),
              const SizedBox(height: 8),
              SelectableText(describeError(snap.error!), style: Theme.of(context).textTheme.bodySmall),
            ]);
          }
          final code = snap.data;
          if (code == null) {
            return const SizedBox(height: 56, child: Center(child: CircularProgressIndicator()));
          }
          return Column(mainAxisSize: MainAxisSize.min, children: [
            SelectableText(code,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: 4)),
            const SizedBox(height: 12),
            Text(t.shareExplain),
          ]);
        },
      ),
      actions: [
        FutureBuilder<String>(
          future: _code,
          builder: (context, snap) => snap.hasData
              ? TextButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await Clipboard.setData(ClipboardData(text: snap.data!));
                    messenger.showSnackBar(SnackBar(content: Text(t.codeCopied)));
                  },
                  child: Text(t.copyCode),
                )
              : const SizedBox.shrink(),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
      ],
    );
  }
}

Future<void> showJoinDialog(BuildContext context) =>
    showDialog<void>(context: context, builder: (_) => const _JoinDialog());

class _JoinDialog extends StatefulWidget {
  const _JoinDialog();

  @override
  State<_JoinDialog> createState() => _JoinDialogState();
}

class _JoinDialogState extends State<_JoinDialog> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _join(AppLocalizations t) async {
    if (_code.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await joinWithCode(_code.text);
      if (mounted) Navigator.pop(context);
    } on JoinFailed {
      if (mounted) setState(() => _error = t.joinFailed);
    } catch (e) {
      if (mounted) setState(() => _error = '${t.syncFailed}\n${describeError(e)}');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(t.joinWithCode),
      content: TextField(
        controller: _code,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(labelText: t.codeLabel, errorText: _error),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
        FilledButton(
          onPressed: _busy ? null : () => _join(t),
          child: _busy
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(t.join),
        ),
      ],
    );
  }
}
