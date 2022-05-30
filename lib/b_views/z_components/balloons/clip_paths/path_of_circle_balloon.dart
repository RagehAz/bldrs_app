import 'package:flutter/material.dart';

class PathOfCircleBalloon extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double _x = size.width / 50;
    final double _y = size.height / 50;
    path.lineTo(50 * _x,25 * _y);
    path.cubicTo(50 * _x,44.25 * _y,29.17 * _x,56.27 * _y,12.5 * _x,46.65 * _y,);
    path.cubicTo(-4.17 * _x,37.03 * _y,-4.17 * _x,12.97 * _y,12.5 * _x,3.35 * _y,);
    path.cubicTo(16.3 * _x,1.16 * _y,20.61 * _x,8e-16 * _y,25 * _x,0 * _y,);
    path.cubicTo(38.81 * _x,8.45e-16 * _y,50 * _x,11.191 * _y,50 * _x,25 * _y,);
    path.cubicTo(50 * _x,25 * _y,50 * _x,25 * _y,50 * _x,25 * _y,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
