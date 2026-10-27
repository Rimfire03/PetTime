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
  String get noRecords => 'Sin registros.';

  @override
  String dueOn(String date) {
    return 'Vence $date';
  }
}
