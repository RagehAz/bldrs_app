import 'package:flutter/material.dart';

class NormalUserBubble extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 50;
    final double _yScaling = size.height / 50;
    path.lineTo(47.9 * _xScaling,25.4 * _yScaling);
    path.cubicTo(47.9 * _xScaling,37.8 * _yScaling,37.8 * _xScaling,47.9 * _yScaling,25.4 * _xScaling,47.9 * _yScaling,);
    path.cubicTo(13 * _xScaling,47.9 * _yScaling,2.9 * _xScaling,37.8 * _yScaling,2.9 * _xScaling,25.4 * _yScaling,);
    path.cubicTo(2.9 * _xScaling,13 * _yScaling,12.9 * _xScaling,2.9 * _yScaling,25.4 * _xScaling,2.9 * _yScaling,);
    path.cubicTo(37.9 * _xScaling,2.9 * _yScaling,47.9 * _xScaling,12.9 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,);
    path.cubicTo(47.9 * _xScaling,25.4 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,47.9 * _xScaling,25.4 * _yScaling,);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
