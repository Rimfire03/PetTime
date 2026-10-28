// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'Meine Tiere';

  @override
  String get noPets => 'Noch kein Tier. Tippe auf +, um eines hinzuzufügen.';

  @override
  String get addPet => 'Tier hinzufügen';

  @override
  String get editPet => 'Tier bearbeiten';

  @override
  String get name => 'Name';

  @override
  String get species => 'Tierart';

  @override
  String get dog => 'Hund';

  @override
  String get cat => 'Katze';

  @override
  String get other => 'Andere';

  @override
  String get breed => 'Rasse';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get chip => 'Mikrochip / Tätowierung';

  @override
  String get vetName => 'Tierarzt';

  @override
  String get vetPhone => 'Telefon des Tierarztes';

  @override
  String get notes => 'Notizen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get required => 'Pflichtfeld';

  @override
  String get healthBook => 'Impfpass';

  @override
  String get info => 'Infos';

  @override
  String get vaccine => 'Impfung';

  @override
  String get dewormer => 'Entwurmung';

  @override
  String get flea => 'Floh- & Zeckenschutz';

  @override
  String get addRecord => 'Eintrag hinzufügen';

  @override
  String get product => 'Produkt / Impfstoff';

  @override
  String get date => 'Datum';

  @override
  String get nextDue => 'Nächster Termin';

  @override
  String get remindDaysBefore => 'Erinnern (Tage vorher)';

  @override
  String get reminderChannel => 'Erinnerungen';

  @override
  String get weight => 'Gewicht';

  @override
  String get addWeight => 'Gewicht hinzufügen';

  @override
  String get weightKg => 'Gewicht (kg)';

  @override
  String get noWeights => 'Noch kein Gewicht.';

  @override
  String get appointments => 'Termine';

  @override
  String get addAppointment => 'Termin hinzufügen';

  @override
  String get appointmentTitle => 'Grund';

  @override
  String get place => 'Ort';

  @override
  String get time => 'Uhrzeit';

  @override
  String get noAppointments => 'Keine Termine.';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseFromGallery => 'Aus der Galerie wählen';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get exportPdf => 'Als PDF exportieren';

  @override
  String get backupExport => 'Backup exportieren';

  @override
  String get backupImport => 'Backup importieren';

  @override
  String get backupSaved => 'Backup gespeichert.';

  @override
  String get backupRestored => 'Backup wiederhergestellt.';

  @override
  String get backupInvalid => 'Diese Datei ist kein gültiges PetTime-Backup.';

  @override
  String get restoreConfirm =>
      'Dadurch werden ALLE aktuellen Daten durch das Backup ersetzt. Fortfahren?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get privacySettings => 'Datenschutz & Werbung';

  @override
  String get sharePet => 'Dieses Tier teilen';

  @override
  String get shareExplain =>
      'Gib diesen Code an die Personen weiter, mit denen du teilen möchtest. Er gilt 7 Tage. Sie können Einträge hinzufügen und bearbeiten, alles bleibt synchron. Alle melden sich mit Google an.';

  @override
  String get copyCode => 'Code kopieren';

  @override
  String get codeCopied => 'Code kopiert.';

  @override
  String get joinWithCode => 'Mit Code beitreten';

  @override
  String get codeLabel => 'Einladungscode';

  @override
  String get join => 'Beitreten';

  @override
  String get joinFailed => 'Ungültiger oder abgelaufener Code.';

  @override
  String get syncFailed => 'Server nicht erreichbar. Prüfe deine Verbindung.';

  @override
  String get operation => 'Operation';

  @override
  String get services => 'Dienste';

  @override
  String get addService => 'Dienst hinzufügen';

  @override
  String get serviceKind => 'Art';

  @override
  String get groomer => 'Hundefriseur';

  @override
  String get petSitter => 'Tiersitter';

  @override
  String get boarding => 'Tierpension';

  @override
  String get address => 'Adresse';

  @override
  String get phone => 'Telefon';

  @override
  String get bookingLink => 'Buchungslink oder Website';

  @override
  String get noServices => 'Noch keine Dienste.';

  @override
  String get call => 'Anrufen';

  @override
  String get openLink => 'Link öffnen';

  @override
  String removeAds(String price) {
    return 'Werbung entfernen ($price)';
  }

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get rabbit => 'Kaninchen';

  @override
  String get welcome => 'Willkommen bei PetTime';

  @override
  String get signInExplain =>
      'Melde dich mit Google an, um deine Tiere sicher in deinem Konto zu behalten. Deine Tiere folgen dir auf jedes Handy, und du kannst ein Tier mit deiner Familie teilen.';

  @override
  String get signInWithGoogle => 'Weiter mit Google';

  @override
  String get logout => 'Abmelden';

  @override
  String get logoutConfirm =>
      'Abmelden und die Daten dieses Kontos von diesem Handy entfernen? Sie bleiben sicher in der Cloud und kommen bei der nächsten Anmeldung zurück. Fotos werden nicht in der Cloud gespeichert und gelöscht.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n Änderungen wurden noch nicht an die Cloud gesendet und gehen verloren.',
      one: '1 Änderung wurde noch nicht an die Cloud gesendet und geht verloren.',
    );
    return '$_temp0';
  }

  @override
  String get recordType => 'Art der Behandlung';

  @override
  String repeatEvery(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'alle $n Monate',
      one: 'jeden Monat',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote =>
      'Vorgeschlagenes Datum: bitte mit dem Tierarzt abstimmen.';

  @override
  String get weighedOn => 'Gewogen am';

  @override
  String get saveAndAddAnother => 'Speichern und weiteres hinzufügen';

  @override
  String savedLine(String text) {
    return 'Gespeichert: $text';
  }

  @override
  String get addToCalendar => 'Zu Google Kalender hinzufügen';

  @override
  String get appointmentSaved => 'Termin gespeichert.';

  @override
  String get wizardNameQ => 'Wie heißt dein Tier?';

  @override
  String wizardSpeciesQ(String name) {
    return 'Was für ein Tier ist $name?';
  }

  @override
  String wizardSexQ(String name) {
    return 'Ist $name männlich oder weiblich?';
  }

  @override
  String wizardBreedQ(String name) {
    return 'Welche Rasse ist $name?';
  }

  @override
  String wizardBirthQ(String name) {
    return 'Wann wurde $name geboren?';
  }

  @override
  String wizardColorQ(String name) {
    return 'Welche Fellfarbe hat $name?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Füge ein Foto von $name hinzu';
  }

  @override
  String wizardChipQ(String name) {
    return 'Wie lautet die Mikrochip- oder Tätowiernummer von $name?';
  }

  @override
  String wizardWeightQ(String name) {
    return 'Wie viel wiegt $name?';
  }

  @override
  String wizardVetQ(String name) {
    return 'Wer ist der Tierarzt von $name?';
  }

  @override
  String get wizardVetPhoneQ => 'Wie lautet die Telefonnummer des Tierarztes?';

  @override
  String wizardVaccineQ(String name) {
    return 'Wurde $name kürzlich geimpft?';
  }

  @override
  String wizardNotesQ(String name) {
    return 'Gibt es etwas Wichtiges über $name?';
  }

  @override
  String get next => 'Weiter';

  @override
  String get skip => 'Überspringen';

  @override
  String get finish => 'Fertig';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get sex => 'Geschlecht';

  @override
  String get color => 'Farbe';

  @override
  String get chooseDate => 'Datum wählen';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get noRecords => 'Noch keine Einträge.';

  @override
  String dueOn(String date) {
    return 'Fällig am $date';
  }

  @override
  String deletePetTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get deletePetLocal =>
      'Das Gesundheitsbuch dieses Tieres wird endgültig gelöscht.';

  @override
  String get deletePetOwner =>
      'Dieses Tier ist geteilt: Es wird für alle Personen mit Zugriff gelöscht.';

  @override
  String get deletePetMember =>
      'Dieses Tier ist mit Ihnen geteilt: Es wird aus Ihrem Konto entfernt, die anderen behalten es.';

  @override
  String get deletePetAction => 'Dieses Tier löschen';

  @override
  String get sharesTitle => 'Freigaben';

  @override
  String get sharesMembers => 'Personen mit Zugriff';

  @override
  String get sharesOwnerTag => 'Eigentümer';

  @override
  String get sharesYouTag => 'Sie';

  @override
  String get sharesUnknown => 'Mitglied';

  @override
  String get sharesRevoke => 'Entziehen';

  @override
  String sharesRevokeConfirm(String name) {
    return 'Zugriff für $name entziehen? Die Person sieht dieses Tier nicht mehr. Widerrufen Sie auch noch aktive Einladungscodes.';
  }

  @override
  String get sharesInvites => 'Aktive Einladungscodes';

  @override
  String sharesInviteExpires(String date) {
    return 'Läuft ab am $date';
  }

  @override
  String get sharesNoInvites => 'Kein aktiver Code.';

  @override
  String get sharesNewCode => 'Einladungscode erstellen';

  @override
  String get sharesOffline =>
      'Dieses Tier ist noch nicht synchronisiert. Versuchen Sie es online erneut.';

  @override
  String get scanBarcode => 'Barcode scannen';

  @override
  String get scanHint =>
      'Richten Sie die Kamera auf den Barcode des Mikrochips.';

  @override
  String get cameraUnavailable =>
      'Kamera nicht verfügbar. Erlauben Sie den Kamerazugriff in den Telefoneinstellungen.';
}
