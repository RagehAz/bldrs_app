import 'package:flutter/material.dart';

class PathOfZeroCorneredBalloon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double _x = size.width / 50;
    final double _y = size.height / 50;
    path.lineTo(0 * _x,25 * _y);
    path.cubicTo(2.37e-15 * _x,5.76 * _y,20.834 * _x,-6.27 * _y,37.5 * _x,3.35 * _y,);
    path.cubicTo(54.17 * _x,12.97 * _y,54.17 * _x,37.03 * _y,37.5 * _x,46.65 * _y,);
    path.cubicTo(33.7 * _x,48.85 * _y,29.39 * _x,50 * _y,25 * _x,50 * _y,);
    path.cubicTo(25 * _x,50 * _y,0 * _x,50 * _y,0 * _x,50 * _y,);
    path.cubicTo(0 * _x,50 * _y,0 * _x,25 * _y,0 * _x,25 * _y,);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
