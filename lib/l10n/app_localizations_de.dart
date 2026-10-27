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
  String get noRecords => 'Noch keine Einträge.';

  @override
  String dueOn(String date) {
    return 'Fällig am $date';
  }
}
