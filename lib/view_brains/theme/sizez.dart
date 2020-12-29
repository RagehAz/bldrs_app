import 'package:flutter/material.dart';

class Sizez {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVerticalWithAppBar;
  static double safeBlockVerticalWithoutAppBar;
  static double allAppHaveAppBar;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    // you need to divide by 100 to use -> (safeBlockVerticalWithAppBar/100)
    safeBlockVerticalWithAppBar =
    (screenHeight - safeAreaVertical - AppBar().preferredSize.height)/100;
    safeBlockVerticalWithoutAppBar =
    (screenHeight - safeAreaVertical)/100;
    // if all app have appbar this below can be used
    allAppHaveAppBar = (screenHeight - safeAreaVertical - AppBar().preferredSize.height)/100;
  }
}