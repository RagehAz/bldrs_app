import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';

/// TASK : use clipBehaviour : Clip.antiAliasWithSaveLayer instead of ClipRRect
class Borderers {
// -----------------------------------------------------------------------------
  static BorderRadius superBorderOnly({
    BuildContext context,
    double enTopLeft,
    double enBottomLeft,
    double enBottomRight,
    double enTopRight
  }) {
    return
      Wordz.textDirection(context) == 'rtl' ?
      BorderRadius.only(
        topLeft: Radius.circular(enTopRight),
        topRight: Radius.circular(enTopLeft),
        bottomLeft: Radius.circular(enBottomRight),
        bottomRight: Radius.circular(enBottomLeft),
      )
          :
      BorderRadius.only(
        topLeft: Radius.circular(enTopLeft),
        topRight: Radius.circular(enTopRight),
        bottomLeft: Radius.circular(enBottomLeft),
        bottomRight: Radius.circular(enBottomRight),
      );
  }
// -----------------------------------------------------------------------------
  static BorderRadius superFlyerCorners(BuildContext context, double flyerBoxWidth) {
    double bottomFlyerCorner = flyerBoxWidth * Ratioz.xxflyerBottomCorners;
    double upperFlyerCorner = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    BorderRadius flyerCorners = superBorderOnly(
        context: context,
        enTopLeft: upperFlyerCorner,
        enBottomLeft: bottomFlyerCorner,
        enBottomRight: bottomFlyerCorner,
        enTopRight: upperFlyerCorner);
    return flyerCorners;
  }

// -----------------------------------------------------------------------------
  static BorderRadius superHeaderShadowCorners(BuildContext context,
      double flyerBoxWidth) {
    double upperFlyerCorner = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    BorderRadius flyerCorners = superBorderOnly(
        context: context,
        enTopLeft: upperFlyerCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: upperFlyerCorner
    );
    return flyerCorners;
  }

// -----------------------------------------------------------------------------
  static BorderRadius superHeaderCorners(BuildContext context, bool bzPageIsOn,
      double flyerBoxWidth) {
    double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    double headerZeroCorner = bzPageIsOn == true ? 0 : headerMainCorners;
    BorderRadius headerCorners = superBorderOnly(
        context: context,
        enTopLeft: headerMainCorners,
        enBottomLeft: headerMainCorners,
        enBottomRight: headerZeroCorner,
        enTopRight: headerMainCorners
    );
    return headerCorners;
  }

// -----------------------------------------------------------------------------
  static BorderRadius superHeaderStripCorners(BuildContext context, bool bzPageIsOn, double flyerBoxWidth) {
    double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners; //bzPageIsOn == false ? flyerBoxWidth * Ratioz.xxflyerTopCorners : flyerBoxWidth * Ratioz.bzLogCorner;
    double headerZeroCorner = bzPageIsOn == false ? headerMainCorners : 0;
    BorderRadius headerStripCorners = superBorderOnly(
      context: context,
      enTopLeft: headerMainCorners,
      enBottomLeft: headerMainCorners,
      enBottomRight: headerZeroCorner,
      enTopRight: headerMainCorners,
    );
    return headerStripCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius superPriceTagCorners(BuildContext context, double flyerBoxWidth){
    double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    return
      superBorderOnly(
        context: context,
        enTopLeft: 0,
        enBottomLeft: 0,
        enBottomRight: headerMainCorners,
        enTopRight: headerMainCorners,
      );
  }
// -----------------------------------------------------------------------------
  static BorderRadius superFollowOrCallCorners(BuildContext context,
      double flyerBoxWidth, bool gettingFollowCorner) {
    double headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    double headerOffsetCorner = headerMainCorners -
        flyerBoxWidth * Ratioz.xxfollowCallSpacing;
    double followBTCornerTL = flyerBoxWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerTR = headerOffsetCorner;
    double followBTCornerBL = flyerBoxWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerBR = flyerBoxWidth * 0.021;
    BorderRadius followCorners = superBorderOnly(
      context: context,
      enTopLeft: followBTCornerTL,
      enBottomLeft: followBTCornerBL,
      enBottomRight: followBTCornerBR,
      enTopRight: followBTCornerTR,
    );
    double callBTCornerTL = followBTCornerBL;
    double callBTCornerTR = followBTCornerBR;
    double callBTCornerBL = followBTCornerTL;
    double callBTCornerBR = followBTCornerTR;
    BorderRadius callCorners = superBorderOnly(
        context: context,
        enTopLeft: callBTCornerTL,
        enBottomLeft: callBTCornerBL,
        enBottomRight: callBTCornerBR,
        enTopRight: callBTCornerTR
    );
    return gettingFollowCorner == true ? followCorners : callCorners;
  }

// -----------------------------------------------------------------------------
  static OutlineInputBorder superOutlineInputBorder(Color borderColor,
      double corner) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corner),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }

