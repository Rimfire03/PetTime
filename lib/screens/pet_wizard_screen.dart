import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../breeds.dart';
import '../care_catalog.dart';
import '../data/db.dart';
import '../l10n/app_localizations.dart';
import '../photos.dart';
import '../suggestions.dart';
import '../widgets/suggest_field.dart';
import '../labels.dart' show speciesLabel;

enum WizardStep { name, species, sex, breed, birth, color, photo, chip, weight, vet, vetPhone, vaccine, notes }

/// The steps to ask for [species]; the vaccine question is dropped when the catalogue has none.
List<WizardStep> wizardSteps(String species) => [
      for (final s in WizardStep.values)
        if (s != WizardStep.vaccine || (careCatalog[species]?[RecordType.vaccine]?.isNotEmpty ?? false)) s,
    ];

/// "4,2" and "4.2" both give 4.2; null when empty, not a number or not positive.
double? parseWeight(String text) {
  final v = double.tryParse(text.trim().replaceAll(',', '.'));
  return v != null && v > 0 ? v : null;
}

/// What the person answered so far. Text fields are raw; trimming happens when mapping to rows.
class WizardAnswers {
  WizardAnswers({
    this.name = '',
    this.species = 'dog',
    this.sex,
    this.breed = '',
    this.birth,
    this.color = '',
    this.photo,
    this.chip = '',
    this.weight = '',
    this.vet = '',
    this.vetPhone = '',
    this.vaccine,
    this.vaccineDate,
    this.notes = '',
  });

  String name, species, breed, color, chip, weight, vet, vetPhone, notes;
  String? sex, photo;
  DateTime? birth, vaccineDate;
  CareSuggestion? vaccine;

  static String? _n(String s) => s.trim().isEmpty ? null : s.trim();

  /// Whether the Next button is enabled on [step].
  bool canGoNext(WizardStep step) => switch (step) {
        WizardStep.name => name.trim().isNotEmpty,
        WizardStep.weight => weight.trim().isEmpty || parseWeight(weight) != null,
        _ => true,
      };

  PetsCompanion toPet() => PetsCompanion(
        name: Value(name.trim()),
        species: Value(species),
        sex: Value(sex),
        breed: Value(_n(breed)),
        birthDate: Value(birth),
        color: Value(_n(color)),
        photoPath: Value(photo),
        chip: Value(_n(chip)),
        vetName: Value(_n(vet)),
        vetPhone: Value(_n(vetPhone)),
        notes: Value(_n(notes)),
      );

  WeightsCompanion? toWeight(int petId, DateTime today) {
    final kg = parseWeight(weight);
    if (kg == null) return null;
    return WeightsCompanion(petId: Value(petId), date: Value(today), kg: Value(kg));
  }

  /// Only when both the vaccine and its date are set.
  HealthRecordsCompanion? toVaccine(int petId, String languageCode) {
    final v = vaccine, d = vaccineDate;
    if (v == null || d == null) return null;
    final months = v.repeatMonths;
    return HealthRecordsCompanion(
      petId: Value(petId),
      type: const Value(RecordType.vaccine),
      product: Value(v.nameFor(languageCode)),
      date: Value(d),
      nextDue: Value(months == null ? null : addMonths(d, months)),
      remindDaysBefore: const Value(7),
    );
  }
}

class PetWizardScreen extends StatefulWidget {
  const PetWizardScreen({super.key});

  @override
  State<PetWizardScreen> createState() => _PetWizardScreenState();
}

class _PetWizardScreenState extends State<PetWizardScreen> {
  final _a = WizardAnswers();
  final _name = TextEditingController();
  final _breed = TextEditingController();
  final _color = TextEditingController();
  final _chip = TextEditingController();
  final _weight = TextEditingController();
  final _vet = TextEditingController();
  final _vetPhone = TextEditingController();
  final _notes = TextEditingController();
  List<String> _vets = const [];
  int _index = 0;
  bool _forward = true;
  bool _saving = false;
  bool _saved = false;

