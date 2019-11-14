import 'package:flutter/material.dart';
import 'dart:math';

import '../../common/colors.dart';

class CircularAnimationPainter extends CustomPainter {
  double fraction;
  Size screenSize;

  CircularAnimationPainter(this.fraction, this.screenSize);

  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = buttonBgColor;
    var finalRadius = sqrt(pow(screenSize.width, 2) +
        pow(screenSize.height, 2));
    print(finalRadius);
    var radius = finalRadius * fraction;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
