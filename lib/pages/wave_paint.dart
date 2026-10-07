import 'dart:math';

import 'package:flutter/material.dart';

class WavePaint extends CustomPainter {
  final Animation<double> animation;
  WavePaint(this.animation) : super(repaint: animation);

  Path _wave(Size size, double phase, double amplitude, double baseY) {
    final path = Path()..moveTo(0, size.height);
    for (double x = 0; x <= size.width; x += 2) {
      final y = baseY + sin((x / size.width * 1 * pi) + phase) * amplitude;

      path.lineTo(x, y);
    }

    path
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value * 2 * pi;
    canvas.drawPath(
      _wave(size, t + pi / 2, 18, size.height * 0.25),
      Paint()..color = const Color(0xFF536DFE).withValues(alpha: 0.4),
    );
    canvas.drawPath(
      _wave(size, t + pi / 4, 30, size.height * 0.25),
      Paint()..color = const Color(0xFF56EFFE).withValues(alpha: 0.4),
    );
    canvas.drawPath(
      _wave(size, t, 24, size.height * 0.3),
      Paint()..color = const Color(0xFF536DFE),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
