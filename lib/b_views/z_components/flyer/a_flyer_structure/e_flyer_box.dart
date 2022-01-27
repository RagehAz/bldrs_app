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
// -----------------------------------------------------------------------------

  /// FLYER SIZES

  //--------------------------------o
  static double width(BuildContext context, double flyerSizeFactor) {
    return Scale.superScreenWidth(context) * flyerSizeFactor;
  }
  //--------------------------------o
  static double height(BuildContext context, double flyerBoxWidth) {
    final double _flyerZoneHeight = sizeFactorByWidth(context, flyerBoxWidth) == 1 ?
    Scale.superScreenHeightWithoutSafeArea(context)
        :
    flyerBoxWidth * Ratioz.xxflyerZoneHeight;

    return _flyerZoneHeight;
  }
  //--------------------------------o
  static double sizeFactorByWidth(BuildContext context, double flyerBoxWidth) {
    return flyerBoxWidth / Scale.superScreenWidth(context);
  }
  //--------------------------------o
  static double sizeFactorByHeight(BuildContext context, double flyerZoneHeight) {
    final double _flyerBoxWidth =
    flyerZoneHeight == Scale.superScreenHeightWithoutSafeArea(context) ?
    Scale.superScreenWidth(context)
        :
    (flyerZoneHeight / Ratioz.xxflyerZoneHeight);

    return sizeFactorByWidth(context, _flyerBoxWidth);
  }
  //--------------------------------o
  static double heightByWidthFactor({
    @required BuildContext context,
    @required double flyerWidthFactor,
  }) {
    final double _flyerBoxWidth = width(context, flyerWidthFactor);
    return height(context, _flyerBoxWidth);
  }
  //--------------------------------o
  static bool isTinyMode(BuildContext context, double flyerBoxWidth) {
    bool _tinyMode = false; // 0.4 needs calibration

    if (flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58)) {
      _tinyMode = true;
    }

    return _tinyMode;
  }
// -----------------------------------------------------------------------------

  /// FLYER CORNERS

  //--------------------------------o
  static double topCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerTopCorners;
  }
  //--------------------------------o
  static double bottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
  //--------------------------------o
  static BorderRadius corners(BuildContext context, double flyerBoxWidth) {
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

  /// HEADER SIZES

  //--------------------------------o
  static double headerBoxHeight({
    @required double flyerBoxWidth
  }) {
    // final double _miniHeaderHeightAtMaxState = flyerBoxWidth * Ratioz.xxflyerHeaderMaxHeight;
    final double _miniHeaderHeightAtMiniState = flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    // final double _headerHeight = bzPageIsOn == true ?
    // _miniHeaderHeightAtMaxState
    //     :
    // _miniHeaderHeightAtMiniState;

    return _miniHeaderHeightAtMiniState;
  }
  //--------------------------------o
  static double headerStripHeight({
    @required bool headerIsExpanded,
    @required double flyerBoxWidth,
  }) {
    final double _headerStripHeight = headerIsExpanded == true ?
    flyerBoxWidth
        :
    flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _headerStripHeight;
  }
  //--------------------------------o
  static double headerOffsetHeight(double flyerBoxWidth) {
    final double _headerOffsetHeight =
        (flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight)
            -
            (2 * flyerBoxWidth * Ratioz.xxfollowCallSpacing);

    return _headerOffsetHeight;
  }
  //--------------------------------o
  static double headerAndProgressHeights(double flyerBoxHeight) {
    final double _headerBoxHeight = headerBoxHeight(
        flyerBoxWidth: flyerBoxHeight
    );

    return _headerBoxHeight + flyerBoxHeight * Ratioz.xxProgressBarHeightRatio;
  }
// -----------------------------------------------------------------------------

  /// HEADER CORNERS

  //--------------------------------o
  static BorderRadius superHeaderCorners({
    @required BuildContext context,
    @required bool bzPageIsOn,
    @required double flyerBoxWidth
  }) {
    final double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    final double headerZeroCorner = bzPageIsOn == true ? 0 : headerMainCorners;
    final BorderRadius headerCorners = Borderers.superBorderOnly(
        context: context,
        enTopLeft: headerMainCorners,
        enBottomLeft: headerMainCorners,
        enBottomRight: headerZeroCorner,
        enTopRight: headerMainCorners);
    return headerCorners;
  }
  //--------------------------------o
  static BorderRadius superHeaderStripCorners({
    @required BuildContext context,
    @required bool bzPageIsOn,
    @required double flyerBoxWidth,
  }) {
    final double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    //bzPageIsOn == false ? flyerBoxWidth * Ratioz.xxflyerTopCorners : flyerBoxWidth * Ratioz.bzLogCorner;

    final double headerZeroCorner = bzPageIsOn == false ? headerMainCorners : 0;
    final BorderRadius headerStripCorners = Borderers.superBorderOnly(
      context: context,
      enTopLeft: headerMainCorners,
      enBottomLeft: headerMainCorners,
      enBottomRight: headerZeroCorner,
      enTopRight: headerMainCorners,
    );
    return headerStripCorners;
  }
// -----------------------------------------------------------------------------

  /// LOGO SIZE

  //--------------------------------o
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

  /// LOGO CORNER

  //--------------------------------o
  static BorderRadius superLogoCorner({
    @required BuildContext context,
    @required double flyerBoxWidth,
    bool zeroCornerIsOn = false
  }) {

    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners; //bzPageIsOn == false ? flyerBoxWidth * Ratioz.xxflyerTopCorners : flyerBoxWidth * Ratioz.bzLogCorner;
    final double _headerOffsetCorner = _headerMainCorners - _headerMainPadding;
    final double _logoRoundCorners = _headerOffsetCorner; //bzPageIsOn == false ? _headerOffsetCorner : logoWidth * Ratioz.bzLogCorner;
    final BorderRadius _logoCornersWithZeroCorner = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _logoRoundCorners,
        enBottomLeft: _logoRoundCorners,
        enBottomRight: 0,
        enTopRight: _logoRoundCorners
    );

    final BorderRadius _logoCornersAllRounded = Borderers.superBorderAll(context, _logoRoundCorners);
    final BorderRadius _logoCorners = zeroCornerIsOn == true ?
    _logoCornersWithZeroCorner
        :
    _logoCornersAllRounded;

    return _logoCorners;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _flyerBoxWidth = width(context, flyerWidthFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, _flyerBoxWidth);
    final BorderRadius _flyerBorders = corners(context, _flyerBoxWidth);
// -----------------------------------------------------------------------------
    return Center( /// to prevent flyer stretching out
      key: const ValueKey<String>('flyer_box'),
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
