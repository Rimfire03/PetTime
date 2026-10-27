// Draws the PetTime icon (heart-shaped paw) into assets/icon/.
// Run: dart run tool/make_icon.dart   then: dart run flutter_launcher_icons
import 'dart:io';

import 'package:image/image.dart' as img;

const _coral = (r: 0xF2, g: 0x78, b: 0x4B);
const _size = 2048; // drawn at 2x, then halved for smooth edges
const _scale = 11.0; // artwork is designed on a 160 grid; paw height 102 * 11 = 1122 of 2048

img.Point _cubic(img.Point a, img.Point b, img.Point c, img.Point d, double t) {
  final u = 1 - t;
  return img.Point(
    u * u * u * a.x + 3 * u * u * t * b.x + 3 * u * t * t * c.x + t * t * t * d.x,
    u * u * u * a.y + 3 * u * u * t * b.y + 3 * u * t * t * c.y + t * t * t * d.y,
  );
}

void _paw(img.Image im) {
  final white = img.ColorRgba8(255, 255, 255, 255);
  // artwork box center is (80, 83); move it to the middle of the canvas
  img.Point p(double x, double y) => img.Point((x - 80) * _scale + _size / 2, (y - 83) * _scale + _size / 2);

  final heart = <img.Point>[];
  for (var i = 0; i <= 80; i++) {
    heart.add(_cubic(p(80, 134), p(34, 104), p(44, 70), p(80, 90), i / 80));
  }
  for (var i = 0; i <= 80; i++) {
    heart.add(_cubic(p(80, 90), p(116, 70), p(126, 104), p(80, 134), i / 80));
  }
  img.fillPolygon(im, vertices: heart, color: white);

  for (final (x, y, r) in [(44.0, 70.0, 11.0), (66.0, 44.0, 12.0), (94.0, 44.0, 12.0), (116.0, 70.0, 11.0)]) {
    final c = p(x, y);
    img.fillCircle(im, x: c.x.round(), y: c.y.round(), radius: (r * _scale).round(), color: white);
  }
}

img.Image _half(img.Image im) => img.copyResize(im, width: 1024, height: 1024, interpolation: img.Interpolation.cubic);

void main() {
  Directory('assets/icon').createSync(recursive: true);

  // full icon: coral square (the OS rounds the corners) with no transparency
  final full = img.Image(width: _size, height: _size, numChannels: 4);
  img.fill(full, color: img.ColorRgba8(_coral.r, _coral.g, _coral.b, 255));
  _paw(full);
  File('assets/icon/icon.png').writeAsBytesSync(img.encodePng(_half(full)));

  // Android adaptive foreground: paw only, transparent, inside the safe zone
  final fg = img.Image(width: _size, height: _size, numChannels: 4);
  _paw(fg);
  File('assets/icon/icon_foreground.png').writeAsBytesSync(img.encodePng(_half(fg)));
  stdout.writeln('icons written');
}
