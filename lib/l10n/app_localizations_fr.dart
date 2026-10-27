// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'Mes animaux';

  @override
  String get noPets => 'Aucun animal. Appuyez sur + pour en ajouter.';

  @override
  String get addPet => 'Ajouter un animal';

  @override
  String get editPet => 'Modifier l\'animal';

  @override
  String get name => 'Nom';

  @override
  String get species => 'Espèce';

  @override
  String get dog => 'Chien';

  @override
  String get cat => 'Chat';

  @override
  String get other => 'Autre';

  @override
  String get breed => 'Race';

  @override
  String get birthDate => 'Date de naissance';

  @override
  String get chip => 'Puce / tatouage';

  @override
  String get vetName => 'Vétérinaire';

  @override
  String get vetPhone => 'Téléphone du vétérinaire';

  @override
  String get notes => 'Notes';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get required => 'Obligatoire';

  @override
  String get healthBook => 'Carnet de santé';

  @override
  String get info => 'Infos';

  @override
  String get vaccine => 'Vaccin';

  @override
  String get dewormer => 'Vermifuge';

  @override
  String get flea => 'Antipuce';

  @override
  String get addRecord => 'Ajouter un soin';

  @override
  String get product => 'Produit / vaccin';

  @override
  String get date => 'Date';

  @override
  String get nextDue => 'Prochaine échéance';

  @override
  String get remindDaysBefore => 'Me rappeler (jours avant)';

  @override
  String get reminderChannel => 'Rappels';

  @override
  String get weight => 'Poids';

  @override
  String get addWeight => 'Ajouter un poids';

  @override
  String get weightKg => 'Poids (kg)';

  @override
  String get noWeights => 'Aucun poids enregistré.';

  @override
  String get appointments => 'Rendez-vous';

  @override
  String get addAppointment => 'Ajouter un rendez-vous';

  @override
  String get appointmentTitle => 'Motif';

  @override
  String get place => 'Lieu';

  @override
  String get time => 'Heure';

  @override
  String get noAppointments => 'Aucun rendez-vous.';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get noRecords => 'Aucun soin enregistré.';

  @override
  String dueOn(String date) {
    return 'Échéance $date';
  }
}
