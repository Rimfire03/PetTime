import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text(t.myPets)),
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

String speciesLabel(AppLocalizations t, String s) => switch (s) {
      'dog' => t.dog,
      'cat' => t.cat,
      _ => t.other,
    };
