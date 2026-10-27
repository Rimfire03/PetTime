// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'My pets';

  @override
  String get noPets => 'No pet yet. Tap + to add one.';

  @override
  String get addPet => 'Add a pet';

  @override
  String get editPet => 'Edit pet';

  @override
  String get name => 'Name';

  @override
  String get species => 'Species';

  @override
  String get dog => 'Dog';

  @override
  String get cat => 'Cat';

  @override
  String get other => 'Other';

  @override
  String get breed => 'Breed';

  @override
  String get birthDate => 'Birth date';

  @override
  String get chip => 'Microchip / tattoo';

  @override
  String get vetName => 'Veterinarian';

  @override
  String get vetPhone => 'Vet phone';

  @override
  String get notes => 'Notes';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get required => 'Required';

  @override
  String get healthBook => 'Health book';

  @override
  String get info => 'Info';

  @override
  String get vaccine => 'Vaccine';

  @override
  String get dewormer => 'Dewormer';

  @override
  String get flea => 'Flea & tick';

  @override
  String get addRecord => 'Add a record';

  @override
  String get product => 'Product / vaccine';

  @override
  String get date => 'Date';

  @override
  String get nextDue => 'Next due date';

  @override
  String get remindDaysBefore => 'Remind me (days before)';

  @override
  String get reminderChannel => 'Reminders';

  @override
  String get weight => 'Weight';

  @override
  String get addWeight => 'Add weight';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get noWeights => 'No weight yet.';

  @override
  String get appointments => 'Appointments';

  @override
  String get addAppointment => 'Add appointment';

  @override
  String get appointmentTitle => 'Reason';

  @override
  String get place => 'Place';

  @override
  String get time => 'Time';

  @override
  String get noAppointments => 'No appointment.';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get backupExport => 'Export backup';

  @override
  String get backupImport => 'Import backup';

  @override
  String get backupSaved => 'Backup saved.';

  @override
  String get backupRestored => 'Backup restored.';

  @override
  String get backupInvalid => 'This file is not a valid PetTime backup.';

  @override
  String get restoreConfirm =>
      'This replaces ALL current data with the backup. Continue?';

  @override
  String get cancel => 'Cancel';

  @override
  String get privacySettings => 'Privacy & ads settings';

  @override
  String get sharePet => 'Share this pet';

  @override
  String get shareExplain =>
      'Give this code to the people you want to share with. It works for 7 days. They can add and edit records and everything stays in sync. Everyone signs in with Google.';

  @override
  String get copyCode => 'Copy code';

  @override
  String get codeCopied => 'Code copied.';

  @override
  String get joinWithCode => 'Join with a code';

  @override
  String get codeLabel => 'Invitation code';

  @override
  String get join => 'Join';

  @override
  String get joinFailed => 'Invalid or expired code.';

  @override
  String get syncFailed => 'Could not reach the server. Check your connection.';

  @override
  String get noRecords => 'No record yet.';

  @override
  String dueOn(String date) {
    return 'Due $date';
  }
}
