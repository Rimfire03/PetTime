import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../sync/sync_service.dart';
import '../watermark.dart';
import 'pets_screen.dart';

/// First screen of the app. Where the cloud is available (a phone with the Firebase config), nothing is
/// usable before signing in with Google: the account owns the pets and brings them back on a new phone.
/// Where it is not (desktop, build without config) the app opens straight on the pets.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: syncAvailable,
        builder: (_, available, _) {
          if (!available) return const PetsScreen();
          return ValueListenableBuilder<User?>(
            valueListenable: syncUser,
            builder: (_, user, _) => user == null ? const SignInScreen() : const PetsScreen(),
          );
        },
      );
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _busy = false;
  String? _error;

  Future<void> _signIn(AppLocalizations t) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ensureSignedIn(); // the gate switches screens by itself once the account is known
    } catch (e) {
      if (mounted) setState(() => _error = '${t.syncFailed}\n${describeError(e)}');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: PawBackdrop(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.pets, size: 72, color: color),
              const SizedBox(height: 16),
              Text(t.welcome, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(t.signInExplain, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _busy ? null : () => _signIn(t),
                icon: _busy
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.login),
                label: Text(t.signInWithGoogle),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                SelectableText(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}
