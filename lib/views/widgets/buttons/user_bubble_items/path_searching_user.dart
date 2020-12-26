import 'package:flutter/material.dart';

// --- Previously Normal
class SearchingUserBubble extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path();
    final double _xScaling = size.width / 50;
    final double _yScaling = size.height / 50;
    path1.lineTo(2.85 * _xScaling, 25.35 * _yScaling);
    path1.cubicTo(
      2.85 * _xScaling,
      8.03 * _yScaling,
      21.6 * _xScaling,
      -2.8 * _yScaling,
      36.6 * _xScaling,
      5.86 * _yScaling,
    );
    path1.cubicTo(
      51.6 * _xScaling,
      14.53 * _yScaling,
      51.6 * _xScaling,
      36.18 * _yScaling,
      36.6 * _xScaling,
      44.84 * _yScaling,
    );
    path1.cubicTo(
      33.18 * _xScaling,
      46.81 * _yScaling,
      29.3 * _xScaling,
      47.85 * _yScaling,
      25.35 * _xScaling,
      47.85 * _yScaling,
    );
    path1.cubicTo(
      12.93 * _xScaling,
      47.84 * _yScaling,
      2.86 * _xScaling,
      37.77 * _yScaling,
      2.85 * _xScaling,
      25.35 * _yScaling,
    );
    path1.cubicTo(
      2.85 * _xScaling,
      25.35 * _yScaling,
      2.85 * _xScaling,
      25.35 * _yScaling,
      2.85 * _xScaling,
      25.35 * _yScaling,
    );

    Path path2 = Path();
    path2.lineTo(2.85 * _xScaling, 44.57 * _yScaling);
    path2.cubicTo(
      2.84 * _xScaling,
      42.04 * _yScaling,
      5.58 * _xScaling,
      40.45 * _yScaling,
      7.78 * _xScaling,
      41.71 * _yScaling,
    );
    path2.cubicTo(
      9.97 * _xScaling,
      42.97 * _yScaling,
      9.98 * _xScaling,
      46.13 * _yScaling,
      7.79 * _xScaling,
      47.4 * _yScaling,
    );
    path2.cubicTo(
      7.29 * _xScaling,
      47.7 * _yScaling,
      6.72 * _xScaling,
      47.85 * _yScaling,
      6.14 * _xScaling,
      47.85 * _yScaling,
    );
    path2.cubicTo(
      4.33 * _xScaling,
      47.86 * _yScaling,
      2.85 * _xScaling,
      46.39 * _yScaling,
      2.85 * _xScaling,
      44.57 * _yScaling,
    );
    path2.cubicTo(
      2.85 * _xScaling,
      44.57 * _yScaling,
      2.85 * _xScaling,
      44.57 * _yScaling,
      2.85 * _xScaling,
      44.57 * _yScaling,
    );
    return Path.combine(PathOperation.union, path1, path2);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
