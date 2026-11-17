# PetTime

Carnet de santé pour animaux (chiens, chats, lapins...) par TomLine prod&co : fiche de l'animal, vaccins et soins, poids, rendez-vous, rappels, export PDF, partage d'un animal avec d'autres personnes et synchronisation entre téléphones. Les photos restent sur l'appareil.

Langues : français, anglais, allemand, espagnol, italien, portugais.

## Installation

### Android (Google Play)

L'application est en **test fermé** (Alpha) sur Google Play. Pour l'installer :

1. Demander à être ajouté à la liste des testeurs en écrivant à `dev.tlpc@gmail.com` avec l'adresse Gmail utilisée sur le téléphone.
2. Ouvrir <https://play.google.com/apps/testing/com.tomline.pettime> depuis ce compte et accepter de devenir testeur.
3. Installer PetTime depuis le Play Store (lien proposé sur cette page). Les mises à jour arrivent ensuite automatiquement.

« Retirer les pubs » est un achat unique intégré à l'application.

### Autres plateformes

Pas de version publiée pour iOS ni pour Windows pour l'instant ; les dossiers `ios/` et `windows/` servent au développement.

## Compiler depuis les sources

Prérequis : Flutter stable (Dart ^3.13) et le SDK Android.

```bash
flutter pub get
flutter run
```

La synchronisation, la connexion Google et les publicités utilisent Firebase et AdMob. Pour les activer dans un build local, ajouter son propre `android/app/google-services.json` (ignoré par git). Sans ce fichier, le build Android échoue ; les builds de debug utilisent les annonces de test de Google.

Vérifications : `flutter analyze` et `flutter test`.

## Publication

- **CI** (`.github/workflows/ci.yml`) : analyse, tests et APK de debug à chaque push.
- **Release** (`.github/workflows/release-aab.yml`, déclenchement manuel) : construit l'AAB signé (`pettime-release-aab/app-release.aab`) à déposer dans la Play Console. La version se règle dans `pubspec.yaml` (`version: x.y.z+code`) ; le code de build doit augmenter à chaque envoi.

## Liens

- [Politique de confidentialité](docs/privacy-policy.html)
- [Suppression du compte et des données](docs/delete-account.html)
