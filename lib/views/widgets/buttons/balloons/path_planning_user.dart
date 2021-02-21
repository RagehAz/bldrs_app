import 'package:flutter/material.dart';

// --- previously Owner
class PlanningUserBalloon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 50;
    final double _yScaling = size.height / 50;
    path.lineTo(2.85 * _xScaling, 47.85 * _yScaling);
    path.cubicTo(
      7.85 * _xScaling,
      45.6 * _yScaling,
      13.49 * _xScaling,
      45.24 * _yScaling,
      18.73 * _xScaling,
      46.85 * _yScaling,
    );
    path.cubicTo(
      35.29 * _xScaling,
      51.95 * _yScaling,
      51.16 * _xScaling,
      37.2 * _yScaling,
      47.29 * _xScaling,
      20.31 * _yScaling,
    );
    path.cubicTo(
      43.42 * _xScaling,
      3.42 * _yScaling,
      22.72 * _xScaling,
      -2.95 * _yScaling,
      10.03 * _xScaling,
      8.85 * _yScaling,
    );
    path.cubicTo(
      2.41 * _xScaling,
      15.93 * _yScaling,
      0.63 * _xScaling,
      27.31 * _yScaling,
      5.73 * _xScaling,
      36.37 * _yScaling,
    );
    path.cubicTo(
      7.98 * _xScaling,
      40.35 * _yScaling,
      6.71 * _xScaling,
      45.4 * _yScaling,
      2.85 * _xScaling,
      47.85 * _yScaling,
    );
    path.cubicTo(
      2.85 * _xScaling,
      47.85 * _yScaling,
      2.85 * _xScaling,
      47.85 * _yScaling,
      2.85 * _xScaling,
      47.85 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
