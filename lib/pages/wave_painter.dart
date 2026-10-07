import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  static const double _w = 375;
  static const double _h = 421;

  // the SVG path, command for command
  Path _path() {
    return Path()
      ..moveTo(-1.77778, 114.632) // M
      ..cubicTo(138.222, 126.632, 225.222, 149.632, 373.222, 41.632) // C
      ..cubicTo(521.222, -66.368, 373.222, 420.632, 373.222, 420.632) // C
      ..lineTo(-1.77778, 420.632) // H
      ..cubicTo(-1.77778, 420.632, -141.778, 102.632, -1.77778, 114.632) // C
      ..close(); // Z
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / _w, size.height / _h);

    final path = _path();

    // 1. shadow (filter: dy 4, blur 15, 25% black)
    canvas.drawPath(
      path.shift(const Offset(0, 4)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );

    // 2. gradient fill (same x1 y1 x2 y2 as the SVG)
    canvas.drawPath(
      path,
      Paint()
        ..shader = ui.Gradient.linear(
          const Offset(605.222, 668.632),
          const Offset(79.2221, -45.3682),
          const [Color(0xFF6A81CA), Color(0xFFA9E0F3)],
        ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => false;
}
