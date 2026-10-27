import 'data/db.dart';

/// One suggestion in the "add a care" form: a name and how often it is usually repeated.
/// [repeatMonths] only proposes the next due date; the vet's advice always wins, and the person
/// can change the date. Null = a one-off (an operation) or no usual rhythm.
class CareSuggestion {
  const CareSuggestion(this.fr, this.en, {this.repeatMonths});
  final String fr;
  final String en;
  final int? repeatMonths;

  /// French for French phones, English for everything else.
  String nameFor(String languageCode) => languageCode == 'fr' ? fr : en;
}

const _dogVaccines = [
  CareSuggestion('CHPPiL (carré, hépatite, parvovirose, parainfluenza, leptospirose)',
      'DHPPiL (distemper, hepatitis, parvovirus, parainfluenza, leptospirosis)', repeatMonths: 12),
  CareSuggestion('Rage', 'Rabies', repeatMonths: 12),
  CareSuggestion('Toux de chenil (Bordetella)', 'Kennel cough (Bordetella)', repeatMonths: 12),
  CareSuggestion('Maladie de Lyme (borréliose)', 'Lyme disease (borreliosis)', repeatMonths: 12),
  CareSuggestion('Leishmaniose', 'Leishmaniasis', repeatMonths: 12),
  CareSuggestion('Leptospirose', 'Leptospirosis', repeatMonths: 12),
];

const _catVaccines = [
  CareSuggestion('Typhus, coryza (TC)', 'Panleukopenia, cat flu (FVRCP)', repeatMonths: 12),
  CareSuggestion('Typhus, coryza, leucose (TCL)', 'Panleukopenia, cat flu, FeLV', repeatMonths: 12),
  CareSuggestion('Leucose féline (FeLV)', 'Feline leukaemia (FeLV)', repeatMonths: 12),
  CareSuggestion('Rage', 'Rabies', repeatMonths: 12),
  CareSuggestion('Chlamydiose', 'Chlamydia', repeatMonths: 12),
];

const _rabbitVaccines = [
  CareSuggestion('Myxomatose', 'Myxomatosis', repeatMonths: 6),
  CareSuggestion('Maladie hémorragique virale (VHD / RHDV2)', 'Viral haemorrhagic disease (VHD / RHDV2)',
      repeatMonths: 12),
  CareSuggestion('Myxomatose + VHD (vaccin combiné)', 'Myxomatosis + VHD (combined vaccine)', repeatMonths: 12),
];

const _pawDewormers = [
  CareSuggestion('Vermifuge (comprimé ou pâte)', 'Dewormer (tablet or paste)', repeatMonths: 3),
];

const _pawFleas = [
  CareSuggestion('Pipette antipuces et tiques', 'Flea and tick spot-on', repeatMonths: 1),
  CareSuggestion('Comprimé antipuces et tiques', 'Flea and tick tablet', repeatMonths: 3),
  CareSuggestion('Collier antiparasitaire', 'Flea and tick collar', repeatMonths: 8),
];

const _pawOperations = [
  CareSuggestion('Stérilisation (femelle)', 'Spaying'),
  CareSuggestion('Castration (mâle)', 'Neutering'),
  CareSuggestion('Détartrage', 'Dental scaling'),
  CareSuggestion('Extraction dentaire', 'Tooth extraction'),
  CareSuggestion('Chirurgie orthopédique', 'Orthopaedic surgery'),
];

const _rabbitOperations = [
  CareSuggestion('Stérilisation (femelle)', 'Spaying'),
  CareSuggestion('Castration (mâle)', 'Neutering'),
  CareSuggestion('Soin dentaire (limage des dents)', 'Dental care (tooth trimming)'),
];

/// species -> kind of care -> suggestions. A missing entry simply means no suggestion.
const careCatalog = <String, Map<RecordType, List<CareSuggestion>>>{
  'dog': {
    RecordType.vaccine: _dogVaccines,
    RecordType.dewormer: _pawDewormers,
    RecordType.flea: _pawFleas,
    RecordType.operation: _pawOperations,
  },
  'cat': {
    RecordType.vaccine: _catVaccines,
    RecordType.dewormer: _pawDewormers,
    RecordType.flea: _pawFleas,
    RecordType.operation: _pawOperations,
  },
  'rabbit': {
    RecordType.vaccine: _rabbitVaccines,
    RecordType.operation: _rabbitOperations,
  },
};

String _fold(String s) {
  const from = 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿœæ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyyoa';
  final b = StringBuffer();
  for (final c in s.toLowerCase().split('')) {
    final i = from.indexOf(c);
    b.write(i < 0 ? c : to[i]);
  }
  return b.toString();
}

/// Suggestions for [species] and [type] that match the typed [query] (ignoring case and accents).
/// An empty query returns the whole list, so the field offers the catalogue as soon as it is opened.
List<CareSuggestion> suggestCare(String species, RecordType type, String query, String languageCode) {
  final all = careCatalog[species]?[type];
  if (all == null) return const [];
  final q = _fold(query.trim());
  if (q.isEmpty) return all;
  return [
    for (final s in all)
      if (_fold(s.nameFor(languageCode)).contains(q) || _fold(s.fr).contains(q) || _fold(s.en).contains(q)) s,
  ];
}

/// [date] plus [months], keeping the day when the target month has it (31 Jan + 1 month = 28/29 Feb).
DateTime addMonths(DateTime date, int months) {
  final total = date.month - 1 + months;
  final year = date.year + total ~/ 12;
  final month = total % 12 + 1;
  final lastDay = DateTime(year, month + 1, 0).day;
  return DateTime(year, month, date.day > lastDay ? lastDay : date.day);
}
