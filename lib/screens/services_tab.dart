import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../contact_links.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';

String contactKindLabel(AppLocalizations t, ContactKind k) => switch (k) {
      ContactKind.groomer => t.groomer,
      ContactKind.petSitter => t.petSitter,
      ContactKind.boarding => t.boarding,
      ContactKind.other => t.other,
    };

IconData _icon(ContactKind k) => switch (k) {
      ContactKind.groomer => Icons.content_cut,
      ContactKind.petSitter => Icons.home,
      ContactKind.boarding => Icons.hotel,
      ContactKind.other => Icons.place,
    };

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key, required this.petId});
  final int petId;

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  late final Stream<List<PetContact>> _stream = db.watchContacts(widget.petId);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: StreamBuilder<List<PetContact>>(
        stream: _stream,
        builder: (context, snap) {
          final list = snap.data ?? [];
          if (list.isEmpty) return Center(child: Text(t.noServices));
          return ListView(
            children: [
              for (final c in list)
                Builder(builder: (context) {
                  final phone = phoneUri(c.phone);
                  final web = webUri(c.website);
                  return ListTile(
                    leading: Icon(_icon(c.kind)),
                    title: Text(c.name),
                    subtitle: Text([
                      contactKindLabel(t, c.kind),
                      if (c.address != null) c.address!,
                      if (c.phone != null) c.phone!,
                    ].join(' - ')),
                    onTap: () => _edit(context, widget.petId, c),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      if (phone != null)
                        IconButton(
                          tooltip: t.call,
                          icon: const Icon(Icons.call),
                          onPressed: () => openUri(phone),
                        ),
                      if (web != null)
                        IconButton(
                          tooltip: t.openLink,
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () => openUri(web),
                        ),
                    ]),
                  );
                }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: t.addService,
        onPressed: () => _edit(context, widget.petId),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _edit(BuildContext context, int petId, [PetContact? c]) =>
    showDialog<void>(context: context, builder: (_) => _ServiceDialog(petId: petId, contact: c));

class _ServiceDialog extends StatefulWidget {
  const _ServiceDialog({required this.petId, this.contact});
  final int petId;
  final PetContact? contact;

  @override
  State<_ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<_ServiceDialog> {
  late final _name = TextEditingController(text: widget.contact?.name);
  late final _address = TextEditingController(text: widget.contact?.address);
  late final _phone = TextEditingController(text: widget.contact?.phone);
  late final _website = TextEditingController(text: widget.contact?.website);
  late final _notes = TextEditingController(text: widget.contact?.notes);
  late ContactKind _kind = widget.contact?.kind ?? ContactKind.groomer;
  bool _nameMissing = false;

  String? _orNull(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return setState(() => _nameMissing = true);
    final c = PetContactsCompanion(
      petId: Value(widget.petId),
      kind: Value(_kind),
      name: Value(name),
      address: Value(_orNull(_address)),
      phone: Value(_orNull(_phone)),
      website: Value(_orNull(_website)),
      notes: Value(_orNull(_notes)),
    );
    final id = widget.contact?.id;
    if (id == null) {
      await db.into(db.petContacts).insert(c);
    } else {
      await (db.update(db.petContacts)..where((x) => x.id.equals(id))).write(c);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await (db.delete(db.petContacts)..where((x) => x.id.equals(widget.contact!.id))).go();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(t.addService),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          DropdownButtonFormField<ContactKind>(
            initialValue: _kind,
            decoration: InputDecoration(labelText: t.serviceKind),
            items: [
              for (final k in ContactKind.values)
                DropdownMenuItem(value: k, child: Text(contactKindLabel(t, k))),
            ],
            onChanged: (k) => setState(() => _kind = k!),
          ),
          TextField(
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(labelText: t.name, errorText: _nameMissing ? t.required : null),
          ),
          TextField(controller: _address, decoration: InputDecoration(labelText: t.address)),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: t.phone),
          ),
          TextField(
            controller: _website,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(labelText: t.bookingLink),
          ),
          TextField(controller: _notes, maxLines: 2, decoration: InputDecoration(labelText: t.notes)),
        ]),
      ),
      actions: [
        if (widget.contact != null) TextButton(onPressed: _delete, child: Text(t.delete)),
        FilledButton(onPressed: _save, child: Text(t.save)),
      ],
    );
  }
}
