import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

import 'text_directionerz.dart';

class Scale{
// -----------------------------------------------------------------------------
  static double superScreenWidth (BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeight (BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
// -----------------------------------------------------------------------------
  static double superFlyerZoneWidth (BuildContext context, double flyerSizeFactor){
    double screenWidth = superScreenWidth(context);
    double flyerZoneWidth = screenWidth * flyerSizeFactor;
    return flyerZoneWidth;
  }
// -----------------------------------------------------------------------------
  static double superSafeAreaTopPadding (BuildContext context){
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    return safeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeightWithoutSafeArea (BuildContext context){
    double screenWithoutSafeAreaHeight = superScreenHeight(context) - superSafeAreaTopPadding(context);
    return screenWithoutSafeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superFlyerSizeFactor (BuildContext context, double flyerZoneWidth){
    double flyerSizeFactor = flyerZoneWidth/superScreenWidth(context);
    return flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double superFlyerZoneHeight (BuildContext context, double flyerZoneWidth){
    double flyerZoneHeight = superFlyerSizeFactor(context, flyerZoneWidth) == 1 ?
    superScreenHeightWithoutSafeArea(context)
        :
    flyerZoneWidth * Ratioz.xxflyerZoneHeight;
    return flyerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static bool superFlyerMicroMode (BuildContext context, double flyerZoneWidth){
    bool microMode = flyerZoneWidth < (superScreenWidth(context) * 0.4) ? true : false; // 0.4 needs calibration
    return microMode;
  }
// -----------------------------------------------------------------------------
  static bool superFlyerMiniMode (BuildContext context, double flyerZoneWidth){
    bool miniMode = flyerZoneWidth < (superScreenWidth(context) * 0.70) ? true : false; // 0.4 needs calibration
    return miniMode;
  }
// -----------------------------------------------------------------------------
  static double superHeaderHeight(bool bzPageIsOn, double flyerZoneWidth){
    double miniHeaderHeightAtMaxState = flyerZoneWidth * Ratioz.xxflyerHeaderMaxHeight;
    double miniHeaderHeightAtMiniState = flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
    double headerHeight = bzPageIsOn == true ? miniHeaderHeightAtMaxState : miniHeaderHeightAtMiniState;
    return headerHeight;
  }
// -----------------------------------------------------------------------------
  static double superHeaderStripHeight(bool bzPageIsOn, double flyerZoneWidth){
    double headerStripHeight = bzPageIsOn == true ? flyerZoneWidth : flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
    return headerStripHeight;
  }
// -----------------------------------------------------------------------------
  static double superHeaderOffsetHeight(double flyerZoneWidth){
    double headerOffsetHeight = (flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight) - (2 * flyerZoneWidth * Ratioz.xxfollowCallSpacing);
    return headerOffsetHeight;
  }
// -----------------------------------------------------------------------------
  static double superLogoWidth(bool bzPageIsOn, double flyerZoneWidth ){
    double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double headerOffsetWidth = flyerZoneWidth - (2 * headerMainPadding);
    double logoWidth = bzPageIsOn == true ? headerOffsetWidth : (flyerZoneWidth*Ratioz.xxflyerLogoWidth);
    return logoWidth;
  }
// -----------------------------------------------------------------------------
  static double superDeviceRatio(BuildContext context){
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.aspectRatio;
    return deviceRatio;
  }
// -----------------------------------------------------------------------------
  static double superBubbleClearWidth(BuildContext context){
    double _bubbleWidth = superBubbleWidth(context);
    double _bubblePaddings = Ratioz.ddAppBarMargin * 2;
    double _inBubbleClearWidth = _bubbleWidth - _bubblePaddings;
    return _inBubbleClearWidth;
  }
// -----------------------------------------------------------------------------
  static double superBubbleWidth(BuildContext context){
    double _screenWidth = superScreenWidth(context);
    double _bubbleMargins = Ratioz.ddAppBarMargin * 2;
    double _bubbleWidth = _screenWidth - _bubbleMargins;
    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets superInsets(BuildContext context,{double enBottom, double enLeft, double enRight, double enTop}){

    double _enBottom = enBottom ?? 0;
    double _enLeft = enLeft ?? 0;
    double _enRight = enRight ?? 0;
    double _enTop = enTop ?? 0;

    return
      appIsLeftToRight(context) ?
      EdgeInsets.only(bottom: _enBottom, left: _enLeft, right: _enRight, top: _enTop) :
      EdgeInsets.only(bottom: _enBottom, left: _enRight, right: _enLeft, top: _enTop);
  }
// -----------------------------------------------------------------------------
  static double superFlyerFooterHeight(double flyerZoneWidth){
    double _flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double _footerBTMargins = flyerZoneWidth * 0.025; //
    double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    double _flyerFooterHeight = (2 * _footerBTMargins) + (2 * _footerBTRadius);

    return _flyerFooterHeight;
  }
// -----------------------------------------------------------------------------
  static double superDialogWidth(BuildContext context){
    double _dialogWidth = superScreenWidth(context) * 0.8;
    return _dialogWidth;
  }
// -----------------------------------------------------------------------------

}