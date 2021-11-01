import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

abstract class Scale{
// -----------------------------------------------------------------------------
  static double superScreenWidth (BuildContext context){
    final double _screenWidth = MediaQuery.of(context).size.width;
    return _screenWidth;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeight (BuildContext context){
    final double _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight;
  }
// -----------------------------------------------------------------------------
  static double superSafeAreaTopPadding (BuildContext context){
    final double _safeAreaHeight = MediaQuery.of(context).padding.top;
    return _safeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeightWithoutSafeArea (BuildContext context){
    final double _screenWithoutSafeAreaHeight = superScreenHeight(context) - superSafeAreaTopPadding(context);
    return _screenWithoutSafeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superDeviceRatio(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _deviceRatio = _size.aspectRatio;
    return _deviceRatio;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets superInsets(BuildContext context,{double enBottom, double enLeft, double enRight, double enTop}){

    final double _enBottom = enBottom ?? 0;
    final double _enLeft = enLeft ?? 0;
    final double _enRight = enRight ?? 0;
    final double _enTop = enTop ?? 0;

    return
      appIsLeftToRight(context) ?
      EdgeInsets.only(bottom: _enBottom, left: _enLeft, right: _enRight, top: _enTop)
          :
      EdgeInsets.only(bottom: _enBottom, left: _enRight, right: _enLeft, top: _enTop);
  }
// -----------------------------------------------------------------------------
  static EdgeInsets superMargins({dynamic margins}){
    final EdgeInsets _boxMargins =
    margins == null || margins == 0 ? const EdgeInsets.all(0)
        :
    margins.runtimeType == double ? EdgeInsets.all(margins)
        :
    margins.runtimeType == int ? EdgeInsets.all(margins.toDouble())
        :
    margins.runtimeType == EdgeInsets ? margins
        :
    margins;
    return _boxMargins;
  }
// -----------------------------------------------------------------------------
  /// this concludes item width after dividing screen width over number of items
  /// while considering 10 pixels spacing between them
  static double getUniformRowItemWidth(BuildContext context, int numberOfItems){
    final double _screenWidth = superScreenWidth(context);
    final double _width = (_screenWidth - (Ratioz.appBarMargin * (numberOfItems + 1))) / numberOfItems;
    return _width;
  }
// -----------------------------------------------------------------------------
}