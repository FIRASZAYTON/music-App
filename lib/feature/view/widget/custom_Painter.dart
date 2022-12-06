import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final BuildContext conttext;

  ArcPainter(this.conttext);
  @override
  void paint(Canvas canvas, Size size) {
    var screenSize = MediaQuery.of(conttext).size;
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, screenSize.height / 1.6)
      ..quadraticBezierTo(screenSize.width / 2, screenSize.height / 1.2,
          screenSize.width, screenSize.height / 1.6)
      ..lineTo(screenSize.width, screenSize.height)
      ..lineTo(screenSize.width, 0)
      ..close();
    canvas.drawPath(orangeArc, Paint()..color = Colors.red);
    Path whiteArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, screenSize.height / 1.7)
      ..quadraticBezierTo(screenSize.width / 2, screenSize.height / 1.3,
          screenSize.width, screenSize.height / 1.7)
      ..lineTo(screenSize.width, screenSize.height)
      ..lineTo(screenSize.width, 0)
      ..close();
    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
