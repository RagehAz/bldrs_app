import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {

  const FlyerFooter({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static double boxCornersValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius corners({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _bottomCorner = boxCornersValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
      context: context,
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
