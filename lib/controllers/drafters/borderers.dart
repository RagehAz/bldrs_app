import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';

class Borderers{
// === === === === === === === === === === === === === === === === === === ===
  /// takes context then goes english 'ltr' counter clockwise starting
  ///
  /// context -> topLeft -> bottomLeft -> bottomRight -> topRight
  static BorderRadius superBorderRadius({BuildContext context, double enTopLeft, double enBottomLeft, double enBottomRight, double enTopRight}){
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
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superFlyerCorners (BuildContext context, double flyerZoneWidth){
    double bottomFlyerCorner = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    BorderRadius flyerCorners = superBorderRadius(
        context: context,
        enTopLeft: upperFlyerCorner,
        enBottomLeft: bottomFlyerCorner,
        enBottomRight: bottomFlyerCorner,
        enTopRight: upperFlyerCorner);
    return flyerCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superHeaderShadowCorners (BuildContext context, double flyerZoneWidth){
    double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    BorderRadius flyerCorners = superBorderRadius(
        context: context,
        enTopLeft: upperFlyerCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: upperFlyerCorner
    );
    return flyerCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superHeaderCorners (BuildContext context, bool bzPageIsOn, double flyerZoneWidth){
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double headerZeroCorner = bzPageIsOn == true ? 0 : headerMainCorners;
    BorderRadius headerCorners = superBorderRadius(
        context: context,
        enTopLeft: headerMainCorners,
        enBottomLeft: headerMainCorners,
        enBottomRight: headerZeroCorner,
        enTopRight: headerMainCorners
    );
    return headerCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superHeaderStripCorners(BuildContext context, bool bzPageIsOn, double flyerZoneWidth){
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;//bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
    double headerZeroCorner = bzPageIsOn == false ? headerMainCorners : 0;
    BorderRadius headerStripCorners = superBorderRadius(
        context: context,
        enTopLeft: headerMainCorners,
        enBottomLeft: headerMainCorners,
        enBottomRight: headerZeroCorner,
        enTopRight: headerMainCorners,
    );
    return headerStripCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superFollowOrCallCorners(BuildContext context, double flyerZoneWidth, bool gettingFollowCorner){
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double headerOffsetCorner = headerMainCorners - flyerZoneWidth * Ratioz.xxfollowCallSpacing;
    double followBTCornerTL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerTR = headerOffsetCorner;
    double followBTCornerBL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
    double followBTCornerBR = flyerZoneWidth * 0.021;
    BorderRadius followCorners = superBorderRadius(
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
    BorderRadius callCorners = superBorderRadius(
        context: context,
        enTopLeft: callBTCornerTL,
        enBottomLeft: callBTCornerBL,
        enBottomRight: callBTCornerBR,
        enTopRight: callBTCornerTR
    );
    return gettingFollowCorner == true ? followCorners : callCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
  static OutlineInputBorder superOutlineInputBorder(Color borderColor, double corner) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corner),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
// === === === === === === === === === === === === === === === === === === ===
  static BorderRadius superBorderAll(BuildContext context, double corners){
    return BorderRadius.all(Radius.circular(corners));
  }
// === === === === === === === === === === === === === === === === === === ===
  /// used in [MiniHeaderStrip] widget
  static BorderRadius superLogoCorner(BuildContext context, double flyerZoneWidth){
    double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;//bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
    double headerOffsetCorner = headerMainCorners - headerMainPadding;
    double logoRoundCorners = headerOffsetCorner;//bzPageIsOn == false ? headerOffsetCorner : logoWidth * Ratioz.bzLogCorner;

    BorderRadius logoCorners = superBorderRadius(
        context: context,
        enTopLeft: logoRoundCorners,
        enBottomLeft: logoRoundCorners,
        enBottomRight: 0,
        enTopRight: logoRoundCorners
    );
    return logoCorners;
  }
// === === === === === === === === === === === === === === === === === === ===
}

