import 'package:flutter/material.dart';

class PathOfArrowedBalloon extends CustomClipper<Path> {
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
    path2.lineTo(7.8 * _x,47.91 * _y);
    path2.cubicTo(5.1 * _x,48.18 * _y,2.47 * _x,48.89 * _y,0 * _x,50 * _y,);
    path2.cubicTo(0 * _x,50 * _y,11 * _x,50 * _y,11 * _x,50 * _y,);
    path2.cubicTo(9.89 * _x,49.38 * _y,8.82 * _x,48.68 * _y,7.8 * _x,47.91 * _y,);
    path2.cubicTo(7.8 * _x,47.91 * _y,7.8 * _x,47.91 * _y,7.8 * _x,47.91 * _y,);

    final Path path3 = Path();
    path3.lineTo(4.07 * _x,44.56 * _y);
    path3.cubicTo(2.5 * _x,42.88 * _y,1.13 * _x,41.01 * _y,0 * _x,39 * _y,);
    path3.cubicTo(0 * _x,39 * _y,0 * _x,50 * _y,0 * _x,50 * _y,);
    path3.cubicTo(1.98 * _x,48.75 * _y,3.43 * _x,46.8 * _y,4.07 * _x,44.56 * _y,);
    path3.cubicTo(4.07 * _x,44.56 * _y,4.07 * _x,44.56 * _y,4.07 * _x,44.56 * _y,);

    return Path.combine(PathOperation.union,Path.combine(PathOperation.union, path1, path2,),path3);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
