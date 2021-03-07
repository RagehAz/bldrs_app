import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerOuterMaskLayer extends StatelessWidget {
  final double flyerSizeFactor;
  final Color color;

  FlyerOuterMaskLayer({
    @required this.flyerSizeFactor,
    @required this.color,
});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: true,
      bottom: true,
      child: Container(
        width: superScreenWidth(context),
        height: superScreenHeightWithoutSafeArea(context),
        child: CustomPaint(
          painter: FlyerHolePainter(
            context: context,
            flyerZoneWidth: superFlyerZoneWidth(context, flyerSizeFactor),
            outerColor: color,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class FlyerHolePainter extends CustomPainter {
  final BuildContext context;
  final double flyerZoneWidth;
  final Color outerColor;

  FlyerHolePainter({
    @required this.context,
    @required this.flyerZoneWidth,
    @required this.outerColor,
});

  @override
  void paint(Canvas canvas, Size size) {
    // === === === === === === === === === === === === === === === === === === =
    /// the (0, 0) is top left corner
    /// X is distance from left
    double _outerZeroX = 0;
    /// Y is distance from top
    double _outerZeroY = 0;
    //--------------------------------------------------------------------------
    double _outerWidth = superScreenWidth(context);
    double _outerHeight = superScreenHeightWithoutSafeArea(context);

    print(' a77aaaa   superScreenHeightWithoutSafeArea(context) = ${superScreenHeightWithoutSafeArea(context)},, superScreenHeight(context) = ${superScreenHeight(context)}');
    //--------------------------------------------------------------------------
    /// if its not full size
    Radius _outerTopCorners = Radius.circular(0); //Radius.circular(_outerWidth * Ratioz.xxflyerTopCorners);
    Radius _outerBottomCorners = Radius.circular(0); //Radius.circular(_outerWidth * Ratioz.xxflyerBottomCorners);
    // === === === === === === === === === === === === === === === === === === =
    double _innerWidth = flyerZoneWidth;
    double _innerHeight = superFlyerZoneHeight(context, _innerWidth);
    //--------------------------------------------------------------------------
    double _innerZeroX = (_outerWidth - _innerWidth) / 2;
    double _innerZeroY = ((_outerHeight - _innerHeight) / 2);
    //--------------------------------------------------------------------------
    Radius _innerTopCorners = Radius.circular(_innerWidth * Ratioz.xxflyerTopCorners);
    Radius _innerBottomCorners = Radius.circular(_innerWidth * Ratioz.xxflyerBottomCorners);
    // === === === === === === === === === === === === === === === === === === =


    final paint = Paint();
    paint.color = outerColor;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,

        Path()..addRRect(
            RRect.fromRectAndCorners(
            Rect.fromLTWH(_outerZeroX, _outerZeroY, _outerWidth, _outerHeight),
              bottomLeft: _outerBottomCorners,bottomRight: _outerBottomCorners,topRight: _outerTopCorners,topLeft: _outerTopCorners,)),

        Path()
          ..addRRect(RRect.fromRectAndCorners(
            Rect.fromLTWH(_innerZeroX, _innerZeroY, _innerWidth, _innerHeight),
            bottomRight: _innerBottomCorners,bottomLeft: _innerBottomCorners,topLeft: _innerTopCorners,topRight: _innerTopCorners,))

          ..close(),

      ),
      paint,
    );

    canvas.save();
    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}