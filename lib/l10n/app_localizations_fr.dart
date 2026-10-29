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
  String get exportPdf => 'Exporter en PDF';

  @override
  String get backupExport => 'Exporter une sauvegarde';

  @override
  String get backupImport => 'Importer une sauvegarde';

  @override
  String get backupSaved => 'Sauvegarde enregistrée.';

  @override
  String get backupRestored => 'Sauvegarde restaurée.';

  @override
  String get backupInvalid =>
      'Ce fichier n\'est pas une sauvegarde PetTime valide.';

  @override
  String get restoreConfirm =>
      'Cela remplace TOUTES les données actuelles par la sauvegarde. Continuer ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get privacySettings => 'Confidentialité et publicités';

  @override
  String get sharePet => 'Partager cet animal';

  @override
  String get shareExplain =>
      'Donne ce code aux personnes avec qui partager. Il est valable 7 jours. Elles peuvent ajouter et modifier les soins, et tout reste synchronisé. Chacun se connecte avec Google.';

  @override
  String get copyCode => 'Copier le code';

  @override
  String get codeCopied => 'Code copié.';

  @override
  String get joinWithCode => 'Rejoindre avec un code';

  @override
  String get codeLabel => 'Code d\'invitation';

  @override
  String get join => 'Rejoindre';

  @override
  String get joinFailed => 'Code invalide ou expiré.';

  @override
  String get syncFailed => 'Serveur injoignable. Vérifie ta connexion.';

  @override
  String get operation => 'Opération';

  @override
  String get services => 'Services';

  @override
  String get addService => 'Ajouter un service';

  @override
  String get serviceKind => 'Type';

  @override
  String get groomer => 'Toiletteur';

  @override
  String get petSitter => 'Pet sitter';

  @override
  String get boarding => 'Pension';

  @override
  String get address => 'Adresse';

  @override
  String get phone => 'Téléphone';

  @override
  String get bookingLink => 'Lien de réservation ou site web';

  @override
  String get noServices => 'Aucun service enregistré.';

  @override
  String get call => 'Appeler';

  @override
  String get openLink => 'Ouvrir le lien';

  @override
  String removeAds(String price) {
    return 'Retirer les pubs ($price)';
  }

  @override
  String get restorePurchases => 'Restaurer mes achats';

  @override
  String get rabbit => 'Lapin';

  @override
  String get welcome => 'Bienvenue dans PetTime';

  @override
  String get signInExplain =>
      'Connecte-toi avec Google pour garder tes animaux en sécurité dans ton compte. Tes animaux te suivent sur chaque téléphone, et tu peux partager un animal avec ta famille.';

  @override
  String get signInWithGoogle => 'Continuer avec Google';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get logoutConfirm =>
      'Te déconnecter et supprimer les données de ce compte sur ce téléphone ? Elles restent en sécurité dans le cloud et reviennent quand tu te reconnectes. Les photos ne sont pas enregistrées dans le cloud et seront supprimées.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n modifications n\'ont pas encore été envoyées au cloud et seront perdues.',
      one:
          '1 modification n\'a pas encore été envoyée au cloud et sera perdue.',
    );
    return '$_temp0';
  }

  @override
  String get recordType => 'Type de soin';

  @override
  String repeatEvery(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'tous les $n mois',
      one: 'tous les mois',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote =>
      'Date suggérée : confirme-la avec ton vétérinaire.';

  @override
  String get weighedOn => 'Pesé le';

  @override
  String get saveAndAddAnother => 'Enregistrer et ajouter une autre';

  @override
  String savedLine(String text) {
    return 'Enregistré : $text';
  }

  @override
  String get addToCalendar => 'Ajouter à Google Agenda';

  @override
  String get appointmentSaved => 'Rendez-vous enregistré.';

  @override
  String get wizardNameQ => 'Comment s\'appelle ton animal ?';

  @override
  String wizardSpeciesQ(String name) {
    return 'Quel type d\'animal est $name ?';
  }

  @override
  String wizardSexQ(String name) {
    return '$name est-il un mâle ou une femelle ?';
  }

  @override
  String wizardBreedQ(String name) {
    return 'De quelle race est $name ?';
  }

  @override
  String wizardBirthQ(String name) {
    return 'Quand $name est-il né ?';
  }

  @override
  String wizardColorQ(String name) {
    return 'De quelle couleur est le pelage de $name ?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Ajoute une photo de $name';
  }

  @override
  String wizardChipQ(String name) {
    return 'Quel est le numéro de puce ou de tatouage de $name ?';
  }

  @override
  String wizardWeightQ(String name) {
    return 'Combien pèse $name ?';
  }

  @override
  String wizardVetQ(String name) {
    return 'Qui est le vétérinaire de $name ?';
  }

  @override
  String get wizardVetPhoneQ =>
      'Quel est le numéro de téléphone du vétérinaire ?';

  @override
  String wizardVaccineQ(String name) {
    return '$name a-t-il eu un vaccin récemment ?';
  }

  @override
  String wizardNotesQ(String name) {
    return 'Quelque chose à retenir sur $name ?';
  }

  @override
  String get next => 'Suivant';

  @override
  String get skip => 'Passer';

  @override
  String get finish => 'Terminer';

  @override
  String get male => 'Mâle';

  @override
  String get female => 'Femelle';

  @override
  String get unknown => 'Inconnu';

  @override
  String get sex => 'Sexe';

  @override
  String get color => 'Couleur';

  @override
  String get chooseDate => 'Choisir une date';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get noRecords => 'Aucun soin enregistré.';

  @override
  String dueOn(String date) {
    return 'Échéance $date';
  }

  @override
  String deletePetTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deletePetLocal =>
      'Le carnet de santé de cet animal sera supprimé définitivement.';

  @override
  String get deletePetOwner =>
      'Cet animal est partagé : il sera supprimé pour toutes les personnes qui y ont accès.';

  @override
  String get deletePetMember =>
      'Cet animal est partagé avec vous : il sera retiré de votre compte, les autres personnes le conservent.';

  @override
  String get deletePetAction => 'Supprimer cet animal';

  @override
  String get sharesTitle => 'Partages';

  @override
  String get sharesMembers => 'Personnes ayant accès';

  @override
  String get sharesOwnerTag => 'Propriétaire';

  @override
  String get sharesYouTag => 'Vous';

  @override
  String get sharesUnknown => 'Membre';

  @override
  String get sharesRevoke => 'Révoquer';

  @override
  String sharesRevokeConfirm(String name) {
    return 'Retirer l\'accès à $name ? Cette personne ne verra plus cet animal. Pensez aussi à révoquer les codes d\'invitation encore actifs.';
  }

  @override
  String get sharesInvites => 'Codes d\'invitation actifs';

  @override
  String sharesInviteExpires(String date) {
    return 'Expire le $date';
  }

  @override
  String get sharesNoInvites => 'Aucun code actif.';

  @override
  String get sharesNewCode => 'Créer un code d\'invitation';

  @override
  String get sharesOffline =>
      'Cet animal n\'est pas encore synchronisé. Réessayez une fois en ligne.';

  @override
  String get scanBarcode => 'Scanner le code-barres';

  @override
  String get scanHint => 'Placez le code-barres de la puce dans le cadre.';

  @override
  String get cameraUnavailable =>
      'Appareil photo indisponible. Autorisez l\'accès à la caméra dans les réglages du téléphone.';

  @override
  String get sharesTransfer => 'Transférer la propriété';

  @override
  String get sharesTransferDo => 'Transférer';

  @override
  String sharesTransferConfirm(String name) {
    return '$name deviendra propriétaire de cet animal : seul le propriétaire peut le supprimer pour tout le monde, retirer des accès et créer des codes d\'invitation.';
  }

  @override
  String get sharesTransferLeave =>
      'Retirer cet animal de mon compte après le transfert';

  @override
  String get sharesTransferHelp =>
      'Pour céder cet animal : partagez-le avec la personne (code d\'invitation), puis choisissez « Transférer la propriété » sur son nom.';

  @override
  String get deleteOnlyOwner =>
      'Seul le propriétaire de l\'animal peut le supprimer.';

  @override
  String get leaveShare => 'Quitter ce partage';

  @override
  String leaveShareTitle(String name) {
    return 'Quitter le partage de $name ?';
  }

  @override
  String get leaveShareBody =>
      'Cet animal disparaîtra de votre compte. Les autres personnes le conservent, et vous pourrez le retrouver avec un nouveau code d\'invitation.';
}
