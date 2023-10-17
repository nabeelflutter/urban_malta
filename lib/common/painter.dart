import 'package:flutter/material.dart';

class TestBckGround extends StatelessWidget {
  const TestBckGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SignUpPainter(),
    );
  }
}

class SignUpPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint curvePaint = Paint()..color = Colors.blue.shade50;
    var path = Path()
      ..moveTo(size.width, 0)
      ..cubicTo(
        size.width * 0.20,
        size.height * 0.15,
        size.width,
        size.height * 0.20,
        size.width * 0.80,
        size.height * 0.30,
      )
      ..cubicTo(
        size.width * 0.0,
        size.height * 0.50,
        size.width,
        size.height * 0.60,
        size.width * 0.80,
        size.height * 0.70,
      )
      ..cubicTo(
        -size.width * 0.5,
        size.height * 0.90,
        size.width,
        size.height * 0.80,
        size.width * 1,
        size.height * 2,
      );
    // ..lineTo(size.width, size.height);

    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
