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
  String get noRecords => 'Sin registros.';

  @override
  String dueOn(String date) {
    return 'Vence $date';
  }
}
