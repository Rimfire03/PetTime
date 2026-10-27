import 'data/db.dart';

/// A suggestion written in French and English (other languages get English).
class Bilingual {
  const Bilingual(this.fr, this.en);
  final String fr;
  final String en;
  String name(String languageCode) => languageCode == 'fr' ? fr : en;
}

/// Lower case without accents, so "Épagneul" matches "epagneul".
String foldText(String s) {
  const from = 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿœæ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyyoa';
  final b = StringBuffer();
  for (final c in s.toLowerCase().split('')) {
    final i = from.indexOf(c);
    b.write(i < 0 ? c : to[i]);
  }
  return b.toString();
}

/// Entries of [all] matching what was typed: those that start with it first, then those that merely
/// contain it. Ignores case and accents. Nothing once the typed text is already a complete entry.
/// With [allWhenEmpty], an empty query lists everything (for short lists like colours).
List<String> filterSuggestions(Iterable<String> all, String query, {int limit = 8, bool allWhenEmpty = false}) {
  final q = foldText(query.trim());
  if (q.isEmpty) return allWhenEmpty ? all.take(limit).toList() : const [];
  final starts = <String>[], contains = <String>[];
  for (final name in all) {
    final n = foldText(name);
    if (n == q) return const [];
    if (n.startsWith(q)) {
      starts.add(name);
    } else if (n.contains(q)) {
      contains.add(name);
    }
  }
  return [...starts, ...contains].take(limit).toList();
}

/// Coat colours, per species.
const colorsBySpecies = <String, List<Bilingual>>{
  'dog': [
    Bilingual('Noir', 'Black'), Bilingual('Blanc', 'White'), Bilingual('Marron', 'Brown'),
    Bilingual('Fauve', 'Fawn'), Bilingual('Crème', 'Cream'), Bilingual('Gris', 'Grey'),
    Bilingual('Sable', 'Sable'), Bilingual('Rouge', 'Red'), Bilingual('Doré', 'Golden'),
    Bilingual('Bringé', 'Brindle'), Bilingual('Tricolore', 'Tricolour'), Bilingual('Noir et feu', 'Black and tan'),
    Bilingual('Noir et blanc', 'Black and white'), Bilingual('Bleu', 'Blue'), Bilingual('Tacheté', 'Spotted'),
    Bilingual('Merle', 'Merle'),
  ],
  'cat': [
    Bilingual('Noir', 'Black'), Bilingual('Blanc', 'White'), Bilingual('Roux', 'Ginger'),
    Bilingual('Gris', 'Grey'), Bilingual('Gris bleu', 'Blue-grey'), Bilingual('Crème', 'Cream'),
    Bilingual('Tigré (tabby)', 'Tabby'), Bilingual('Écaille de tortue', 'Tortoiseshell'),
    Bilingual('Tricolore (calico)', 'Calico'), Bilingual('Bicolore', 'Bicolour'),
    Bilingual('Noir et blanc', 'Black and white'), Bilingual('Point de couleur (siamois)', 'Colourpoint'),
    Bilingual('Fumé', 'Smoke'), Bilingual('Chocolat', 'Chocolate'),
  ],
  'rabbit': [
    Bilingual('Blanc', 'White'), Bilingual('Noir', 'Black'), Bilingual('Gris', 'Grey'),
    Bilingual('Marron', 'Brown'), Bilingual('Agouti', 'Agouti'), Bilingual('Fauve', 'Fawn'),
    Bilingual('Chinchilla', 'Chinchilla'), Bilingual('Bleu', 'Blue'), Bilingual('Tacheté', 'Spotted'),
    Bilingual('Havane', 'Havana'), Bilingual('Noir et blanc', 'Black and white'),
  ],
};

/// Usual reasons for a visit.
const appointmentReasons = <Bilingual>[
  Bilingual('Visite annuelle', 'Annual check-up'),
  Bilingual('Vaccination', 'Vaccination'),
  Bilingual('Contrôle', 'Follow-up visit'),
  Bilingual('Consultation', 'Consultation'),
  Bilingual('Urgence', 'Emergency'),
  Bilingual('Détartrage', 'Dental cleaning'),
  Bilingual('Stérilisation / castration', 'Spaying / neutering'),
  Bilingual('Ablation des fils', 'Stitches removal'),
  Bilingual('Bilan sanguin', 'Blood test'),
  Bilingual('Radio / échographie', 'X-ray / ultrasound'),
  Bilingual('Consultation comportement', 'Behaviour consultation'),
  Bilingual('Toilettage', 'Grooming'),
];

List<String> colorsFor(String species, String languageCode) =>
    [for (final c in colorsBySpecies[species] ?? const <Bilingual>[]) c.name(languageCode)];

List<String> reasonsFor(String languageCode) => [for (final r in appointmentReasons) r.name(languageCode)];

/// Values the person already typed in a column (a vet's name, a place...), alphabetical, so a vet or a
/// groomer used for one pet is offered again for the next. [table] and [column] come from the code,
/// never from the user.
Future<List<String>> usedValues(String table, String column) async {
  final rows = await db
      .customSelect("SELECT DISTINCT TRIM($column) AS v FROM $table "
          "WHERE $column IS NOT NULL AND TRIM($column) <> '' ORDER BY v COLLATE NOCASE")
      .get();
  return [for (final r in rows) r.read<String>('v')];
}
