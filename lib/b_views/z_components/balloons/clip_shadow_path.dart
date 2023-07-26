import 'package:flutter/material.dart';

@immutable
class ClipShadowPath extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ClipShadowPath({
    required this.shadow,
    required this.clipper,
    required this.child,
    required this.shadowIsOn,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Shadow? shadow;
  final CustomClipper<Path>? clipper;
  final bool shadowIsOn;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (shadowIsOn == true && shadow != null){
      return CustomPaint(
        key: UniqueKey(),
        painter: _ClipShadowPainter(
          clipper: clipper,
          shadow: shadow!,
        ),
        child: ClipPath(
            clipper: clipper,
            child: child,
        ),
      );
    }

    else {
      return ClipPath(
        clipper: clipper,
        child: child,
      );
    }

  }
  /// --------------------------------------------------------------------------
}

class _ClipShadowPainter extends CustomPainter {
  /// --------------------------------------------------------------------------
  _ClipShadowPainter({
    required this.shadow,
    required this.clipper
  });
  /// --------------------------------------------------------------------------
  final Shadow shadow;
  final CustomClipper<Path>? clipper;
  /// --------------------------------------------------------------------------
  @override
  void paint(Canvas canvas, Size size) {
    final dynamic paint = shadow.toPaint();
    final dynamic clipPath = clipper?.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }
  /// --------------------------------------------------------------------------
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  /// --------------------------------------------------------------------------
}
