import 'package:flutter/material.dart';

// --- Previously Normal
class PathOfThinkingBalloon extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final Path path1 = Path();
    final double _x = size.width / 50;
    final double _y = size.height / 50;
    path1.lineTo(50 * _x,25 * _y);
    path1.cubicTo(50 * _x,44.25 * _y,29.17 * _x,56.27 * _y,12.5 * _x,46.65 * _y,);
    path1.cubicTo(-4.17 * _x,37.03 * _y,-4.17 * _x,12.97 * _y,12.5 * _x,3.35 * _y,);
    path1.cubicTo(16.3 * _x,1.16 * _y,20.61 * _x,8e-16 * _y,25 * _x,0 * _y,);
    path1.cubicTo(38.81 * _x,8.45e-16 * _y,50 * _x,11.191 * _y,50 * _x,25 * _y,);
    path1.cubicTo(50 * _x,25 * _y,50 * _x,25 * _y,50 * _x,25 * _y,);

    final Path path2 = Path();
    path2.lineTo(3.7 * _x,42.7 * _y);
    path2.cubicTo(1.7 * _x,42.7 * _y,0 * _x,44.3 * _y,0 * _x,46.3 * _y,);
    path2.cubicTo(0 * _x,48.3 * _y,1.6 * _x,50 * _y,3.6 * _x,50 * _y,);
    path2.cubicTo(5.6 * _x,50 * _y,7.3 * _x,48.4 * _y,7.3 * _x,46.4 * _y,);
    path2.cubicTo(7.3 * _x,46.4 * _y,7.3 * _x,46.4 * _y,7.3 * _x,46.4 * _y,);
    path2.cubicTo(7.3 * _x,44.3 * _y,5.7 * _x,42.7 * _y,3.7 * _x,42.7 * _y,);
    path2.cubicTo(3.7 * _x,42.7 * _y,3.7 * _x,42.7 * _y,3.7 * _x,42.7 * _y,);

    return Path.combine(PathOperation.union, path1, path2);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
