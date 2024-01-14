import 'package:flutter/material.dart';

class PathOfSpeakingBalloon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double _x = size.width / 50;
    final double _y = size.height / 50;
    path.lineTo(0 * _x,50 * _y);
    path.cubicTo(5.55 * _x,47.5 * _y,11.82 * _x,47.11 * _y,17.64 * _x,48.9 * _y,);
    path.cubicTo(36.03 * _x,54.57 * _y,53.67 * _x,38.21 * _y,49.38 * _x,19.48 * _y,);
    path.cubicTo(45.10 * _x,0.69 * _y,22.11 * _x,-6.41 * _y,8.05 * _x,6.68 * _y,);
    path.cubicTo(-0.46 * _x,14.54 * _y,-2.45 * _x,27.18 * _y,3.21 * _x,37.25 * _y,);
    path.cubicTo(5.75 * _x,41.68 * _y,4.3 * _x,47.28 * _y,0 * _x,50 * _y,);
    path.cubicTo(0 * _x,50 * _y,0 * _x,50 * _y,0 * _x,50 * _y,);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
