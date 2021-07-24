import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';

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
  static BorderRadius superFlyerCorners(BuildContext context, double flyerZoneWidth) {
    double bottomFlyerCorner = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
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
      double flyerZoneWidth) {
    double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
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
      double flyerZoneWidth) {
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
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
  static BorderRadius superHeaderStripCorners(BuildContext context,
      bool bzPageIsOn, double flyerZoneWidth) {
    double headerMainCorners = flyerZoneWidth * Ratioz
        .xxflyerTopCorners; //bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
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
  static BorderRadius superFollowOrCallCorners(BuildContext context,
      double flyerZoneWidth, bool gettingFollowCorner) {
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double headerOffsetCorner = headerMainCorners -
        flyerZoneWidth * Ratioz.xxfollowCallSpacing;
    double followBTCornerTL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerTR = headerOffsetCorner;
    double followBTCornerBL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerBR = flyerZoneWidth * 0.021;
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
  static BorderRadius superLogoCorner(BuildContext context,
      double flyerZoneWidth) {
    double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners; //bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
    double headerOffsetCorner = headerMainCorners - headerMainPadding;
    double logoRoundCorners = headerOffsetCorner; //bzPageIsOn == false ? headerOffsetCorner : logoWidth * Ratioz.bzLogCorner;

    BorderRadius logoCorners = superBorderOnly(
        context: context,
        enTopLeft: logoRoundCorners,
        enBottomLeft: logoRoundCorners,
        enBottomRight: 0,
        enTopRight: logoRoundCorners
    );
    return logoCorners;
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