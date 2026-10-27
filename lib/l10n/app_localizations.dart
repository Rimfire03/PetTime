import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PetTime'**
  String get appTitle;

  /// No description provided for @myPets.
  ///
  /// In en, this message translates to:
  /// **'My pets'**
  String get myPets;

  /// No description provided for @noPets.
  ///
  /// In en, this message translates to:
  /// **'No pet yet. Tap + to add one.'**
  String get noPets;

  /// No description provided for @addPet.
  ///
  /// In en, this message translates to:
  /// **'Add a pet'**
  String get addPet;

  /// No description provided for @editPet.
  ///
  /// In en, this message translates to:
  /// **'Edit pet'**
  String get editPet;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @species.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// No description provided for @dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get dog;

  /// No description provided for @cat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get cat;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @breed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get breed;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @chip.
  ///
  /// In en, this message translates to:
  /// **'Microchip / tattoo'**
  String get chip;

  /// No description provided for @vetName.
  ///
  /// In en, this message translates to:
  /// **'Veterinarian'**
  String get vetName;

  /// No description provided for @vetPhone.
  ///
  /// In en, this message translates to:
  /// **'Vet phone'**
  String get vetPhone;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @healthBook.
  ///
  /// In en, this message translates to:
  /// **'Health book'**
  String get healthBook;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @vaccine.
  ///
  /// In en, this message translates to:
  /// **'Vaccine'**
  String get vaccine;

  /// No description provided for @dewormer.
  ///
  /// In en, this message translates to:
  /// **'Dewormer'**
  String get dewormer;

  /// No description provided for @flea.
  ///
  /// In en, this message translates to:
  /// **'Flea & tick'**
  String get flea;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add a record'**
  String get addRecord;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product / vaccine'**
  String get product;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @nextDue.
  ///
  /// In en, this message translates to:
  /// **'Next due date'**
  String get nextDue;

  /// No description provided for @remindDaysBefore.
  ///
  /// In en, this message translates to:
  /// **'Remind me (days before)'**
  String get remindDaysBefore;

  /// No description provided for @reminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminderChannel;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @addWeight.
  ///
  /// In en, this message translates to:
  /// **'Add weight'**
  String get addWeight;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// No description provided for @noWeights.
  ///
  /// In en, this message translates to:
  /// **'No weight yet.'**
  String get noWeights;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @addAppointment.
  ///
  /// In en, this message translates to:
  /// **'Add appointment'**
  String get addAppointment;

  /// No description provided for @appointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get appointmentTitle;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get place;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointment.'**
  String get noAppointments;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @backupExport.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get backupExport;

  /// No description provided for @backupImport.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get backupImport;

  /// No description provided for @backupSaved.
  ///
  /// In en, this message translates to:
  /// **'Backup saved.'**
  String get backupSaved;

  /// No description provided for @backupRestored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored.'**
  String get backupRestored;

  /// No description provided for @backupInvalid.
  ///
  /// In en, this message translates to:
  /// **'This file is not a valid PetTime backup.'**
  String get backupInvalid;

  /// No description provided for @restoreConfirm.
  ///
  /// In en, this message translates to:
  /// **'This replaces ALL current data with the backup. Continue?'**
  String get restoreConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy & ads settings'**
  String get privacySettings;

  /// No description provided for @sharePet.
  ///
  /// In en, this message translates to:
  /// **'Share this pet'**
  String get sharePet;

  /// No description provided for @shareExplain.
  ///
  /// In en, this message translates to:
  /// **'Give this code to the people you want to share with. It works for 7 days. They can add and edit records and everything stays in sync. Everyone signs in with Google.'**
  String get shareExplain;

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copyCode;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied.'**
  String get codeCopied;

  /// No description provided for @joinWithCode.
  ///
  /// In en, this message translates to:
  /// **'Join with a code'**
  String get joinWithCode;

  /// No description provided for @codeLabel.
  ///
  /// In en, this message translates to:
  /// **'Invitation code'**
  String get codeLabel;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @joinFailed.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired code.'**
  String get joinFailed;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your connection.'**
  String get syncFailed;

  /// No description provided for @operation.
  ///
  /// In en, this message translates to:
  /// **'Operation'**
  String get operation;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @addService.
  ///
  /// In en, this message translates to:
  /// **'Add a service'**
  String get addService;

  /// No description provided for @serviceKind.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get serviceKind;

  /// No description provided for @groomer.
  ///
  /// In en, this message translates to:
  /// **'Groomer'**
  String get groomer;

  /// No description provided for @petSitter.
  ///
  /// In en, this message translates to:
  /// **'Pet sitter'**
  String get petSitter;

  /// No description provided for @boarding.
  ///
  /// In en, this message translates to:
  /// **'Boarding'**
  String get boarding;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @bookingLink.
  ///
  /// In en, this message translates to:
  /// **'Booking link or website'**
  String get bookingLink;

  /// No description provided for @noServices.
  ///
  /// In en, this message translates to:
  /// **'No service yet.'**
  String get noServices;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get openLink;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove ads ({price})'**
  String removeAds(String price);

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @rabbit.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get rabbit;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to PetTime'**
  String get welcome;

  /// No description provided for @signInExplain.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google to keep your pets safe in your account. Your pets follow you on every phone, and you can share a pet with your family.'**
  String get signInExplain;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Log out and remove this account\'s data from this phone? It stays safe in the cloud and comes back when you sign in again. Photos are not saved in the cloud and will be removed.'**
  String get logoutConfirm;

  /// No description provided for @logoutUnsynced.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 change has not been sent to the cloud yet and will be lost.} other{{n} changes have not been sent to the cloud yet and will be lost.}}'**
  String logoutUnsynced(int n);

  /// No description provided for @recordType.
  ///
  /// In en, this message translates to:
  /// **'Type of care'**
  String get recordType;

  /// No description provided for @repeatEvery.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{every month} other{every {n} months}}'**
  String repeatEvery(int n);

  /// No description provided for @suggestionNote.
  ///
  /// In en, this message translates to:
  /// **'Suggested date: check it with your vet.'**
  String get suggestionNote;

  /// No description provided for @weighedOn.
  ///
  /// In en, this message translates to:
  /// **'Weighed on'**
  String get weighedOn;

  /// No description provided for @saveAndAddAnother.
  ///
  /// In en, this message translates to:
  /// **'Save and add another'**
  String get saveAndAddAnother;

  /// No description provided for @savedLine.
  ///
  /// In en, this message translates to:
  /// **'Saved: {text}'**
  String savedLine(String text);

  /// No description provided for @addToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to Google Calendar'**
  String get addToCalendar;

  /// No description provided for @appointmentSaved.
  ///
  /// In en, this message translates to:
  /// **'Appointment saved.'**
  String get appointmentSaved;

  /// No description provided for @noRecords.
  ///
  /// In en, this message translates to:
  /// **'No record yet.'**
  String get noRecords;

  /// No description provided for @dueOn.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueOn(String date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
