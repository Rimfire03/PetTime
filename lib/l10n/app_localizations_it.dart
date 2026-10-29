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
  String get wizardNameQ => 'Come si chiama il tuo animale?';

  @override
  String wizardSpeciesQ(String name) {
    return 'Che tipo di animale è $name?';
  }

  @override
  String wizardSexQ(String name) {
    return '$name è maschio o femmina?';
  }

  @override
  String wizardBreedQ(String name) {
    return 'Di che razza è $name?';
  }

  @override
  String wizardBirthQ(String name) {
    return 'Quando è nato $name?';
  }

  @override
  String wizardColorQ(String name) {
    return 'Di che colore è il pelo di $name?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Aggiungi una foto di $name';
  }

  @override
  String wizardChipQ(String name) {
    return 'Qual è il numero di microchip o tatuaggio di $name?';
  }

  @override
  String wizardWeightQ(String name) {
    return 'Quanto pesa $name?';
  }

  @override
  String wizardVetQ(String name) {
    return 'Chi è il veterinario di $name?';
  }

  @override
  String get wizardVetPhoneQ => 'Qual è il numero di telefono del veterinario?';

  @override
  String wizardVaccineQ(String name) {
    return '$name ha fatto un vaccino di recente?';
  }

  @override
  String wizardNotesQ(String name) {
    return 'Qualcosa da ricordare su $name?';
  }

  @override
  String get next => 'Avanti';

  @override
  String get skip => 'Salta';

  @override
  String get finish => 'Fine';

  @override
  String get male => 'Maschio';

  @override
  String get female => 'Femmina';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get sex => 'Sesso';

  @override
  String get color => 'Colore';

  @override
  String get chooseDate => 'Scegli una data';

  @override
  String get addPhoto => 'Aggiungi una foto';

  @override
  String get noRecords => 'Nessuna voce.';

  @override
  String dueOn(String date) {
    return 'Scade il $date';
  }

  @override
  String deletePetTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get deletePetLocal =>
      'Il libretto sanitario di questo animale verrà eliminato definitivamente.';

  @override
  String get deletePetOwner =>
      'Questo animale è condiviso: verrà eliminato per tutte le persone con accesso.';

  @override
  String get deletePetMember =>
      'Questo animale è condiviso con te: verrà rimosso dal tuo account, gli altri lo mantengono.';

  @override
  String get deletePetAction => 'Elimina questo animale';

  @override
  String get sharesTitle => 'Condivisioni';

  @override
  String get sharesMembers => 'Persone con accesso';

  @override
  String get sharesOwnerTag => 'Proprietario';

  @override
  String get sharesYouTag => 'Tu';

  @override
  String get sharesUnknown => 'Membro';

  @override
  String get sharesRevoke => 'Revoca';

  @override
  String sharesRevokeConfirm(String name) {
    return 'Rimuovere l\'accesso a $name? Questa persona non vedrà più questo animale. Revoca anche i codici di invito ancora attivi.';
  }

  @override
  String get sharesInvites => 'Codici di invito attivi';

  @override
  String sharesInviteExpires(String date) {
    return 'Scade il $date';
  }

  @override
  String get sharesNoInvites => 'Nessun codice attivo.';

  @override
  String get sharesNewCode => 'Crea un codice di invito';

  @override
  String get sharesOffline =>
      'Questo animale non è ancora sincronizzato. Riprova quando sei online.';

  @override
  String get scanBarcode => 'Scansiona il codice a barre';

  @override
  String get scanHint => 'Inquadra il codice a barre del microchip.';

  @override
  String get cameraUnavailable =>
      'Fotocamera non disponibile. Consenti l\'accesso alla fotocamera nelle impostazioni del telefono.';

  @override
  String get sharesTransfer => 'Trasferisci la proprietà';

  @override
  String get sharesTransferDo => 'Trasferisci';

  @override
  String sharesTransferConfirm(String name) {
    return '$name diventerà proprietario di questo animale: solo il proprietario può eliminarlo per tutti, rimuovere accessi e creare codici di invito.';
  }

  @override
  String get sharesTransferLeave =>
      'Rimuovi questo animale dal mio account dopo il trasferimento';

  @override
  String get sharesTransferHelp =>
      'Per cedere questo animale: condividilo con la persona (codice di invito), poi scegli \"Trasferisci la proprietà\" sul suo nome.';

  @override
  String get deleteOnlyOwner =>
      'Solo il proprietario dell\'animale può eliminarlo.';

  @override
  String get leaveShare => 'Esci da questa condivisione';

  @override
  String leaveShareTitle(String name) {
    return 'Uscire dalla condivisione di $name?';
  }

  @override
  String get leaveShareBody =>
      'Questo animale scomparirà dal tuo account. Gli altri lo mantengono e potrai ritrovarlo con un nuovo codice di invito.';
}
