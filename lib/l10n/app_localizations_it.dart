// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'I miei animali';

  @override
  String get noPets => 'Nessun animale. Tocca + per aggiungerne uno.';

  @override
  String get addPet => 'Aggiungi animale';

  @override
  String get editPet => 'Modifica animale';

  @override
  String get name => 'Nome';

  @override
  String get species => 'Specie';

  @override
  String get dog => 'Cane';

  @override
  String get cat => 'Gatto';

  @override
  String get other => 'Altro';

  @override
  String get breed => 'Razza';

  @override
  String get birthDate => 'Data di nascita';

  @override
  String get chip => 'Microchip / tatuaggio';

  @override
  String get vetName => 'Veterinario';

  @override
  String get vetPhone => 'Telefono del veterinario';

  @override
  String get notes => 'Note';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get required => 'Obbligatorio';

  @override
  String get healthBook => 'Libretto sanitario';

  @override
  String get info => 'Info';

  @override
  String get vaccine => 'Vaccino';

  @override
  String get dewormer => 'Vermifugo';

  @override
  String get flea => 'Antipulci';

  @override
  String get addRecord => 'Aggiungi voce';

  @override
  String get product => 'Prodotto / vaccino';

  @override
  String get date => 'Data';

  @override
  String get nextDue => 'Prossima scadenza';

  @override
  String get remindDaysBefore => 'Ricordami (giorni prima)';

  @override
  String get noRecords => 'Nessuna voce.';

  @override
  String dueOn(String date) {
    return 'Scade il $date';
  }
}
