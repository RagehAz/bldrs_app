import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class Scale {
// -----------------------------------------------------------------------------

  const Scale();

// -----------------------------------------------------------------------------

  /// SIZES

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double superScreenWidth(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return _screenWidth;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double superScreenHeight(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double superScreenHeightWithoutSafeArea(BuildContext context) {

    final double _screenWithoutSafeAreaHeight =
        superScreenHeight(context)
            -
            superSafeAreaTopPadding(context);


    return _screenWithoutSafeAreaHeight;
  }
// -----------------------------------------------------------------

  /// PADDING

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double superSafeAreaTopPadding(BuildContext context) {
    final double _safeAreaHeight = MediaQuery.of(context).padding.top;
    return _safeAreaHeight;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superInsets({
    @required BuildContext context,
    double bottom = 0,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
  }) {

    return TextDir.appIsLeftToRight(context) ?
    EdgeInsets.only(
        bottom: bottom,
        left: enLeft,
        right: enRight,
        top: top
    )
        :
    EdgeInsets.only(
        bottom: bottom,
        left: enRight,
        right: enLeft,
        top: top
    );
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superPadding({
    @required BuildContext context,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return TextDir.appIsLeftToRight(context) ?
    EdgeInsets.only(
        left: enLeft,
        right: enRight,
        top: top,
        bottom: bottom
    )
        :
    EdgeInsets.only(
      left: enRight,
      right: enLeft,
      top: top,
      bottom: bottom,
    );
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superMargins({dynamic margins}) {
    final EdgeInsets _boxMargins = margins == null || margins == 0 ? EdgeInsets.zero
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
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double superDeviceRatio(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _deviceRatio = _size.aspectRatio;
    return _deviceRatio;
  }
// -----------------------------------------------------------------

  /// DIVISION

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static double getUniformRowItemWidth({
    @required BuildContext context,
    @required int numberOfItems,
    double boxWidth,
  }) {

    /// this concludes item width after dividing screen width over number of items
    /// while considering 10 pixels spacing between them

    final double _screenWidth = boxWidth ?? superScreenWidth(context);
    final double _width = (_screenWidth - (Ratioz.appBarMargin * (numberOfItems + 1))) / numberOfItems;
    return _width;
  }
// -----------------------------------------------------------------------------
}
