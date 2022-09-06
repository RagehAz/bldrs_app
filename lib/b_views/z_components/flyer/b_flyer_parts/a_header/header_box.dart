import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderBox({
    @required this.tinyMode,
    @required this.onHeaderTap,
    @required this.flyerBoxWidth,
    @required this.headerHeightTween,
    @required this.headerColor,
    @required this.headerBorders,
    @required this.stackChildren,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool tinyMode;
  final Function onHeaderTap;
  final double flyerBoxWidth;
  /// either double of Animation<double>
  final dynamic headerHeightTween;
  final Color headerColor;
  final BorderRadius headerBorders;
  final List<Widget> stackChildren;
  /// --------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth) {
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (headerHeightTween is Animation<double>){
      final Animation<double> _headerHeightTween = headerHeightTween;
      return GestureDetector(
        onTap: tinyMode == true ? null : onHeaderTap,
        child: Container(
          width: flyerBoxWidth,
          height: _headerHeightTween.value,
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: headerBorders,
          ),
          alignment: Alignment.topCenter,
          child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: headerBorders,
              child: Stack(
                alignment: Alignment.topCenter,
                children: stackChildren,
              ),
            ),
          ),
        ),
      );
    }

    else {

      return GestureDetector(
        onTap: tinyMode == true ? null : onHeaderTap,
        child: Container(
          width: flyerBoxWidth,
          height: headerHeightTween,
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: headerBorders,
          ),
          alignment: Alignment.topCenter,
          child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: headerBorders,
              child: Stack(
                alignment: Alignment.topCenter,
                children: stackChildren,
              ),
            ),
          ),
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
