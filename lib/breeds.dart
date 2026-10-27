import 'suggestions.dart';

/// Breed names offered while typing, per species (the keys of `Pet.species`).
/// Names are the usual international ones; the field stays free text, so any other breed can be typed.
/// "other" has no list.
const breedsBySpecies = <String, List<String>>{
  'dog': _dogs,
  'cat': _cats,
  'rabbit': _rabbits,
};

const _dogs = [
  'Affenpinscher', 'Airedale Terrier', 'Akita Inu', 'Alaskan Malamute', 'American Staffordshire Terrier',
  'Barbet', 'Basenji', 'Basset Hound', 'Beagle', 'Berger allemand', 'Berger australien', 'Berger belge Malinois',
  'Berger blanc suisse', 'Berger des Pyrénées', 'Berger picard', 'Bichon frisé', 'Bichon havanais',
  'Bichon maltais', 'Border Collie', 'Border Terrier', 'Bouledogue français', 'Boxer', 'Braque allemand',
  'Braque de Weimar', 'Briard', 'Bull Terrier', 'Bulldog anglais', 'Bullmastiff', 'Cane Corso',
  'Caniche', 'Cavalier King Charles', 'Chihuahua', 'Chow-chow', 'Cocker américain', 'Cocker anglais',
  'Colley', 'Dalmatien', 'Dobermann', 'Dogue allemand', 'Dogue de Bordeaux', 'Épagneul breton',
  'Épagneul nain continental', 'Fox Terrier', 'Golden Retriever', 'Grand Bouvier suisse', 'Greyhound',
  'Griffon Bruxellois', 'Husky de Sibérie', 'Jack Russell Terrier', 'Kuvasz', 'Labrador Retriever',
  'Landseer', 'Lévrier afghan', 'Lévrier irlandais', 'Lhassa Apso', 'Malinois', 'Mastiff', 'Mâtin de Naples',
  'Montagne des Pyrénées', 'Mops (Carlin)', 'Nova Scotia Duck Tolling Retriever', 'Papillon',
  'Parson Russell Terrier', 'Pékinois', 'Petit Basset Griffon Vendéen', 'Pinscher nain', 'Pit-bull',
  'Pointer', 'Poodle', 'Rhodesian Ridgeback', 'Rottweiler', 'Saint-Bernard', 'Saluki', 'Samoyède',
  'Schnauzer', 'Setter anglais', 'Setter irlandais', 'Shar Pei', 'Shiba Inu', 'Shih Tzu',
  'Spitz allemand', 'Spitz nain (Loulou de Poméranie)', 'Springer anglais', 'Staffordshire Bull Terrier',
  'Teckel', 'Terre-Neuve', 'Terrier du Tibet', 'Terrier écossais', 'Vizsla', 'Welsh Corgi', 'Westie',
  'Whippet', 'Yorkshire Terrier', 'Croisé',
];

const _cats = [
  'Abyssin', 'American Shorthair', 'Angora turc', 'Balinais', 'Bengal', 'Birman', 'Bleu russe',
  'Bobtail japonais', 'Bombay', 'British Longhair', 'British Shorthair', 'Burmese', 'Burmilla',
  'Chartreux', 'Chat de gouttière (européen)', 'Chat des forêts norvégiennes', 'Cornish Rex',
  'Devon Rex', 'Exotic Shorthair', 'Havana Brown', 'Himalayen', 'Korat', 'LaPerm', 'Maine Coon',
  'Manx', 'Munchkin', 'Ocicat', 'Oriental', 'Persan', 'Ragdoll', 'Sacré de Birmanie', 'Savannah',
  'Scottish Fold', 'Selkirk Rex', 'Siamois', 'Sibérien', 'Singapura', 'Somali', 'Sphynx',
  'Tonkinois', 'Turc de Van', 'Croisé',
];

const _rabbits = [
  'Angora', 'Bélier nain', 'Bélier français', 'Bélier anglais', 'Californien', 'Chinchilla',
  'Fauve de Bourgogne', 'Géant des Flandres', 'Géant papillon français', 'Hotot', 'Lapin nain',
  'Lapin nain de couleur', 'Lionhead (tête de lion)', 'Mini Lop', 'Néo-Zélandais', 'Nain de Hollande',
  'Nain Rex', 'Petit Rex', 'Polonais', 'Rex', 'Russe', 'Satin', 'Teddy nain', 'Argenté de Champagne',
  'Blanc de Vienne', 'Croisé',
];

/// Up to [limit] breeds for [species] matching what has been typed so far (see [filterSuggestions]).
/// Nothing for an empty query, an unknown species or an exact match.
List<String> suggestBreeds(String species, String query, {int limit = 8}) =>
    filterSuggestions(breedsBySpecies[species] ?? const [], query, limit: limit);