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
  String get reminderChannel => 'Promemoria';

  @override
  String get weight => 'Peso';

  @override
  String get addWeight => 'Aggiungi peso';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get noWeights => 'Nessun peso.';

  @override
  String get appointments => 'Appuntamenti';

  @override
  String get addAppointment => 'Aggiungi appuntamento';

  @override
  String get appointmentTitle => 'Motivo';

  @override
  String get place => 'Luogo';

  @override
  String get time => 'Ora';

  @override
  String get noAppointments => 'Nessun appuntamento.';

  @override
  String get takePhoto => 'Scatta una foto';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get removePhoto => 'Rimuovi foto';

  @override
  String get exportPdf => 'Esporta PDF';

  @override
  String get backupExport => 'Esporta backup';

  @override
  String get backupImport => 'Importa backup';

  @override
  String get backupSaved => 'Backup salvato.';

  @override
  String get backupRestored => 'Backup ripristinato.';

  @override
  String get backupInvalid => 'Questo file non è un backup PetTime valido.';

  @override
  String get restoreConfirm =>
      'Questo sostituisce TUTTI i dati attuali con il backup. Continuare?';

  @override
  String get cancel => 'Annulla';

  @override
  String get privacySettings => 'Privacy e pubblicità';

  @override
  String get noRecords => 'Nessuna voce.';

  @override
  String dueOn(String date) {
    return 'Scade il $date';
  }
}
