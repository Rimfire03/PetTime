import 'dart:math';

import 'package:flutter/material.dart';

/// Draws the app logo (a heart-shaped paw) many times, very pale, behind
/// [child]. Purely decorative: it ignores touches and never changes layout.
class PawBackdrop extends StatelessWidget {
  const PawBackdrop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary.withValues(alpha: 0.07);
    return Stack(children: [
      Positioned.fill(child: IgnorePointer(child: CustomPaint(painter: _PawsPainter(color)))),
      child,
    ]);
  }
}

class _PawsPainter extends CustomPainter {
  const _PawsPainter(this.color);
  final Color color;

  // the logo, drawn on a 160 x 160 grid and centred on (80, 83)
  static final Path _paw = Path()
    ..moveTo(80, 134)
    ..cubicTo(34, 104, 44, 70, 80, 90)
    ..cubicTo(116, 70, 126, 104, 80, 134)
    ..close()
    ..addOval(Rect.fromCircle(center: const Offset(44, 70), radius: 11))
    ..addOval(Rect.fromCircle(center: const Offset(66, 44), radius: 12))
    ..addOval(Rect.fromCircle(center: const Offset(94, 44), radius: 12))
    ..addOval(Rect.fromCircle(center: const Offset(116, 70), radius: 11));

  @override
  void paint(Canvas canvas, Size size) {
    const cell = 110.0;
    const pawSize = 52.0;
    final paint = Paint()..color = color;
    var row = 0;
    for (var y = cell / 2; y < size.height + cell; y += cell, row++) {
      // every other row is shifted, and each paw leans a little, so it never looks like a grid
      for (var x = (row.isOdd ? cell : cell / 2); x < size.width + cell; x += cell * 2) {
        canvas
          ..save()
          ..translate(x, y)
          ..rotate((row.isOdd ? 1 : -1) * 18 * pi / 180)
          ..scale(pawSize / 100)
          ..translate(-80, -83)
          ..drawPath(_paw, paint)
          ..restore();
      }
    }
  }

  @override
  bool shouldRepaint(_PawsPainter old) => old.color != color;
}