// -----------------------------------------------------------------------------
  static BorderRadius superBorderAll(BuildContext context, double corners) {
    return BorderRadius.all(Radius.circular(corners));
  }

// -----------------------------------------------------------------------------
  /// used in [MiniHeaderStrip] widget
  static BorderRadius superLogoCorner({BuildContext context, double flyerBoxWidth, bool zeroCornerIsOn = false}) {
    double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    double _headerMainCorners = flyerBoxWidth * Ratioz.xxflyerTopCorners; //bzPageIsOn == false ? flyerBoxWidth * Ratioz.xxflyerTopCorners : flyerBoxWidth * Ratioz.bzLogCorner;
    double _headerOffsetCorner = _headerMainCorners - _headerMainPadding;
    double _logoRoundCorners = _headerOffsetCorner; //bzPageIsOn == false ? _headerOffsetCorner : logoWidth * Ratioz.bzLogCorner;

    BorderRadius _logoCornersWithZeroCorner = superBorderOnly(
        context: context,
        enTopLeft: _logoRoundCorners,
        enBottomLeft: _logoRoundCorners,
        enBottomRight: 0,
        enTopRight: _logoRoundCorners
    );


    BorderRadius _logoCornersAllRounded = superBorderAll(context, _logoRoundCorners);

    BorderRadius _logoCorners = zeroCornerIsOn == true ? _logoCornersWithZeroCorner : _logoCornersAllRounded;

    return _logoCorners;
  }

// -----------------------------------------------------------------------------
  static BorderRadius superLogoShape(
      {BuildContext context, bool zeroCornerEnIsRight, double corner}) {
    BorderRadius _superLogoShape =
    zeroCornerEnIsRight ?
    superBorderOnly(
      context: context,
      enBottomLeft: corner,
      enBottomRight: 0,
      enTopLeft: corner,
      enTopRight: corner,
    )
        :
    superBorderOnly(
      context: context,
      enBottomLeft: 0,
      enBottomRight: corner,
      enTopLeft: corner,
      enTopRight: corner,
    );

    return _superLogoShape;
  }

// -----------------------------------------------------------------------------
  static BorderRadius superBorder({BuildContext context, dynamic corners}) {
    BorderRadius _corner =
    corners == null || corners == 0 ? BorderRadius.zero
        :
    corners.runtimeType == double ? superBorderAll(context, corners)
        :
    corners.runtimeType == int ? superBorderAll(context, corners.toDouble())
        :
    corners.runtimeType == BorderRadius ? corners
        :
    corners;
    return _corner;
// -----------------------------------------------------------------------------

  }
// -----------------------------------------------------------------------------
  static double getCornersAsDouble(dynamic corners){
    BorderRadius _cornerBorders;
    double _topLeftCorner;
    if (corners.runtimeType == BorderRadius){
      _cornerBorders = corners;
      Radius _topLeftCornerRadius = _cornerBorders?.topLeft;
      _topLeftCorner =  _topLeftCornerRadius?.x;
      // print('_topLeftCorner : $_topLeftCorner');
    } else {
      _topLeftCorner = corners.toDouble();
    }

    return _topLeftCorner == null ? 0 : _topLeftCorner;
  }
// -----------------------------------------------------------------------------
  static BorderRadius getCornersAsBorderRadius(BuildContext context, dynamic corners){
    BorderRadius _cornerBorders;
    // double _topLeftCorner;
    if(corners == 0){
      _cornerBorders = BorderRadius.zero;
    }
    else if (corners.runtimeType == BorderRadius){
      _cornerBorders = corners;
    } else {
      _cornerBorders = Borderers.superBorderAll(context, corners.toDouble());
    }

    return _cornerBorders;
  }
// -----------------------------------------------------------------------------
}