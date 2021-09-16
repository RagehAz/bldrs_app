import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:flutter/material.dart';

class Aligners{
// -----------------------------------------------------------------------------
  static Alignment superTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topLeft : Alignment.topRight;
  }
// -----------------------------------------------------------------------------
  static Alignment superBottomAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.bottomLeft : Alignment.bottomRight;
  }
// -----------------------------------------------------------------------------
  static Alignment superCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerLeft : Alignment.centerRight;
  }
// -----------------------------------------------------------------------------
  static Alignment superInverseCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerRight : Alignment.centerLeft;
  }
// -----------------------------------------------------------------------------
  static Alignment superInverseTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topRight : Alignment.topLeft;
  }
// -----------------------------------------------------------------------------
  static Alignment superInverseBottomAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.bottomRight : Alignment.bottomLeft;
  }
// -----------------------------------------------------------------------------
  /// gets [right position] of object that [aligns left] when app is english (LTR)
  static double rightPositionInLeftAlignmentEn(BuildContext context, double offsetFromRight){
    double _rightOffset;

    /// when in English
    if(appIsLeftToRight(context) == true){
      /// right offset position should be programmatic
      _rightOffset = null;
    }
    /// when in Arabic
    else {
      /// right offset position should have the offset value
      _rightOffset = offsetFromRight;
    }

    return
      _rightOffset;
  }
// -----------------------------------------------------------------------------
  /// gets [left position] of object that [aligns left] when app is english (LTR)
  static double leftPositionInLeftAlignmentEn(BuildContext context, double offsetFromLeft){
    double _leftOffset;

    /// when in English
    if(appIsLeftToRight(context) == true){
      /// left offset position should have the offset value
      _leftOffset = offsetFromLeft;
    }
    /// when in Arabic
    else {
      /// left offset position should be programmatic
      _leftOffset = null;
    }

    return
      _leftOffset;
  }
// -----------------------------------------------------------------------------
  /// gets [right position] of object that [aligns right] when app is english (LTR)
  static double rightPositionInRightAlignmentEn(BuildContext context, double offsetFromRight){

    double _leftOffset = leftPositionInLeftAlignmentEn(context, offsetFromRight);

    return
      _leftOffset;
  }
// -----------------------------------------------------------------------------
  /// gets [left position] of object that [aligns right] when app is english (LTR)
  static double leftPositionInRightAlignmentEn(BuildContext context, double offsetFromLeft){

    double _leftOffset = rightPositionInLeftAlignmentEn(context, offsetFromLeft);

    return
      _leftOffset;
  }
// -----------------------------------------------------------------------------
}