import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'l10n/app_localizations.dart';

/// Photos are copied here; the DB stores only the file name because the
/// app's documents path can change between iOS updates.
late final Directory _dir;

Future<void> initPhotos() async {
  _dir = Directory('${(await getApplicationDocumentsDirectory()).path}/photos')
    ..createSync(recursive: true);
}

File photoFile(String name) => File('${_dir.path}/$name');

void deletePhoto(String? name) {
  if (name == null) return;
  final f = photoFile(name);
  if (f.existsSync()) f.deleteSync();
}

bool get _hasCamera => Platform.isAndroid || Platform.isIOS;

/// Asks camera or gallery (gallery only on desktop), copies the image into the
/// app folder and returns its file name, or null if the user cancelled.
Future<String?> pickPhoto(BuildContext context) async {
  final t = AppLocalizations.of(context);
  var source = ImageSource.gallery;
  if (_hasCamera) {
    final s = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(t.takePhoto),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(t.chooseFromGallery),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (s == null) return null;
    source = s;
  }
  final x = await ImagePicker().pickImage(source: source, maxWidth: 1024, imageQuality: 80);
  if (x == null) return null;
  final name = '${DateTime.now().microsecondsSinceEpoch}.jpg';
  await File(x.path).copy(photoFile(name).path);
  return name;
}

/// Round photo, or the pet's initial when there is none.
class PetAvatar extends StatelessWidget {
  const PetAvatar({super.key, required this.name, this.photo, this.radius = 20});
  final String name;
  final String? photo;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final file = photo == null ? null : photoFile(photo!);
    final has = file != null && file.existsSync();
    return CircleAvatar(
      radius: radius,
      backgroundImage: has ? FileImage(file) : null,
      child: has ? null : Text(name.characters.first.toUpperCase()),
    );
  }
}
