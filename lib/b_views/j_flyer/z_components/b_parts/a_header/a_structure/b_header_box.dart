import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderBox({
    @required this.flyerBoxWidth,
    @required this.headerHeightTween,
    @required this.headerColor,
    @required this.headerBorders,
    @required this.child,
    this.onHeaderTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onHeaderTap;
  final double flyerBoxWidth;
  /// either double of Animation<double>
  final dynamic headerHeightTween;
  final Color headerColor;
  final BorderRadius headerBorders;
  final Widget child;
  /// --------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth) {
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onHeaderTap,
      child: Container(
        width: flyerBoxWidth,
        height: headerHeightTween is Animation<double> ? headerHeightTween.value : headerHeightTween,
        decoration: BoxDecoration(
          color: headerColor,
          borderRadius: headerBorders,
        ),
        alignment: Alignment.topCenter,
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: headerBorders,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: child,
            ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
