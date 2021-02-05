import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
/// takes the damn context then goes english 'ltr' counter clockwise starting
///
/// context -> topLeft -> bottomLeft -> bottomRight -> topRight
BorderRadius superBorderRadius(BuildContext context, double enTopLeft, double enBottomLeft, double enBottomRight, double enTopRight){
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
BorderRadius superFlyerCorners (BuildContext context, double flyerZoneWidth){
  double bottomFlyerCorner = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
  double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
  BorderRadius flyerCorners = superBorderRadius(context, upperFlyerCorner, bottomFlyerCorner, bottomFlyerCorner, upperFlyerCorner);
  return flyerCorners;
}
// === === === === === === === === === === === === === === === === === === ===
BorderRadius superHeaderShadowCorners (BuildContext context, double flyerZoneWidth){
  double upperFlyerCorner = flyerZoneWidth * Ratioz.xxflyerTopCorners;
  BorderRadius flyerCorners = superBorderRadius(context, upperFlyerCorner, 0, 0, upperFlyerCorner);
  return flyerCorners;
}
// === === === === === === === === === === === === === === === === === === ===
BorderRadius superHeaderCorners (BuildContext context, bool bzPageIsOn, double flyerZoneWidth){
  double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
  double headerZeroCorner = bzPageIsOn == true ? 0 : headerMainCorners;
  BorderRadius headerCorners = superBorderRadius(context, headerMainCorners, headerMainCorners, headerZeroCorner, headerMainCorners);
  return headerCorners;
}
// === === === === === === === === === === === === === === === === === === ===
BorderRadius superHeaderStripCorners(BuildContext context, bool bzPageIsOn, double flyerZoneWidth){
  double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;//bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
  double headerZeroCorner = bzPageIsOn == false ? headerMainCorners : 0;
  BorderRadius headerStripCorners = superBorderRadius(context, headerMainCorners, headerMainCorners, headerZeroCorner, headerMainCorners);
      return headerStripCorners;
}
// === === === === === === === === === === === === === === === === === === ===
BorderRadius superFollowOrCallCorners(BuildContext context, double flyerZoneWidth, bool gettingFollowCorner){
  double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
  double headerOffsetCorner = headerMainCorners - flyerZoneWidth * Ratioz.xxfollowCallSpacing;
  double followBTCornerTL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
  double followBTCornerTR = headerOffsetCorner;
  double followBTCornerBL = flyerZoneWidth * Ratioz.xxauthorImageCorners;
  double followBTCornerBR = flyerZoneWidth * 0.021;
  BorderRadius followCorners = superBorderRadius(context, followBTCornerTL, followBTCornerBL, followBTCornerBR, followBTCornerTR);
  double callBTCornerTL = followBTCornerBL;
  double callBTCornerTR = followBTCornerBR;
  double callBTCornerBL = followBTCornerTL;
  double callBTCornerBR = followBTCornerTR;
  BorderRadius callCorners = superBorderRadius(context, callBTCornerTL, callBTCornerBL, callBTCornerBR, callBTCornerTR);
      return gettingFollowCorner == true ? followCorners : callCorners;
}
// === === === === === === === === === === === === === === === === === === ===
OutlineInputBorder superOutlineInputBorder(Color borderColor, double corner) {
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
BorderRadius superBorderAll(BuildContext context, double corners){
  return BorderRadius.all(Radius.circular(corners));
}
// === === === === === === === === === === === === === === === === === === ===
/// used in [MiniHeaderStrip] widget
BorderRadius superLogoCorner(BuildContext context, double flyerZoneWidth){
  double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
  double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;//bzPageIsOn == false ? flyerZoneWidth * Ratioz.xxflyerTopCorners : flyerZoneWidth * Ratioz.bzLogCorner;
  double headerOffsetCorner = headerMainCorners - headerMainPadding;
  double logoRoundCorners = headerOffsetCorner;//bzPageIsOn == false ? headerOffsetCorner : logoWidth * Ratioz.bzLogCorner;

  BorderRadius logoCorners = superBorderRadius(context, logoRoundCorners, logoRoundCorners, 0, logoRoundCorners);
  return logoCorners;
}
// === === === === === === === === === === === === === === === === === === ===
