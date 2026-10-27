import 'data/db.dart';
import 'l10n/app_localizations.dart';

// One home for the names shown for the app's fixed choices, so notifications, the PDF and the screens
// share them without importing each other's screens.

String speciesLabel(AppLocalizations t, String species) => switch (species) {
      'dog' => t.dog,
      'cat' => t.cat,
      'rabbit' => t.rabbit,
      _ => t.other,
    };

String recordLabel(AppLocalizations t, RecordType r) => switch (r) {
      RecordType.vaccine => t.vaccine,
      RecordType.dewormer => t.dewormer,
      RecordType.flea => t.flea,
      RecordType.operation => t.operation,
    };

String contactKindLabel(AppLocalizations t, ContactKind k) => switch (k) {
      ContactKind.groomer => t.groomer,
      ContactKind.petSitter => t.petSitter,
      ContactKind.boarding => t.boarding,
      ContactKind.other => t.other,
    };