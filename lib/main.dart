import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'ads.dart';
import 'notifications.dart';
import 'photos.dart';
import 'sync/sync_service.dart';
import 'screens/pets_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPhotos();
  try {
    await initSync();
  } catch (e) {
    debugPrint('sync disabled: $e'); // no Firebase config on this platform: stay local-only
  }
  try {
    await initNotifications();
    watchReminders();
  } catch (e) {
    debugPrint('notifications disabled: $e'); // the app must still open
  }
  runApp(const PetTimeApp());
  // after runApp: the iOS tracking prompt needs a visible app
  unawaited(initAds().catchError((Object e) => debugPrint('ads disabled: $e')));
}

class PetTimeApp extends StatelessWidget {
  const PetTimeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: (c) => AppLocalizations.of(c).appTitle,
        theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PetsScreen(),
      );
}
