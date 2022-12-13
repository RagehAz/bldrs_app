import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// VARS OPTIMIZED
class Scale {
  // -----------------------------------------------------------------------------

  const Scale();

  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superScreenHeightWithoutSafeArea(BuildContext context) {
    return screenHeight(context) - superSafeAreaTopPadding(context);
  }
  // -----------------------------------------------------------------------------

  /// PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double superSafeAreaTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superInsets({ // clean all trances to become constants
    @required BuildContext context,
    double bottom = 0,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
  }) {

    if (TextDir.checkAppIsLeftToRight(context) == true){
      return EdgeInsets.only(
          left: enLeft,
          right: enRight,
          bottom: bottom,
          top: top
      );
    }

    else {
      return EdgeInsets.only(
          bottom: bottom,
          left: enRight,
          right: enLeft,
          top: top
      );
    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static EdgeInsets superPadding({
    @required BuildContext context,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
    double bottom = 0,
  }) {

    if (TextDir.checkAppIsLeftToRight(context) == true){
      return EdgeInsets.only(
          left: enLeft,
          right: enRight,
          bottom: bottom,
          top: top,
      );
    }

    else {
      return EdgeInsets.only(
          left: enRight,
          right: enLeft,
          top: top,
          bottom: bottom,
      );
    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superMargins({dynamic margin}) {

    if (margin == null || margin == 0){
      return EdgeInsets.zero;
    }

    else if (margin.runtimeType == double){
      return EdgeInsets.all(margin);
    }

    else if (margin.runtimeType == int){
      return EdgeInsets.all(margin.toDouble());
    }

    else if (margin.runtimeType == EdgeInsets){
      return margin;
    }

    else {
      return margin;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superDeviceRatio(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio;
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const EdgeInsets constantMarginsAll5 = EdgeInsets.all(5);
  static const EdgeInsets constantMarginsAll10 = EdgeInsets.all(10);
  static const EdgeInsets constantMarginsAll20 = EdgeInsets.all(20);

  static const EdgeInsets constantHorizontal5 = EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding);
  static const EdgeInsets constantHorizontal10 = EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin);
  // -----------------------------------------------------------------------------

  /// DIVISION

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getUniformRowItemWidth({
    @required BuildContext context,
    @required int numberOfItems,
    @required double boxWidth,
    double spacing = Ratioz.appBarMargin,
  }) {

    /// this concludes item width after dividing screen width over number of items
    /// while considering 10 pixels spacing between them

    double _width = 0;

    if (numberOfItems != null && boxWidth != null){
      _width = (boxWidth - (spacing * (numberOfItems + 1))) / numberOfItems;
    }

    return _width;
  }
  // -----------------------------------------------------------------------------
}
