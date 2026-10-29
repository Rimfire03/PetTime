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
  String get operation => 'Operation';

  @override
  String get services => 'Services';

  @override
  String get addService => 'Add a service';

  @override
  String get serviceKind => 'Type';

  @override
  String get groomer => 'Groomer';

  @override
  String get petSitter => 'Pet sitter';

  @override
  String get boarding => 'Boarding';

  @override
  String get address => 'Address';

  @override
  String get phone => 'Phone';

  @override
  String get bookingLink => 'Booking link or website';

  @override
  String get noServices => 'No service yet.';

  @override
  String get call => 'Call';

  @override
  String get openLink => 'Open link';

  @override
  String removeAds(String price) {
    return 'Remove ads ($price)';
  }

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get rabbit => 'Rabbit';

  @override
  String get welcome => 'Welcome to PetTime';

  @override
  String get signInExplain =>
      'Sign in with Google to keep your pets safe in your account. Your pets follow you on every phone, and you can share a pet with your family.';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm =>
      'Log out and remove this account\'s data from this phone? It stays safe in the cloud and comes back when you sign in again. Photos are not saved in the cloud and will be removed.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n changes have not been sent to the cloud yet and will be lost.',
      one: '1 change has not been sent to the cloud yet and will be lost.',
    );
    return '$_temp0';
  }

  @override
  String get recordType => 'Type of care';

  @override
  String repeatEvery(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'every $n months',
      one: 'every month',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote => 'Suggested date: check it with your vet.';

  @override
  String get weighedOn => 'Weighed on';

  @override
  String get saveAndAddAnother => 'Save and add another';

  @override
  String savedLine(String text) {
    return 'Saved: $text';
  }

  @override
  String get addToCalendar => 'Add to Google Calendar';

  @override
  String get appointmentSaved => 'Appointment saved.';

  @override
  String get wizardNameQ => 'What is your pet\'s name?';

  @override
  String wizardSpeciesQ(String name) {
    return 'What kind of animal is $name?';
  }

  @override
  String wizardSexQ(String name) {
    return 'Is $name a male or a female?';
  }

  @override
  String wizardBreedQ(String name) {
    return 'What breed is $name?';
  }

  @override
  String wizardBirthQ(String name) {
    return 'When was $name born?';
  }

  @override
  String wizardColorQ(String name) {
    return 'What colour is $name\'s coat?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Add a photo of $name';
  }

  @override
  String wizardChipQ(String name) {
    return 'What is $name\'s microchip or tattoo number?';
  }

  @override
  String wizardWeightQ(String name) {
    return 'How much does $name weigh?';
  }

  @override
  String wizardVetQ(String name) {
    return 'Who is $name\'s vet?';
  }

  @override
  String get wizardVetPhoneQ => 'What is the vet\'s phone number?';

  @override
  String wizardVaccineQ(String name) {
    return 'Has $name had a vaccine recently?';
  }

  @override
  String wizardNotesQ(String name) {
    return 'Anything to remember about $name?';
  }

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get finish => 'Finish';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get unknown => 'Unknown';

  @override
  String get sex => 'Sex';

  @override
  String get color => 'Colour';

  @override
  String get chooseDate => 'Choose a date';

  @override
  String get addPhoto => 'Add a photo';

  @override
  String get noRecords => 'No record yet.';

  @override
  String dueOn(String date) {
    return 'Due $date';
  }

  @override
  String deletePetTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deletePetLocal =>
      'This pet\'s health book will be deleted for good.';

  @override
  String get deletePetOwner =>
      'This pet is shared: it will be deleted for everyone who has access.';

  @override
  String get deletePetMember =>
      'This pet is shared with you: it will be removed from your account, the others keep it.';

  @override
  String get deletePetAction => 'Delete this pet';

  @override
  String get sharesTitle => 'Sharing';

  @override
  String get sharesMembers => 'People with access';

  @override
  String get sharesOwnerTag => 'Owner';

  @override
  String get sharesYouTag => 'You';

  @override
  String get sharesUnknown => 'Member';

  @override
  String get sharesRevoke => 'Revoke';

  @override
  String sharesRevokeConfirm(String name) {
    return 'Remove $name\'s access? This person will no longer see this pet. Also revoke any invitation code that is still active.';
  }

  @override
  String get sharesInvites => 'Active invitation codes';

  @override
  String sharesInviteExpires(String date) {
    return 'Expires $date';
  }

  @override
  String get sharesNoInvites => 'No active code.';

  @override
  String get sharesNewCode => 'Create an invitation code';

  @override
  String get sharesOffline =>
      'This pet is not synced yet. Try again once online.';

  @override
  String get scanBarcode => 'Scan the barcode';

  @override
  String get scanHint => 'Point the camera at the microchip barcode.';

  @override
  String get cameraUnavailable =>
      'Camera unavailable. Allow camera access in the phone settings.';

  @override
  String get sharesTransfer => 'Transfer ownership';

  @override
  String get sharesTransferDo => 'Transfer';

  @override
  String sharesTransferConfirm(String name) {
    return '$name will become the owner of this pet: only the owner can delete it for everyone, remove access and create invitation codes.';
  }

  @override
  String get sharesTransferLeave =>
      'Remove this pet from my account after the transfer';

  @override
  String get sharesTransferHelp =>
      'To hand this pet over: share it with the person (invitation code), then choose \"Transfer ownership\" on their name.';

  @override
  String get deleteOnlyOwner => 'Only the owner of the pet can delete it.';
}
