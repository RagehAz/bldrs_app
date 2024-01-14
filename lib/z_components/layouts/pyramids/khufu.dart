import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:flutter/material.dart';

class Khufu extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Khufu({
    this.width,
    this.backColor,
    this.frontColor,
    this.splashColor,
    this.onTap,
    this.onDoubleTap,
    super.key
  });
  // --------------------
  final double? width;
  final Color? frontColor;
  final Color? backColor;
  final Color? splashColor;
  final Function? onTap;
  final Function? onDoubleTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _standardWidth = Pyramids.khafreWidth;
    const double _standardHeight = Pyramids.khafreHeight;

    final double _width = width ?? _standardWidth;
    final double _height = width == null ? _standardHeight : (_standardHeight/_standardWidth)*_width;

    final Color _backColor = backColor ?? const Color.fromRGBO(15, 15, 15, 1);
    final Color _frontColor = frontColor ?? Colorz.yellow255;
    final Color _splashColor = splashColor ?? Colorz.yellow125;

    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          CustomPaint(
            painter: KhufuPainter(
              frontColor: _frontColor,
              backColor: _backColor,
            ),
            size: Size(_width, _height),
          ),

          if (onTap != null)
          TapLayer(
            width: _width,
            height: _height,
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            splashColor: _splashColor,
            customBorder: const KhufuBorder(),
          ),

        ],
      ),
    );
  }
  // --------------------------------------------------------------------------
}

class KhufuPainter extends CustomPainter {
  // --------------------------------------------------------------------------
  const KhufuPainter({
    required this.frontColor,
    required this.backColor,
  });
  // --------------------
  final Color frontColor;
  final Color backColor;
  // --------------------------------------------------------------------------
  @override
  void paint(Canvas canvas, Size size) {

    /// BACK TRIANGLE
    final Paint paint = Paint()..color = backColor;
    final Path path = _getKhufuBackFacePath(size);
    canvas.drawPath(path, paint);

    /// FRONT TRIANGLE
    final Paint paint2 = Paint()..color = frontColor;
    final Path path2 = _getKhufuFrontFacePath(size);
    canvas.drawPath(path2, paint2);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class KhufuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    /// BACK TRIANGLE
    final Path path = _getKhufuWholePath(size);
    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class KhufuBorder extends ShapeBorder {

  const KhufuBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getKhufuWholePath(Size(rect.width, rect.height));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return const KhufuBorder();
  }

}

Path _getKhufuWholePath(Size size) {
  const double khafreTipLeftRatio = Pyramids.leftSpaceToKhafreTip / Pyramids.khafreWidth;
  /// BACK TRIANGLE
  final Path path = Path();
  /// Top point
  path.moveTo(size.width * khafreTipLeftRatio, 0);
  /// Bottom left point
  path.lineTo(0, size.height);
  /// Bottom right point
  path.lineTo(size.width, size.height);
  path.close();
  return path;
}

Path _getKhufuBackFacePath(Size size) {
  const double khafreTipLeftRatio = Pyramids.leftSpaceToKhafreTip / Pyramids.khafreWidth;
  const double khafreBaseLeftRatio = Pyramids.leftSpaceToKhufuBase / Pyramids.khafreWidth;
  /// BACK TRIANGLE
  final Path path = Path();
  /// Top point
  path.moveTo(size.width * khafreTipLeftRatio, 0);
  /// Bottom left point
  path.lineTo(0, size.height);
  /// Bottom right point
  path.lineTo(size.width * khafreBaseLeftRatio, size.height);
  path.close();
  return path;
}

Path _getKhufuFrontFacePath(Size size) {

  const double khafreTipLeftRatio = Pyramids.leftSpaceToKhafreTip / Pyramids.khafreWidth;
  const double khafreBaseLeftRatio = Pyramids.leftSpaceToKhufuBase / Pyramids.khafreWidth;

  final Path path2 = Path();
  /// Top point
  path2.moveTo(size.width * khafreTipLeftRatio, 0);
  /// Bottom left point
  path2.lineTo(size.width * khafreBaseLeftRatio, size.height);
  /// Bottom right point
  path2.lineTo(size.width, size.height);
  /// CLOSE
  path2.close();

  return path2;
}
