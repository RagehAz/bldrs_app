import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// VARS OPTIMIZED
class FlyerBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerBox({
    @required this.flyerBoxWidth,
    this.stackWidgets,
    this.boxColor = Colorz.white20,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // --- NEAT AND CLEAN
  /// width factor * screenWidth = flyerWidth
  final double flyerBoxWidth;
  /// internal parts of the flyer
  final List<Widget> stackWidgets;
  final Color boxColor;
  final Function onTap;
  // -----------------------------------------------------------------------------

  /// FLYER SIZES

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double width(BuildContext context, double flyerSizeFactor) {
    return Scale.superScreenWidth(context) * flyerSizeFactor;
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double widthByHeight(BuildContext context, double flyerBoxHeight){
    return width(context, sizeFactorByHeight(context, flyerBoxHeight));
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double height(BuildContext context, double flyerBoxWidth) {

    if (sizeFactorByWidth(context, flyerBoxWidth) == 1){
      return Scale.superScreenHeightWithoutSafeArea(context);
    }

    else {
      return flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    }

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double sizeFactorByWidth(BuildContext context, double flyerBoxWidth) {
    return flyerBoxWidth / Scale.superScreenWidth(context);
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double sizeFactorByHeight(BuildContext context, double flyerZoneHeight) {

    if (flyerZoneHeight == Scale.superScreenHeightWithoutSafeArea(context)){
      return sizeFactorByWidth(context, Scale.superScreenWidth(context));
    }
    else {
      return sizeFactorByWidth(context, flyerZoneHeight / Ratioz.xxflyerZoneHeight);
    }

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double heightBySizeFactor({
    @required BuildContext context,
    @required double flyerSizeFactor,
  }) {
    return height(context, width(context, flyerSizeFactor));
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static bool isTinyMode(BuildContext context, double flyerBoxWidth) {
    bool _tinyMode = false; // 0.4 needs calibration

    if (flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58)) {
      _tinyMode = true;
    }

    return _tinyMode;
  }
  // -----------------------------------------------------------------------------

  /// FLYER CORNERS

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double topCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerTopCorners;
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double bottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
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

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerBoxHeight({
    @required double flyerBoxWidth
  }) {
    return flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerStripHeight({
    @required bool headerIsExpanded,
    @required double flyerBoxWidth,
  }) {

    if (headerIsExpanded == true){
      return flyerBoxWidth;
    }
    else {
      return flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    }

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerOffsetHeight(double flyerBoxWidth) {
    return
          (flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight)
            -
          (2 * flyerBoxWidth * Ratioz.xxfollowCallSpacing);
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerAndProgressHeights({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {
    return
          headerBoxHeight(flyerBoxWidth: flyerBoxWidth)
          +
          (height(context, flyerBoxWidth) * Ratioz.xxProgressBarHeightRatio);
  }
  // -----------------------------------------------------------------------------

  /// HEADER CORNERS

  // --------------------
  /// TAMAM : WORKS PERFECT
  static BorderRadius superHeaderCorners({
    @required BuildContext context,
    @required bool bzPageIsOn,
    @required double flyerBoxWidth
  }) {

    final double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    final double headerZeroCorner = bzPageIsOn == true ? 0 : headerMainCorners;

    return Borderers.superBorderOnly(
        context: context,
        enTopLeft: headerMainCorners,
        enBottomLeft: headerMainCorners,
        enBottomRight: headerZeroCorner,
        enTopRight: headerMainCorners
    );

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static BorderRadius superHeaderStripCorners({
    @required BuildContext context,
    @required bool bzPageIsOn,
    @required double flyerBoxWidth,
  }) {

    final double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    final double headerZeroCorner = bzPageIsOn == false ? headerMainCorners : 0;

    return Borderers.superBorderOnly(
      context: context,
      enTopLeft: headerMainCorners,
      enBottomLeft: headerMainCorners,
      enBottomRight: headerZeroCorner,
      enTopRight: headerMainCorners,
    );

  }
  // -----------------------------------------------------------------------------

  /// LOGO SIZE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double logoWidth({
    @required bool bzPageIsOn,
    @required double flyerBoxWidth
  }) {

    if (bzPageIsOn == true){
      return flyerBoxWidth - (2 * flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding);
    }
    else {
      return flyerBoxWidth * Ratioz.xxflyerLogoWidth;
    }

  }
  // -----------------------------------------------------------------------------

  /// LOGO CORNER

  // --------------------
  /// TAMAM : WORKS PERFECT
  static BorderRadius superLogoCorner({
    @required BuildContext context,
    @required double flyerBoxWidth,
    bool zeroCornerIsOn = false
  }) {

    final double _logoRoundCorners =
            /// HEADER MAIN CORNERS
            (flyerBoxWidth * Ratioz.xxflyerTopCorners)
            -
            /// HEADER MAIN PADDING
            (flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding);

    if (zeroCornerIsOn == true){
      return Borderers.superBorderOnly(
          context: context,
          enTopLeft: _logoRoundCorners,
          enBottomLeft: _logoRoundCorners,
          enBottomRight: 0,
          enTopRight: _logoRoundCorners
      );
    }

    else {
      return Borderers.superBorderAll(context, _logoRoundCorners);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _flyerBorders = corners(context, flyerBoxWidth);
    final double _flyerBoxHeight = FlyerBox.height(context, flyerBoxWidth);
    // --------------------
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          key: const ValueKey<String>('flyer_box'),
          width: flyerBoxWidth,
          height: _flyerBoxHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: _flyerBorders,
            // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
          ),
          child: SizedBox(
            width: flyerBoxWidth,
            height: _flyerBoxHeight,
            child: ClipRRect( /// because I will not pass borders to all children
              borderRadius: _flyerBorders,
              child: Stack(
                alignment: Alignment.topCenter,
                children: stackWidgets ?? <Widget>[],
              ),
            ),
          ),
        ),
      ),
    );
    // --------------------
    /// OLD : was working before optimization
    /*
        return SizedBox( /// to prevent forced center alignment
      width: flyerBoxWidth,
      height: _flyerZoneHeight,
      child: Center( /// to prevent flyer stretching out
        child: Container(
          key: const ValueKey<String>('flyer_box'),
          width: flyerBoxWidth,
          height: _flyerZoneHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: _flyerBorders,
            // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
          ),
          child: ClipRRect( /// because I will not pass borders to all children
            borderRadius: _flyerBorders,
            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets ?? <Widget>[],
            ),
          ),
        ),
      ),
    );
     */
  }
  // -----------------------------------------------------------------------------
}
