import 'package:flutter/material.dart';

import '../ads.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../labels.dart' show speciesLabel;
import '../photos.dart';
import '../watermark.dart';
import 'home_menu.dart';
import 'pet_detail_screen.dart';
import 'pet_wizard_screen.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.myPets), actions: const [HomeMenu()]),
      bottomNavigationBar: const AdBanner(),
      body: PawBackdrop(
        child: StreamBuilder<List<Pet>>(
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
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => PetDetailScreen(petId: p.id))),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addPet,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PetWizardScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}