import 'package:bldrs/view_brains/drafters/text_directionerz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
double superScreenWidth (BuildContext context){
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth;
}
// === === === === === === === === === === === === === === === === === === ===
double superScreenHeight (BuildContext context){
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superFlyerZoneWidth (BuildContext context, double flyerSizeFactor){
  double screenWidth = superScreenWidth(context);
  double flyerZoneWidth = screenWidth * flyerSizeFactor;
  return flyerZoneWidth;
}
// === === === === === === === === === === === === === === === === === === ===
double superSafeAreaTopPadding (BuildContext context){
  double safeAreaHeight = MediaQuery.of(context).padding.top;
return safeAreaHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superScreenHeightWithoutSafeArea (BuildContext context){
  double screenWithoutSafeAreaHeight = superScreenHeight(context) - superSafeAreaTopPadding(context);
  return screenWithoutSafeAreaHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superFlyerSizeFactor (BuildContext context, double flyerZoneWidth){
  double flyerSizeFactor = flyerZoneWidth/superScreenWidth(context);
  return flyerSizeFactor;
}
// === === === === === === === === === === === === === === === === === === ===
double superFlyerZoneHeight (BuildContext context, double flyerZoneWidth){
  double flyerZoneHeight = superFlyerSizeFactor(context, flyerZoneWidth) == 1 ?
  superScreenHeightWithoutSafeArea(context)
      :
  flyerZoneWidth * Ratioz.xxflyerZoneHeight;
  return flyerZoneHeight;
}
// === === === === === === === === === === === === === === === === === === ===
bool superFlyerMicroMode (BuildContext context, double flyerZoneWidth){
  bool microMode = flyerZoneWidth < (superScreenWidth(context) * 0.4) ? true : false; // 0.4 needs calibration
  return microMode;
}
// === === === === === === === === === === === === === === === === === === ===
bool superFlyerMiniMode (BuildContext context, double flyerZoneWidth){
  bool miniMode = flyerZoneWidth < (superScreenWidth(context) * 0.70) ? true : false; // 0.4 needs calibration
  return miniMode;
}
// === === === === === === === === === === === === === === === === === === ===
double superHeaderHeight(bool bzPageIsOn, double flyerZoneWidth){
  double miniHeaderHeightAtMaxState = flyerZoneWidth * Ratioz.xxflyerHeaderMaxHeight;
  double miniHeaderHeightAtMiniState = flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
  double headerHeight = bzPageIsOn == true ? miniHeaderHeightAtMaxState : miniHeaderHeightAtMiniState;
return headerHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superHeaderStripHeight(bool bzPageIsOn, double flyerZoneWidth){
  double headerStripHeight = bzPageIsOn == true ? flyerZoneWidth : flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
  return headerStripHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superHeaderOffsetHeight(double flyerZoneWidth){
  double headerOffsetHeight = (flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight) - (2 * flyerZoneWidth * Ratioz.xxfollowCallSpacing);
  return headerOffsetHeight;
}
// === === === === === === === === === === === === === === === === === === ===
double superLogoWidth(bool bzPageIsOn, double flyerZoneWidth ){
  double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
  double headerOffsetWidth = flyerZoneWidth - (2 * headerMainPadding);
  double logoWidth = bzPageIsOn == true ? headerOffsetWidth : (flyerZoneWidth*Ratioz.xxflyerLogoWidth);
  return logoWidth;
}
// === === === === === === === === === === === === === === === === === === ===
double superDeviceRatio(BuildContext context){
  final size = MediaQuery.of(context).size;
  final deviceRatio = size.aspectRatio;
  return deviceRatio;
}
// === === === === === === === === === === === === === === === === === === ===
double superBubbleClearWidth(BuildContext context){
  double screenWidth = superScreenWidth(context);
  double bubbleMargins = Ratioz.ddAppBarMargin * 2;
  double bubblePaddings = bubbleMargins;
  double inBubbleClearWidth = screenWidth - bubbleMargins - bubblePaddings;
  return inBubbleClearWidth;
}
// === === === === === === === === === === === === === === === === === === ===
EdgeInsets superInsets(BuildContext context,{double enBottom, double enLeft, double enRight, double enTop}){

  double _enBottom = enBottom ?? 0;
  double _enLeft = enLeft ?? 0;
  double _enRight = enRight ?? 0;
  double _enTop = enTop ?? 0;

  return
  appIsLeftToRight(context) ?
  EdgeInsets.only(bottom: _enBottom, left: _enLeft, right: _enRight, top: _enTop) :
  EdgeInsets.only(bottom: _enBottom, left: _enRight, right: _enLeft, top: _enTop);
}
// === === === === === === === === === === === === === === === === === === ===
