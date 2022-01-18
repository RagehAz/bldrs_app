import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerBox({
    @required this.flyerWidthFactor,
    this.stackWidgets,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // --- NEAT AND CLEAN
  /// width factor * screenWidth = flyerWidth
  final double flyerWidthFactor;
  /// internal parts of the flyer
  final List<Widget> stackWidgets;
  /// --------------------------------------------------------------------------
  static double width(BuildContext context, double flyerSizeFactor) {
    return Scale.superScreenWidth(context) * flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double height(BuildContext context, double flyerBoxWidth) {
    final double _flyerZoneHeight = sizeFactorByWidth(context, flyerBoxWidth) == 1 ?
    Scale.superScreenHeightWithoutSafeArea(context)
        :
    flyerBoxWidth * Ratioz.xxflyerZoneHeight;

    return _flyerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByWidth(BuildContext context, double flyerBoxWidth) {
    return flyerBoxWidth / Scale.superScreenWidth(context);
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByHeight(BuildContext context, double flyerZoneHeight) {
    final double _flyerBoxWidth =
    flyerZoneHeight == Scale.superScreenHeightWithoutSafeArea(context) ?
    Scale.superScreenWidth(context)
        :
    (flyerZoneHeight / Ratioz.xxflyerZoneHeight);

    return sizeFactorByWidth(context, _flyerBoxWidth);
  }
// -----------------------------------------------------------------------------
  static double heightBySizeFactor({
    @required BuildContext context,
    @required double flyerSizeFactor,
  }) {
    final double _flyerBoxWidth = width(context, flyerSizeFactor);
    return height(context, _flyerBoxWidth);
  }
// -----------------------------------------------------------------------------
  static double topCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerTopCorners;
  }
// -----------------------------------------------------------------------------
  static double bottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius borders(BuildContext context, double flyerBoxWidth) {
    final double _flyerTopCorners = topCornerValue(flyerBoxWidth);
    final double _flyerBottomCorners = bottomCornerValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
        context: context,
        enTopLeft: _flyerTopCorners,
        enBottomLeft: _flyerBottomCorners,
        enBottomRight: _flyerBottomCorners,
        enTopRight: _flyerTopCorners);
  }
// -----------------------------------------------------------------------------
  static bool isTinyMode(BuildContext context, double flyerBoxWidth) {
    bool _tinyMode = false; // 0.4 needs calibration

    if (flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58)) {
      _tinyMode = true;
    }

    return _tinyMode;
  }
// -----------------------------------------------------------------------------
  static double headerBoxHeight({
    @required bool bzPageIsOn,
    @required double flyerBoxWidth
  }) {
    final double _miniHeaderHeightAtMaxState = flyerBoxWidth * Ratioz.xxflyerHeaderMaxHeight;
    final double _miniHeaderHeightAtMiniState = flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    final double _headerHeight = bzPageIsOn == true ?
    _miniHeaderHeightAtMaxState
        :
    _miniHeaderHeightAtMiniState;

    return _headerHeight;
  }
// -----------------------------------------------------------------------------
  static double headerStripHeight({
    @required bool bzPageIsOn,
    @required double flyerBoxWidth,
  }) {
    final double _headerStripHeight = bzPageIsOn == true ?
    flyerBoxWidth
        :
    flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _headerStripHeight;
  }
// -----------------------------------------------------------------------------
  static double headerOffsetHeight(double flyerBoxWidth) {
    final double _headerOffsetHeight =
        (flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight)
            -
            (2 * flyerBoxWidth * Ratioz.xxfollowCallSpacing);

    return _headerOffsetHeight;
  }
// -----------------------------------------------------------------------------
  static double logoWidth({
    @required bool bzPageIsOn,
    @required double flyerBoxWidth
  }) {
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _headerOffsetWidth = flyerBoxWidth - (2 * _headerMainPadding);
    final double _logoWidth = bzPageIsOn == true ?
    _headerOffsetWidth
        :
    (flyerBoxWidth * Ratioz.xxflyerLogoWidth);

    return _logoWidth;
  }
// -----------------------------------------------------------------------------
  static double headerAndProgressHeights(double flyerBoxHeight) {
    final double _headerBoxHeight = headerBoxHeight(
        bzPageIsOn: false,
        flyerBoxWidth: flyerBoxHeight
    );

    return _headerBoxHeight + flyerBoxHeight * Ratioz.xxProgressBarHeightRatio;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _flyerBoxWidth = width(context, flyerWidthFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, _flyerBoxWidth);
    final BorderRadius _flyerBorders = borders(context, _flyerBoxWidth);
// -----------------------------------------------------------------------------
    return Center( /// to prevent flyer stretching out
      child: Container(
        width: _flyerBoxWidth,
        height: _flyerZoneHeight,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colorz.white20,
          borderRadius: _flyerBorders,
          // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
        ),
        child: ClipRRect( /// because I will not pass borders to all children
          borderRadius: _flyerBorders,
          child: Container(
            width: _flyerBoxWidth,
            height: _flyerZoneHeight,
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets ?? <Widget>[],
            ),
          ),
        ),
      ),
    );

  }
}
