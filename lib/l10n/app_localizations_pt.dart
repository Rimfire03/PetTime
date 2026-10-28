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
  String get rabbit => 'Coelho';

  @override
  String get welcome => 'Bem-vindo ao PetTime';

  @override
  String get signInExplain =>
      'Inicia sessão com o Google para manter os teus animais seguros na tua conta. Os teus animais seguem-te em cada telemóvel e podes partilhar um animal com a tua família.';

  @override
  String get signInWithGoogle => 'Continuar com o Google';

  @override
  String get logout => 'Terminar sessão';

  @override
  String get logoutConfirm =>
      'Terminar sessão e remover os dados desta conta deste telemóvel? Continuam seguros na nuvem e voltam quando iniciares sessão. As fotos não são guardadas na nuvem e serão removidas.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n alterações ainda não foram enviadas para a nuvem e serão perdidas.',
      one: '1 alteração ainda não foi enviada para a nuvem e será perdida.',
    );
    return '$_temp0';
  }

  @override
  String get recordType => 'Tipo de cuidado';

  @override
  String repeatEvery(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'a cada $n meses',
      one: 'todos os meses',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote =>
      'Data sugerida: confirma-a com o teu veterinário.';

  @override
  String get weighedOn => 'Pesado em';

  @override
  String get saveAndAddAnother => 'Guardar e adicionar outro';

  @override
  String savedLine(String text) {
    return 'Guardado: $text';
  }

  @override
  String get addToCalendar => 'Adicionar ao Google Agenda';

  @override
  String get appointmentSaved => 'Consulta guardada.';

  @override
  String get wizardNameQ => 'Como se chama o teu animal?';

  @override
  String wizardSpeciesQ(String name) {
    return 'Que tipo de animal é $name?';
  }

  @override
  String wizardSexQ(String name) {
    return '$name é macho ou fêmea?';
  }

  @override
  String wizardBreedQ(String name) {
    return 'Qual é a raça de $name?';
  }

  @override
  String wizardBirthQ(String name) {
    return 'Quando nasceu $name?';
  }

  @override
  String wizardColorQ(String name) {
    return 'Qual é a cor do pelo de $name?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Adiciona uma foto de $name';
  }

  @override
  String wizardChipQ(String name) {
    return 'Qual é o número do microchip ou tatuagem de $name?';
  }

  @override
  String wizardWeightQ(String name) {
    return 'Quanto pesa $name?';
  }

  @override
  String wizardVetQ(String name) {
    return 'Quem é o veterinário de $name?';
  }

  @override
  String get wizardVetPhoneQ => 'Qual é o telefone do veterinário?';

  @override
  String wizardVaccineQ(String name) {
    return '$name foi vacinado recentemente?';
  }

  @override
  String wizardNotesQ(String name) {
    return 'Algo a lembrar sobre $name?';
  }

  @override
  String get next => 'Seguinte';

  @override
  String get skip => 'Saltar';

  @override
  String get finish => 'Concluir';

  @override
  String get male => 'Macho';

  @override
  String get female => 'Fêmea';

  @override
  String get unknown => 'Desconhecido';

  @override
  String get sex => 'Sexo';

  @override
  String get color => 'Cor';

  @override
  String get chooseDate => 'Escolher uma data';

  @override
  String get addPhoto => 'Adicionar uma foto';

  @override
  String get noRecords => 'Sem registos.';

  @override
  String dueOn(String date) {
    return 'Vence em $date';
  }

  @override
  String deletePetTitle(String name) {
    return 'Eliminar $name?';
  }

  @override
  String get deletePetLocal =>
      'O boletim de saúde deste animal será eliminado definitivamente.';

  @override
  String get deletePetOwner =>
      'Este animal está partilhado: será eliminado para todas as pessoas com acesso.';

  @override
  String get deletePetMember =>
      'Este animal está partilhado consigo: será removido da sua conta, as outras pessoas mantêm-no.';

  @override
  String get deletePetAction => 'Eliminar este animal';

  @override
  String get sharesTitle => 'Partilhas';

  @override
  String get sharesMembers => 'Pessoas com acesso';

  @override
  String get sharesOwnerTag => 'Proprietário';

  @override
  String get sharesYouTag => 'Você';

  @override
  String get sharesUnknown => 'Membro';

  @override
  String get sharesRevoke => 'Revogar';

  @override
  String sharesRevokeConfirm(String name) {
    return 'Remover o acesso de $name? Esta pessoa deixará de ver este animal. Revogue também os códigos de convite ainda ativos.';
  }

  @override
  String get sharesInvites => 'Códigos de convite ativos';

  @override
  String sharesInviteExpires(String date) {
    return 'Expira em $date';
  }

  @override
  String get sharesNoInvites => 'Nenhum código ativo.';

  @override
  String get sharesNewCode => 'Criar um código de convite';

  @override
  String get sharesOffline =>
      'Este animal ainda não está sincronizado. Tente novamente quando estiver online.';
}
