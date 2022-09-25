import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class MiniHeaderStripBoxPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeaderStripBoxPart({
    @required this.flyerBoxWidth,
    @required this.minHeaderHeight,
    @required this.logoSizeRatioTween,
    @required this.headerLeftSpacerTween,
    @required this.tinyMode,
    @required this.headerBorders,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double> logoSizeRatioTween;
  final Animation<double> headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius headerBorders;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: flyerBoxWidth,
      height: (minHeaderHeight * logoSizeRatioTween.value) + (headerLeftSpacerTween.value),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: headerLeftSpacerTween.value),
      // decoration: BoxDecoration(
        // color: tinyMode == true ? Colorz.white50 : Colorz.black80,
        // borderRadius: Borderers.superBorderOnly(
        //   context: context,
        //   enTopRight: headerBorders.topRight.x,
        //   enTopLeft: headerBorders.topRight.x,
        //   enBottomRight: 0,
        //   enBottomLeft: 0,
        // ),
      // ),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>('miniHeaderStrip'),
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