  List<WizardStep> get _steps => wizardSteps(_a.species);
  WizardStep get _step => _steps[_index];

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() => _a.name = _name.text));
    _weight.addListener(() => setState(() => _a.weight = _weight.text));
    usedValues('pets', 'vet_name').then((v) {
      if (mounted) _vets = v;
    });
  }

  @override
  void dispose() {
    if (!_saved) deletePhoto(_a.photo); // picked but never saved
    for (final c in [_name, _breed, _color, _chip, _weight, _vet, _vetPhone, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  // Controllers without a listener are copied just before leaving their step.
  void _collect() {
    _a
      ..breed = _breed.text
      ..color = _color.text
      ..chip = _chip.text
      ..vet = _vet.text
      ..vetPhone = _vetPhone.text
      ..notes = _notes.text;
  }

  void _go(int delta) => setState(() {
        _forward = delta > 0;
        _index += delta;
      });

  void _back() => _index == 0 ? Navigator.pop(context) : _go(-1);

  void _next() {
    _collect();
    if (!_a.canGoNext(_step)) return;
    if (_index == _steps.length - 1) {
      _save();
    } else {
      _go(1);
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final lang = Localizations.localeOf(context).languageCode;
    await db.transaction(() async {
      final id = await db.into(db.pets).insert(_a.toPet());
      final w = _a.toWeight(id, DateTime.now());
      if (w != null) await db.into(db.weights).insert(w);
      final v = _a.toVaccine(id, lang);
      if (v != null) await db.into(db.healthRecords).insert(v);
    });
    _saved = true;
    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickPhoto() async {
    final name = await pickPhoto(context);
    if (name == null) return;
    deletePhoto(_a.photo);
    setState(() => _a.photo = name);
  }

  Future<DateTime?> _pickDate(DateTime? initial) => showDatePicker(
        context: context,
        initialDate: initial ?? DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final steps = _steps;
    final last = _index == steps.length - 1;
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.addPet),
          leading: BackButton(onPressed: _back),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(value: (_index + 1) / steps.length),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(begin: Offset(_forward ? 0.1 : -0.1, 0), end: Offset.zero).animate(anim),
                  child: child,
                ),
              ),
              child: SingleChildScrollView(
                key: ValueKey(_step),
                padding: const EdgeInsets.all(16),
                child: _buildStep(context, t),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              if (_index > 0) TextButton(onPressed: _saving ? null : _next, child: Text(t.skip)),
              const Spacer(),
              FilledButton(
                onPressed: _a.canGoNext(_step) && !_saving ? _next : null,
                child: Text(last ? t.finish : t.next),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _question(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
      );

  Widget _buildStep(BuildContext context, AppLocalizations t) {
    final n = _a.name.trim();
    final lang = Localizations.localeOf(context).languageCode;
    final locale = Localizations.localeOf(context).toString();
    String fmt(DateTime d) => DateFormat.yMd(locale).format(d);
    const action = TextInputAction.next;

    return switch (_step) {
      WizardStep.name => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardNameQ),
          TextField(
            controller: _name,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            textInputAction: action,
            decoration: InputDecoration(labelText: t.name),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.species => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardSpeciesQ(n)),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              for (final (s, icon) in [('dog', '🐶'), ('cat', '🐱'), ('rabbit', '🐰'), ('other', '🐾')])
                _Tile(
                  label: speciesLabel(t, s),
                  icon: icon,
                  selected: _a.species == s,
                  onTap: () => setState(() {
                    if (_a.species != s) _a.vaccine = null; // the catalogue depends on the species
                    _a.species = s;
                  }),
                ),
            ],
          ),
        ]),
      WizardStep.sex => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardSexQ(n)),
          Wrap(spacing: 12, runSpacing: 12, children: [
            for (final (v, label) in [('male', t.male), ('female', t.female), (null, t.unknown)])
              ChoiceChip(
                label: Text(label),
                selected: _a.sex == v,
                onSelected: (_) => setState(() => _a.sex = v),
              ),
          ]),
        ]),
      WizardStep.breed => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardBreedQ(n)),
          SuggestField(
            controller: _breed,
            label: t.breed,
            autofocus: true,
            textInputAction: action,
            options: (q) => suggestBreeds(_a.species, q),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.birth => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardBirthQ(n)),
          OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: Text(_a.birth == null ? t.chooseDate : fmt(_a.birth!)),
            onPressed: () async {
              final d = await _pickDate(_a.birth);
              if (d != null) setState(() => _a.birth = d);
            },
          ),
        ]),
      WizardStep.color => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardColorQ(n)),
          SuggestField(
            controller: _color,
            label: t.color,
            autofocus: true,
            textInputAction: action,
            options: (q) => filterSuggestions(colorsFor(_a.species, lang), q, allWhenEmpty: true),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.photo => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardPhotoQ(n)),
          Center(
            child: GestureDetector(
              onTap: _pickPhoto,
              child: Stack(alignment: Alignment.bottomRight, children: [
                PetAvatar(name: n, photo: _a.photo, radius: 64),
                const CircleAvatar(radius: 18, child: Icon(Icons.photo_camera, size: 20)),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Center(child: TextButton(onPressed: _pickPhoto, child: Text(t.addPhoto))),
        ]),
      WizardStep.chip => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardChipQ(n)),
          TextField(
            controller: _chip,
            autofocus: true,
            textInputAction: action,
            decoration: InputDecoration(labelText: t.chip),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.weight => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardWeightQ(n)),
          TextField(
            controller: _weight,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: action,
            decoration: InputDecoration(labelText: t.weightKg),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.vet => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardVetQ(n)),
          SuggestField(
            controller: _vet,
            label: t.vetName,
            autofocus: true,
            textInputAction: action,
            options: (q) => filterSuggestions(_vets, q),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.vetPhone => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardVetPhoneQ),
          TextField(
            controller: _vetPhone,
            autofocus: true,
            keyboardType: TextInputType.phone,
            textInputAction: action,
            decoration: InputDecoration(labelText: t.vetPhone),
            onSubmitted: (_) => _next(),
          ),
        ]),
      WizardStep.vaccine => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardVaccineQ(n)),
          DropdownButtonFormField<CareSuggestion>(
            isExpanded: true,
            initialValue: _a.vaccine,
            decoration: InputDecoration(labelText: t.vaccine),
            items: [
              for (final s in suggestCare(_a.species, RecordType.vaccine, '', lang))
                DropdownMenuItem(value: s, child: Text(s.nameFor(lang), overflow: TextOverflow.ellipsis)),
            ],
            onChanged: (v) => setState(() => _a.vaccine = v),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: Text(_a.vaccineDate == null ? t.chooseDate : fmt(_a.vaccineDate!)),
            onPressed: () async {
              final d = await _pickDate(_a.vaccineDate);
              if (d != null) setState(() => _a.vaccineDate = d);
            },
          ),
        ]),
      WizardStep.notes => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _question(t.wizardNotesQ(n)),
          TextField(
            controller: _notes,
            autofocus: true,
            maxLines: 4,
            decoration: InputDecoration(labelText: t.notes),
          ),
        ]),
    };
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.icon, required this.selected, required this.onTap});
  final String label, icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Material(
      color: selected ? c.primaryContainer : c.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: selected ? c.primary : Colors.transparent, width: 2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(icon, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ]),
      ),
    );
  }
}
