import 'data/db.dart';

/// Link that opens Google Calendar (the app if installed, else the browser) on a new event already filled
/// in. Nothing is sent anywhere until the person confirms in Google Calendar, and no permission
/// or Google account access is needed by PetTime.
Uri googleCalendarUri({
  required String title,
  required DateTime start,
  Duration length = const Duration(hours: 1),
  String? place,
  String? details,
}) {
  String stamp(DateTime d) {
    final u = d.toUtc();
    String p(int n, [int w = 2]) => n.toString().padLeft(w, '0');
    return '${p(u.year, 4)}${p(u.month)}${p(u.day)}T${p(u.hour)}${p(u.minute)}${p(u.second)}Z';
  }

  return Uri.https('calendar.google.com', '/calendar/render', {
    'action': 'TEMPLATE',
    'text': title,
    'dates': '${stamp(start)}/${stamp(start.add(length))}',
    if (place != null && place.isNotEmpty) 'location': place,
    if (details != null && details.isNotEmpty) 'details': details,
  });
}

/// The calendar link of a saved appointment, titled with the pet's name.
Future<Uri> appointmentCalendarUri(Appointment a) async {
  final pet = await (db.select(db.pets)..where((p) => p.id.equals(a.petId))).getSingleOrNull();
  return googleCalendarUri(
    title: pet == null ? a.title : '${pet.name} - ${a.title}',
    start: a.at,
    place: a.place,
    details: 'PetTime',
  );
}
