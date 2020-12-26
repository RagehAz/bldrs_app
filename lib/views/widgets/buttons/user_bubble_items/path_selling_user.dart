import 'package:flutter/material.dart';

// ---  tamam
class SellingUserBubble extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 50;
    final double _yScaling = size.height / 50;
    path.lineTo(
        2.85 * _xScaling,
        39.26 * _yScaling
    );
    path.cubicTo(
      2.85 * _xScaling,
      39.26 * _yScaling,
      2.85 * _xScaling,
      25.35 * _yScaling,
      2.85 * _xScaling,
      25.35 * _yScaling,
    );
    path.cubicTo(
      2.85 * _xScaling,
      8.03 * _yScaling,
      21.60* _xScaling,
      -2.79 * _yScaling,
      36.60 * _xScaling,
      5.87 * _yScaling,
    );
    path.cubicTo(
      51.6 * _xScaling,
      14.59 * _yScaling,
      51.6 * _xScaling,
      36.18 * _yScaling,
      36.61 * _xScaling,
      44.84 * _yScaling,
    );
    path.cubicTo(
      33.18 * _xScaling,
      46.81 * _yScaling,
      29.30 * _xScaling,
      47.85 * _yScaling,
      25.35 * _xScaling,
      47.85 * _yScaling,
    );
    path.cubicTo(
      25.35 * _xScaling,
      47.85 * _yScaling,
      11.45 * _xScaling,
      47.85 * _yScaling,
      11.45 * _xScaling,
      47.85 * _yScaling,
    );
    path.cubicTo(
      6.71 * _xScaling,
      47.86 * _yScaling,
      2.85 * _xScaling,
      44.01 * _yScaling,
      2.85 * _xScaling,
      39.26 * _yScaling,
    );
    path.cubicTo(
      2.85 * _xScaling,
      39.26 * _yScaling,
      2.85 * _xScaling,
      39.26 * _yScaling,
      2.85 * _xScaling,
      39.26 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
