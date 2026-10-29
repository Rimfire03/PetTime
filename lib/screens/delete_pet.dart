import 'package:flutter/material.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import '../sync/sync_service.dart' show PetRole, petRole;

/// True when this account may delete the pet: its owner, never somebody it was shared with.
Future<bool> canDeletePet(int petId) async => await petRole(petId) != PetRole.member;

/// Asks for confirmation, then deletes [pet] (for a shared pet the owner's delete removes it for everybody).
/// Returns true when the pet is gone. Somebody a pet was shared with cannot delete it.
Future<bool> confirmDeletePet(BuildContext context, Pet pet) async {
  final t = AppLocalizations.of(context);
  final role = await petRole(pet.id);
  if (!context.mounted) return false;
  if (role == PetRole.member) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.deleteOnlyOwner)));
    return false;
  }
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(t.deletePetTitle(pet.name)),
      content: Text(role == PetRole.owner ? t.deletePetOwner : t.deletePetLocal),
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
