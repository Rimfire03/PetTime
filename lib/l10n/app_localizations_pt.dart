// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'Meus animais';

  @override
  String get noPets => 'Nenhum animal. Toque em + para adicionar.';

  @override
  String get addPet => 'Adicionar animal';

  @override
  String get editPet => 'Editar animal';

  @override
  String get name => 'Nome';

  @override
  String get species => 'Espécie';

  @override
  String get dog => 'Cão';

  @override
  String get cat => 'Gato';

  @override
  String get other => 'Outro';

  @override
  String get breed => 'Raça';

  @override
  String get birthDate => 'Data de nascimento';

  @override
  String get chip => 'Microchip / tatuagem';

  @override
  String get vetName => 'Veterinário';

  @override
  String get vetPhone => 'Telefone do veterinário';

  @override
  String get notes => 'Notas';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get required => 'Obrigatório';

  @override
  String get healthBook => 'Caderneta de saúde';

  @override
  String get info => 'Info';

  @override
  String get vaccine => 'Vacina';

  @override
  String get dewormer => 'Vermífugo';

  @override
  String get flea => 'Antipulgas';

  @override
  String get addRecord => 'Adicionar registo';

  @override
  String get product => 'Produto / vacina';

  @override
  String get date => 'Data';

  @override
  String get nextDue => 'Próximo vencimento';

  @override
  String get remindDaysBefore => 'Lembrar-me (dias antes)';

  @override
  String get reminderChannel => 'Lembretes';

  @override
  String get noRecords => 'Sem registos.';

  @override
  String dueOn(String date) {
    return 'Vence em $date';
  }
}
