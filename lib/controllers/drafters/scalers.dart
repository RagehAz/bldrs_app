import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

import 'text_directionerz.dart';

class Scale{
// -----------------------------------------------------------------------------
  static double superScreenWidth (BuildContext context){
    double _screenWidth = MediaQuery.of(context).size.width;
    return _screenWidth;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeight (BuildContext context){
    double _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight;
  }
// -----------------------------------------------------------------------------
  static double superFlyerZoneWidth (BuildContext context, double flyerSizeFactor){
    double _screenWidth = superScreenWidth(context);
    double _flyerZoneWidth = _screenWidth * flyerSizeFactor;
    return _flyerZoneWidth;
  }
// -----------------------------------------------------------------------------
  static double superSafeAreaTopPadding (BuildContext context){
    double _safeAreaHeight = MediaQuery.of(context).padding.top;
    return _safeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeightWithoutSafeArea (BuildContext context){
    double _screenWithoutSafeAreaHeight = superScreenHeight(context) - superSafeAreaTopPadding(context);
    return _screenWithoutSafeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superFlyerSizeFactorByWidth (BuildContext context, double flyerZoneWidth){
    double _flyerSizeFactor = flyerZoneWidth/superScreenWidth(context);
    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double superFlyerSizeFactorByHeight (BuildContext context, double flyerZoneHeight){

    double _flyerZoneWidth = flyerZoneHeight == superScreenHeightWithoutSafeArea(context) ? superScreenWidth(context) : (flyerZoneHeight / Ratioz.xxflyerZoneHeight);

    double _flyerSizeFactor = superFlyerSizeFactorByWidth(context, _flyerZoneWidth);

    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double superFlyerZoneHeight (BuildContext context, double flyerZoneWidth){
    double _flyerZoneHeight = superFlyerSizeFactorByWidth(context, flyerZoneWidth) == 1 ?
    superScreenHeightWithoutSafeArea(context)
        :
    flyerZoneWidth * Ratioz.xxflyerZoneHeight;
    return _flyerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static bool superFlyerMicroMode (BuildContext context, double flyerZoneWidth){
    bool _microMode = flyerZoneWidth < (superScreenWidth(context) * 0.4) ? true : false; // 0.4 needs calibration
    return _microMode;
  }
// -----------------------------------------------------------------------------
  static bool superFlyerMiniMode (BuildContext context, double flyerZoneWidth){
    bool _miniMode = flyerZoneWidth < (superScreenWidth(context) * 0.70) ? true : false; // 0.4 needs calibration
    return _miniMode;
  }
// -----------------------------------------------------------------------------
  static double superHeaderHeight(bool bzPageIsOn, double flyerZoneWidth){
    double _miniHeaderHeightAtMaxState = flyerZoneWidth * Ratioz.xxflyerHeaderMaxHeight;
    double _miniHeaderHeightAtMiniState = flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
    double _headerHeight = bzPageIsOn == true ? _miniHeaderHeightAtMaxState : _miniHeaderHeightAtMiniState;
    return _headerHeight;
  }
// -----------------------------------------------------------------------------
  static double superHeaderStripHeight(bool bzPageIsOn, double flyerZoneWidth){
    double _headerStripHeight = bzPageIsOn == true ? flyerZoneWidth : flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _headerStripHeight;
  }
// -----------------------------------------------------------------------------
  static double superHeaderOffsetHeight(double flyerZoneWidth){
    double _headerOffsetHeight = (flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight) - (2 * flyerZoneWidth * Ratioz.xxfollowCallSpacing);
    return _headerOffsetHeight;
  }
// -----------------------------------------------------------------------------
  static double superLogoWidth(bool bzPageIsOn, double flyerZoneWidth ){
    double _headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double _headerOffsetWidth = flyerZoneWidth - (2 * _headerMainPadding);
    double _logoWidth = bzPageIsOn == true ? _headerOffsetWidth : (flyerZoneWidth*Ratioz.xxflyerLogoWidth);
    return _logoWidth;
  }
// -----------------------------------------------------------------------------
  static double superDeviceRatio(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _deviceRatio = _size.aspectRatio;
    return _deviceRatio;
  }
// -----------------------------------------------------------------------------
  static double superBubbleClearWidth(BuildContext context){
    double _bubbleWidth = superBubbleWidth(context);
    double _bubblePaddings = Ratioz.appBarMargin * 2;
    double _inBubbleClearWidth = _bubbleWidth - _bubblePaddings;
    return _inBubbleClearWidth;
  }
// -----------------------------------------------------------------------------
  static double superBubbleWidth(BuildContext context){
    double _screenWidth = superScreenWidth(context);
    double _bubbleMargins = Ratioz.appBarMargin * 2;
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
  static double appBarScrollWidth(BuildContext context){
    double _appBarScrollWidth = superScreenWidth(context) - (Ratioz.appBarMargin * 2) - (Ratioz.appBarPadding * 2) - Ratioz.appBarButtonSize - Ratioz.appBarPadding;
    return _appBarScrollWidth;
  }
// -----------------------------------------------------------------------------
  static double appBarClearWidth(BuildContext context){
    double _abWidth = superScreenWidth(context) - (2 * Ratioz.appBarMargin);
    return _abWidth;
  }
// -----------------------------------------------------------------------------
  static double appBarClearHeight(BuildContext context, AppBarType appBarType){
    double _abHeight = appBarType == AppBarType.Search ? Ratioz.appBarBigHeight : Ratioz.appBarSmallHeight;
    return _abHeight;
  }
// -----------------------------------------------------------------------------
}