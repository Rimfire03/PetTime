import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import 'pets_screen.dart' show speciesLabel;

class PetFormScreen extends StatefulWidget {
  const PetFormScreen({super.key, this.pet});
  final Pet? pet;

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final _key = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.pet?.name);
  late final _breed = TextEditingController(text: widget.pet?.breed);
  late final _chip = TextEditingController(text: widget.pet?.chip);
  late final _vet = TextEditingController(text: widget.pet?.vetName);
  late final _vetPhone = TextEditingController(text: widget.pet?.vetPhone);
  late final _notes = TextEditingController(text: widget.pet?.notes);
  late String _species = widget.pet?.species ?? 'dog';
  late DateTime? _birth = widget.pet?.birthDate;
  late String? _photo = widget.pet?.photoPath;
  bool _saved = false;

  /// A photo picked in this form but not saved yet; safe to delete.
  bool get _photoIsDraft => _photo != null && _photo != widget.pet?.photoPath;

  Future<void> _pickPhoto() async {
    final name = await pickPhoto(context);
    if (name == null) return;
    if (_photoIsDraft) deletePhoto(_photo);
    setState(() => _photo = name);
  }

  void _removePhoto() {
    if (_photoIsDraft) deletePhoto(_photo);
    setState(() => _photo = null);
  }

  @override
  void dispose() {
    if (!_saved && _photoIsDraft) deletePhoto(_photo);
    super.dispose();
  }

  String? _nullIfEmpty(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    if (!_key.currentState!.validate()) return;
    final companion = PetsCompanion(
      name: Value(_name.text.trim()),
      species: Value(_species),
      breed: Value(_nullIfEmpty(_breed)),
      birthDate: Value(_birth),
      chip: Value(_nullIfEmpty(_chip)),
      vetName: Value(_nullIfEmpty(_vet)),
      vetPhone: Value(_nullIfEmpty(_vetPhone)),
      notes: Value(_nullIfEmpty(_notes)),
      photoPath: Value(_photo),
    );
    final id = widget.pet?.id;
    if (id == null) {
      await db.into(db.pets).insert(companion);
    } else {
      await (db.update(db.pets)..where((p) => p.id.equals(id))).write(companion);
    }
    _saved = true;
    if (widget.pet?.photoPath != _photo) deletePhoto(widget.pet?.photoPath);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await (db.delete(db.pets)..where((p) => p.id.equals(widget.pet!.id))).go();
    _saved = true;
    deletePhoto(widget.pet!.photoPath);
    if (_photoIsDraft) deletePhoto(_photo);
    if (!mounted) return;
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet == null ? t.addPet : t.editPet),
        actions: [
          if (widget.pet != null)
            IconButton(
                tooltip: t.delete,
                icon: const Icon(Icons.delete_outline),
                onPressed: _delete),
        ],
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: Stack(alignment: Alignment.bottomRight, children: [
                  PetAvatar(
                      name: _name.text.trim().isEmpty ? '?' : _name.text.trim(),
                      photo: _photo,
                      radius: 48),
                  const CircleAvatar(radius: 14, child: Icon(Icons.photo_camera, size: 16)),
                ]),
              ),
            ),
            if (_photo != null)
              TextButton(onPressed: _removePhoto, child: Text(t.removePhoto)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(labelText: t.name),
              validator: (v) => (v == null || v.trim().isEmpty) ? t.required : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _species,
              decoration: InputDecoration(labelText: t.species),
              items: [
                for (final s in ['dog', 'cat', 'other'])
                  DropdownMenuItem(value: s, child: Text(speciesLabel(t, s))),
              ],
              onChanged: (v) => setState(() => _species = v!),
            ),
            const SizedBox(height: 12),
            TextFormField(controller: _breed, decoration: InputDecoration(labelText: t.breed)),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.birthDate),
              subtitle: Text(_birth == null ? '-' : DateFormat.yMd(locale).format(_birth!)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _birth ?? DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now(),
                );
                if (d != null) setState(() => _birth = d);
              },
            ),
            TextFormField(controller: _chip, decoration: InputDecoration(labelText: t.chip)),
            const SizedBox(height: 12),
            TextFormField(controller: _vet, decoration: InputDecoration(labelText: t.vetName)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _vetPhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: t.vetPhone),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              maxLines: 3,
              decoration: InputDecoration(labelText: t.notes),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(t.save)),
          ],
        ),
      ),
    );
  }
}
