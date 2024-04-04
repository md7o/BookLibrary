import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double animationValue;

  MyPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint1 = Paint()
      ..color = Color(0xFFFF4F49)
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    Paint circlePaint2 = Paint()
      ..color = Color.fromARGB(255, 71, 244, 253)
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    // Draw a square
    double circleRadius =
        size.width * 0.7 + (size.width * 0.2) * animationValue;

    canvas.drawCircle(
        Offset(size.width * 1.4, size.height * -0.5 * animationValue),
        circleRadius,
        circlePaint1);

    double circleRadius2 =
        size.width * 0.9 + (size.width * 0.4) * animationValue;
    // double circleX1 = size.width -
    //     circleRadius * 2 -
    //     (size.width - circleRadius * 1.5) * animationValue;
    canvas.drawCircle(Offset(size.width * -0.3, size.height * 2), circleRadius2,
        circlePaint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
