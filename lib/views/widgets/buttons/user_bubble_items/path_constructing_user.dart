import 'package:flutter/material.dart';

// --- Previously Normal
class ConstructingUserBubble extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path();
    final double _xScaling = size.width / 50;
    final double _yScaling = size.height / 50;
    path1.lineTo(47.9 * _xScaling,25.4 * _yScaling);
    path1.cubicTo(47.9 * _xScaling,37.8 * _yScaling,37.8 * _xScaling,47.9 * _yScaling,25.4 * _xScaling,47.9 * _yScaling,);
    path1.cubicTo(13 * _xScaling,47.9 * _yScaling,2.9 * _xScaling,37.8 * _yScaling,2.9 * _xScaling,25.4 * _yScaling,);
    path1.cubicTo(2.9 * _xScaling,13 * _yScaling,12.9 * _xScaling,2.9 * _yScaling,25.4 * _xScaling,2.9 * _yScaling,);
    path1.cubicTo(37.9 * _xScaling,2.9 * _yScaling,47.9 * _xScaling,12.9 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,);
    path1.cubicTo(47.9 * _xScaling,25.4 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,);

    Path path2 = Path();
    path2.lineTo(9.9 * _xScaling,46 * _yScaling);
    path2.cubicTo(7.5 * _xScaling,46.2 * _yScaling,5.1 * _xScaling,46.9 * _yScaling,2.9 * _xScaling,47.9 * _yScaling,);
    path2.cubicTo(2.9 * _xScaling,47.9 * _yScaling,12.8 * _xScaling,47.9 * _yScaling,12.8 * _xScaling,47.9 * _yScaling,);
    path2.cubicTo(11.8 * _xScaling,47.3 * _yScaling,10.8 * _xScaling,46.7 * _yScaling,9.9 * _xScaling,46 * _yScaling,);
    path2.cubicTo(9.9 * _xScaling,46 * _yScaling,9.9 * _xScaling,46 * _yScaling,9.9 * _xScaling,46 * _yScaling,);

    Path path3 = Path();
    path3.lineTo(6.5 * _xScaling,43 * _yScaling);
    path3.cubicTo(5.1 * _xScaling,41.5 * _yScaling,3.9 * _xScaling,39.8 * _yScaling,2.8 * _xScaling,38 * _yScaling,);
    path3.cubicTo(2.8 * _xScaling,38 * _yScaling,2.8 * _xScaling,47.9 * _yScaling,2.8 * _xScaling,47.9 * _yScaling,);
    path3.cubicTo(4.6 * _xScaling,46.7 * _yScaling,5.9 * _xScaling,45 * _yScaling,6.5 * _xScaling,43 * _yScaling,);
    path3.cubicTo(6.5 * _xScaling,43 * _yScaling,6.5 * _xScaling,43 * _yScaling,6.5 * _xScaling,43 * _yScaling,);

    return Path.combine(PathOperation.union,(Path.combine(PathOperation.union, path1, path2,)),path3);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
