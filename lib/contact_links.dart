import 'package:url_launcher/url_launcher.dart';

/// `tel:` link for a phone number typed by a person (or received from a shared
/// pet): only digits and a leading + survive, so nothing else can be injected.
Uri? phoneUri(String? raw) {
  if (raw == null) return null;
  final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
  if (!RegExp(r'^\+?[0-9]{3,}$').hasMatch(digits)) return null;
  return Uri(scheme: 'tel', path: digits);
}

/// Web link for a booking page. "example.com" becomes https://example.com;
/// anything that is not http(s) is refused (no file:, intent:, javascript: ...).
Uri? webUri(String? raw) {
  final text = raw?.trim();
  if (text == null || text.isEmpty) return null;
  final withScheme = RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*:').hasMatch(text) ? text : 'https://$text';
  final uri = Uri.tryParse(withScheme);
  if (uri == null || !(uri.scheme == 'http' || uri.scheme == 'https') || uri.host.isEmpty) return null;
  return uri;
}

Future<void> openUri(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);
