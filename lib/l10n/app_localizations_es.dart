// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PetTime';

  @override
  String get myPets => 'Mis mascotas';

  @override
  String get noPets => 'Ninguna mascota. Pulsa + para añadir una.';

  @override
  String get addPet => 'Añadir mascota';

  @override
  String get editPet => 'Editar mascota';

  @override
  String get name => 'Nombre';

  @override
  String get species => 'Especie';

  @override
  String get dog => 'Perro';

  @override
  String get cat => 'Gato';

  @override
  String get other => 'Otro';

  @override
  String get breed => 'Raza';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get chip => 'Microchip / tatuaje';

  @override
  String get vetName => 'Veterinario';

  @override
  String get vetPhone => 'Teléfono del veterinario';

  @override
  String get notes => 'Notas';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get required => 'Obligatorio';

  @override
  String get healthBook => 'Cartilla sanitaria';

  @override
  String get info => 'Info';

  @override
  String get vaccine => 'Vacuna';

  @override
  String get dewormer => 'Desparasitante';

  @override
  String get flea => 'Antipulgas';

  @override
  String get addRecord => 'Añadir registro';

  @override
  String get product => 'Producto / vacuna';

  @override
  String get date => 'Fecha';

  @override
  String get nextDue => 'Próxima fecha';

  @override
  String get remindDaysBefore => 'Recordarme (días antes)';

  @override
  String get reminderChannel => 'Recordatorios';

  @override
  String get weight => 'Peso';

  @override
  String get addWeight => 'Añadir peso';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get noWeights => 'Sin pesos.';

  @override
  String get appointments => 'Citas';

  @override
  String get addAppointment => 'Añadir cita';

  @override
  String get appointmentTitle => 'Motivo';

  @override
  String get place => 'Lugar';

  @override
  String get time => 'Hora';

  @override
  String get noAppointments => 'Sin citas.';

  @override
  String get takePhoto => 'Hacer una foto';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get backupExport => 'Exportar copia de seguridad';

  @override
  String get backupImport => 'Importar copia de seguridad';

  @override
  String get backupSaved => 'Copia guardada.';

  @override
  String get backupRestored => 'Copia restaurada.';

  @override
  String get backupInvalid => 'Este archivo no es una copia de PetTime válida.';

  @override
  String get restoreConfirm =>
      'Esto reemplaza TODOS los datos actuales por la copia. ¿Continuar?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get privacySettings => 'Privacidad y anuncios';

  @override
  String get sharePet => 'Compartir esta mascota';

  @override
  String get shareExplain =>
      'Da este código a quienes quieras compartir. Vale 7 días. Pueden añadir y editar registros y todo se mantiene sincronizado. Todos inician sesión con Google.';

  @override
  String get copyCode => 'Copiar código';

  @override
  String get codeCopied => 'Código copiado.';

  @override
  String get joinWithCode => 'Unirse con un código';

  @override
  String get codeLabel => 'Código de invitación';

  @override
  String get join => 'Unirse';

  @override
  String get joinFailed => 'Código no válido o caducado.';

  @override
  String get syncFailed =>
      'No se pudo conectar con el servidor. Revisa tu conexión.';

  @override
  String get operation => 'Operación';

  @override
  String get services => 'Servicios';

  @override
  String get addService => 'Añadir un servicio';

  @override
  String get serviceKind => 'Tipo';

  @override
  String get groomer => 'Peluquería';

  @override
  String get petSitter => 'Cuidador';

  @override
  String get boarding => 'Residencia';

  @override
  String get address => 'Dirección';

  @override
  String get phone => 'Teléfono';

  @override
  String get bookingLink => 'Enlace de reserva o sitio web';

  @override
  String get noServices => 'Sin servicios.';

  @override
  String get call => 'Llamar';

  @override
  String get openLink => 'Abrir enlace';

  @override
  String removeAds(String price) {
    return 'Quitar anuncios ($price)';
  }

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get rabbit => 'Conejo';

  @override
  String get welcome => 'Bienvenido a PetTime';

  @override
  String get signInExplain =>
      'Inicia sesión con Google para mantener a tus mascotas seguras en tu cuenta. Tus mascotas te siguen en cada teléfono y puedes compartir una mascota con tu familia.';

  @override
  String get signInWithGoogle => 'Continuar con Google';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm =>
      '¿Cerrar sesión y eliminar los datos de esta cuenta de este teléfono? Siguen seguros en la nube y vuelven al iniciar sesión. Las fotos no se guardan en la nube y se eliminarán.';

  @override
  String logoutUnsynced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n cambios aún no se han enviado a la nube y se perderán.',
      one: '1 cambio aún no se ha enviado a la nube y se perderá.',
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
      other: 'cada $n meses',
      one: 'cada mes',
    );
    return '$_temp0';
  }

  @override
  String get suggestionNote => 'Fecha sugerida: confírmala con tu veterinario.';

  @override
  String get weighedOn => 'Pesado el';

  @override
  String get saveAndAddAnother => 'Guardar y añadir otro';

  @override
  String savedLine(String text) {
    return 'Guardado: $text';
  }

  @override
  String get addToCalendar => 'Añadir a Google Calendar';

  @override
  String get appointmentSaved => 'Cita guardada.';

  @override
  String get wizardNameQ => '¿Cómo se llama tu mascota?';

  @override
  String wizardSpeciesQ(String name) {
    return '¿Qué tipo de animal es $name?';
  }

  @override
  String wizardSexQ(String name) {
    return '¿$name es macho o hembra?';
  }

  @override
  String wizardBreedQ(String name) {
    return '¿De qué raza es $name?';
  }

  @override
  String wizardBirthQ(String name) {
    return '¿Cuándo nació $name?';
  }

  @override
  String wizardColorQ(String name) {
    return '¿De qué color es el pelaje de $name?';
  }

  @override
  String wizardPhotoQ(String name) {
    return 'Añade una foto de $name';
  }

  @override
  String wizardChipQ(String name) {
    return '¿Cuál es el número de microchip o tatuaje de $name?';
  }

  @override
  String wizardWeightQ(String name) {
    return '¿Cuánto pesa $name?';
  }

  @override
  String wizardVetQ(String name) {
    return '¿Quién es el veterinario de $name?';
  }

  @override
  String get wizardVetPhoneQ => '¿Cuál es el teléfono del veterinario?';

  @override
  String wizardVaccineQ(String name) {
    return '¿$name se ha vacunado recientemente?';
  }

  @override
  String wizardNotesQ(String name) {
    return '¿Algo que recordar sobre $name?';
  }

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get finish => 'Terminar';

  @override
  String get male => 'Macho';

  @override
  String get female => 'Hembra';

  @override
  String get unknown => 'Desconocido';

  @override
  String get sex => 'Sexo';

  @override
  String get color => 'Color';

  @override
  String get chooseDate => 'Elegir una fecha';

  @override
  String get addPhoto => 'Añadir una foto';

  @override
  String get noRecords => 'Sin registros.';

  @override
  String dueOn(String date) {
    return 'Vence $date';
  }

  @override
  String deletePetTitle(String name) {
    return '¿Eliminar a $name?';
  }

  @override
  String get deletePetLocal =>
      'La cartilla de salud de este animal se eliminará definitivamente.';

  @override
  String get deletePetOwner =>
      'Este animal está compartido: se eliminará para todas las personas con acceso.';

  @override
  String get deletePetMember =>
      'Este animal está compartido contigo: se quitará de tu cuenta, los demás lo conservan.';

  @override
  String get deletePetAction => 'Eliminar este animal';

  @override
  String get sharesTitle => 'Compartidos';

  @override
  String get sharesMembers => 'Personas con acceso';

  @override
  String get sharesOwnerTag => 'Propietario';

  @override
  String get sharesYouTag => 'Tú';

  @override
  String get sharesUnknown => 'Miembro';

  @override
  String get sharesRevoke => 'Revocar';

  @override
  String sharesRevokeConfirm(String name) {
    return '¿Quitar el acceso a $name? Esta persona ya no verá este animal. Revoca también los códigos de invitación que sigan activos.';
  }

  @override
  String get sharesInvites => 'Códigos de invitación activos';

  @override
  String sharesInviteExpires(String date) {
    return 'Caduca el $date';
  }

  @override
  String get sharesNoInvites => 'Ningún código activo.';

  @override
  String get sharesNewCode => 'Crear un código de invitación';

  @override
  String get sharesOffline =>
      'Este animal aún no está sincronizado. Inténtalo de nuevo con conexión.';

  @override
  String get scanBarcode => 'Escanear el código de barras';

  @override
  String get scanHint => 'Apunta la cámara al código de barras del microchip.';

  @override
  String get cameraUnavailable =>
      'Cámara no disponible. Permite el acceso a la cámara en los ajustes del teléfono.';

  @override
  String get sharesTransfer => 'Transferir la propiedad';

  @override
  String get sharesTransferDo => 'Transferir';

  @override
  String sharesTransferConfirm(String name) {
    return '$name será el propietario de este animal: solo el propietario puede eliminarlo para todos, quitar accesos y crear códigos de invitación.';
  }

  @override
  String get sharesTransferLeave =>
      'Quitar este animal de mi cuenta tras la transferencia';

  @override
  String get sharesTransferHelp =>
      'Para ceder este animal: compártelo con la persona (código de invitación) y elige \"Transferir la propiedad\" en su nombre.';

  @override
  String get deleteOnlyOwner =>
      'Solo el propietario del animal puede eliminarlo.';

  @override
  String get leaveShare => 'Salir de este compartido';

  @override
  String leaveShareTitle(String name) {
    return '¿Salir del compartido de $name?';
  }

  @override
  String get leaveShareBody =>
      'Este animal desaparecerá de tu cuenta. Los demás lo conservan y podrás recuperarlo con un nuevo código de invitación.';

  @override
  String get upcomingTitle => 'Próximos vencimientos';

  @override
  String get overdueTitle => 'Vencidos';

  @override
  String overdueSince(String date) {
    return 'Vencido desde el $date';
  }

  @override
  String get noAppointmentPlanned => 'Ninguna cita prevista';
}
