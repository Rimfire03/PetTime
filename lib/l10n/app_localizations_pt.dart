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
  String get weight => 'Peso';

  @override
  String get addWeight => 'Adicionar peso';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get noWeights => 'Sem pesos.';

  @override
  String get appointments => 'Consultas';

  @override
  String get addAppointment => 'Adicionar consulta';

  @override
  String get appointmentTitle => 'Motivo';

  @override
  String get place => 'Local';

  @override
  String get time => 'Hora';

  @override
  String get noAppointments => 'Sem consultas.';

  @override
  String get takePhoto => 'Tirar uma foto';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get removePhoto => 'Remover foto';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get backupExport => 'Exportar cópia de segurança';

  @override
  String get backupImport => 'Importar cópia de segurança';

  @override
  String get backupSaved => 'Cópia guardada.';

  @override
  String get backupRestored => 'Cópia restaurada.';

  @override
  String get backupInvalid => 'Este ficheiro não é uma cópia PetTime válida.';

  @override
  String get restoreConfirm =>
      'Isto substitui TODOS os dados atuais pela cópia. Continuar?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get privacySettings => 'Privacidade e anúncios';

  @override
  String get sharePet => 'Partilhar este animal';

  @override
  String get shareExplain =>
      'Dá este código às pessoas com quem queres partilhar. Vale 7 dias. Podem adicionar e editar registos e tudo fica sincronizado. Todos iniciam sessão com Google.';

  @override
  String get copyCode => 'Copiar código';

  @override
  String get codeCopied => 'Código copiado.';

  @override
  String get joinWithCode => 'Juntar-se com um código';

  @override
  String get codeLabel => 'Código de convite';

  @override
  String get join => 'Juntar-se';

  @override
  String get joinFailed => 'Código inválido ou expirado.';

  @override
  String get syncFailed =>
      'Não foi possível contactar o servidor. Verifica a ligação.';

  @override
  String get operation => 'Operação';

  @override
  String get services => 'Serviços';

  @override
  String get addService => 'Adicionar um serviço';

  @override
  String get serviceKind => 'Tipo';

  @override
  String get groomer => 'Tosquiador';

  @override
  String get petSitter => 'Pet sitter';

  @override
  String get boarding => 'Hotel para animais';

  @override
  String get address => 'Morada';

  @override
  String get phone => 'Telefone';

  @override
  String get bookingLink => 'Ligação de reserva ou site';

  @override
  String get noServices => 'Sem serviços.';

  @override
  String get call => 'Ligar';

  @override
  String get openLink => 'Abrir ligação';

  @override
  String removeAds(String price) {
    return 'Remover anúncios ($price)';
  }

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get noRecords => 'Sem registos.';

  @override
  String dueOn(String date) {
    return 'Vence em $date';
  }
}
