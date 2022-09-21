import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MaxHeaderBottomPadding extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MaxHeaderBottomPadding({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey<String>('max_header_bottom_padding'),
      width: flyerBoxWidth,
      height: flyerBoxWidth * Ratioz.xxflyerBottomCorners + Ratioz.appBarMargin,
      margin: EdgeInsets.only(top: flyerBoxWidth * Ratioz.xxbzPageSpacing),
      decoration: BoxDecoration(
        color: Colorz.black80,
        borderRadius: Borderers.superBorderOnly(
          context: context,
          enTopLeft: 0,
          enTopRight: 0,
          enBottomLeft: flyerBoxWidth * Ratioz.xxflyerBottomCorners,
          enBottomRight: flyerBoxWidth * Ratioz.xxflyerBottomCorners,
        ),
      ),
    );
  }
/// --------------------------------------------------------------------------
}
