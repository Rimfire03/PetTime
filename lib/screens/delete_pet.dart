import 'package:flutter/material.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import '../sync/sync_service.dart' show PetRole, petRole;

/// Asks for confirmation, then deletes [pet] (the sync turns that into "delete for everybody" for the
/// owner and "leave" for a member). Returns true when the pet is gone.
Future<bool> confirmDeletePet(BuildContext context, Pet pet) async {
  final t = AppLocalizations.of(context);
  final role = await petRole(pet.id);
  if (!context.mounted) return false;
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(t.deletePetTitle(pet.name)),
      content: Text(switch (role) {
        PetRole.local => t.deletePetLocal,
        PetRole.owner => t.deletePetOwner,
        PetRole.member => t.deletePetMember,
      }),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.delete)),
      ],
    ),
  );
  if (ok != true) return false;
  await (db.delete(db.pets)..where((p) => p.id.equals(pet.id))).go();
  deletePhoto(pet.photoPath);
  return true;
}
