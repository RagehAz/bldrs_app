import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:flutter/material.dart';

class Aligners {
  // -----------------------------------------------------------------------------

  const Aligners();

  // -----------------------------------------------------------------------------
  static Alignment superTopAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.topLeft
        :
    Alignment.topRight;
  }
  // -----------------------------------------------------------------------------
  static Alignment superBottomAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.bottomLeft
        :
    Alignment.bottomRight;
  }
  // -----------------------------------------------------------------------------
  static Alignment superCenterAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.centerLeft
        :
    Alignment.centerRight;
  }
  // -----------------------------------------------------------------------------
  static Alignment superInverseCenterAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.centerRight
        :
    Alignment.centerLeft;
  }
  // -----------------------------------------------------------------------------
  static Alignment superInverseTopAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.topRight
        :
    Alignment.topLeft;
  }
  // -----------------------------------------------------------------------------
  static Alignment superInverseBottomAlignment(BuildContext context) {
    return TextDir.appIsLeftToRight(context) ?
    Alignment.bottomRight
        :
    Alignment.bottomLeft;
  }
  // -----------------------------------------------------------------------------
  /// gets [right position] of object that [aligns left] when app is english (LTR)
  static double rightPositionInLeftAlignmentEn(BuildContext context, double offsetFromRight) {
    double _rightOffset;

    /// when in English
    if (TextDir.appIsLeftToRight(context) == true) {
      /// right offset position should be programmatic
      _rightOffset = null;
    }

    /// when in Arabic
    else {
      /// right offset position should have the offset value
      _rightOffset = offsetFromRight;
    }

    return _rightOffset;
  }
  // -----------------------------------------------------------------------------
  /// gets [left position] of object that [aligns left] when app is english (LTR)
  static double leftPositionInLeftAlignmentEn(BuildContext context, double offsetFromLeft) {
    double _leftOffset;

    /// when in English
    if (TextDir.appIsLeftToRight(context) == true) {
      /// left offset position should have the offset value
      _leftOffset = offsetFromLeft;
    }

    /// when in Arabic
    else {
      /// left offset position should be programmatic
      _leftOffset = null;
    }

    return _leftOffset;
  }
  // -----------------------------------------------------------------------------
  /// gets [right position] of object that [aligns right] when app is english (LTR)
  static double rightPositionInRightAlignmentEn(BuildContext context, double offsetFromRight) {
    return leftPositionInLeftAlignmentEn(context, offsetFromRight);
  }
  // -----------------------------------------------------------------------------
  /// gets [left position] of object that [aligns right] when app is english (LTR)
  static double leftPositionInRightAlignmentEn(BuildContext context, double offsetFromLeft) {
    return rightPositionInLeftAlignmentEn(context, offsetFromLeft);
  }
  // -----------------------------------------------------------------------------
}
