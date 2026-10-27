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
  String get sharePet => 'Condividi questo animale';

  @override
  String get shareExplain =>
      'Dai questo codice alle persone con cui condividere. Vale 7 giorni. Possono aggiungere e modificare le voci e tutto resta sincronizzato. Tutti accedono con Google.';

  @override
  String get copyCode => 'Copia codice';

  @override
  String get codeCopied => 'Codice copiato.';

  @override
  String get joinWithCode => 'Unisciti con un codice';

  @override
  String get codeLabel => 'Codice d\'invito';

  @override
  String get join => 'Unisciti';

  @override
  String get joinFailed => 'Codice non valido o scaduto.';

  @override
  String get syncFailed =>
      'Server non raggiungibile. Controlla la connessione.';

  @override
  String get operation => 'Operazione';

  @override
  String get services => 'Servizi';

  @override
  String get addService => 'Aggiungi un servizio';

  @override
  String get serviceKind => 'Tipo';

  @override
  String get groomer => 'Toelettatore';

  @override
  String get petSitter => 'Pet sitter';

  @override
  String get boarding => 'Pensione';

  @override
  String get address => 'Indirizzo';

  @override
  String get phone => 'Telefono';

  @override
  String get bookingLink => 'Link di prenotazione o sito web';

  @override
  String get noServices => 'Nessun servizio.';

  @override
  String get call => 'Chiama';

  @override
  String get openLink => 'Apri il link';

  @override
  String removeAds(String price) {
    return 'Rimuovi la pubblicità ($price)';
  }

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get rabbit => 'Coniglio';

  @override
  String get welcome => 'Benvenuto in PetTime';

  @override
  String get signInExplain =>
      'Accedi con Google per tenere al sicuro i tuoi animali nel tuo account. I tuoi animali ti seguono su ogni telefono e puoi condividere un animale con la tua famiglia.';

  @override
  String get signInWithGoogle => 'Continua con Google';

  @override
  String get logout => 'Esci';

  @override
  String get logoutConfirm =>
      'Uscire e rimuovere i dati di questo account da questo telefono? Restano al sicuro nel cloud e tornano quando accedi di nuovo. Le foto non sono salvate nel cloud e verranno rimosse.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n modifiche non sono ancora state inviate al cloud e andranno perse.',
      one: '1 modifica non è ancora stata inviata al cloud e andrà persa.',
    );
    return '$_temp0';
  }

  @override
  String get recordType => 'Tipo di cura';

  @override
  String repeatEvery(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'ogni $n mesi',
      one: 'ogni mese',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote =>
      'Data suggerita: confermala con il tuo veterinario.';

  @override
  String get weighedOn => 'Pesato il';

  @override
  String get saveAndAddAnother => 'Salva e aggiungi un altro';

  @override
  String savedLine(String text) {
    return 'Salvato: $text';
  }

  @override
  String get addToCalendar => 'Aggiungi a Google Calendar';

  @override
  String get appointmentSaved => 'Appuntamento salvato.';

  @override
  String get noRecords => 'Nessuna voce.';

  @override
  String dueOn(String date) {
    return 'Scade il $date';
  }
}
