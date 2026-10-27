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
  String get noRecords => 'No record yet.';

  @override
  String dueOn(String date) {
    return 'Due $date';
  }
}
