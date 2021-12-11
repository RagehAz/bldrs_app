import 'package:bldrs/helpers/drafters/text_directionerz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
  Alignment superTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topLeft : Alignment.topRight;
  }
// -----------------------------------------------------------------------------
  Alignment superBottomAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.bottomLeft : Alignment.bottomRight;
  }
// -----------------------------------------------------------------------------
  Alignment superCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerLeft : Alignment.centerRight;
  }
// -----------------------------------------------------------------------------
  Alignment superInverseCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerRight : Alignment.centerLeft;
  }
// -----------------------------------------------------------------------------
  Alignment superInverseTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topRight : Alignment.topLeft;
  }
// -----------------------------------------------------------------------------
  Alignment superInverseBottomAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.bottomRight : Alignment.bottomLeft;
  }
// -----------------------------------------------------------------------------
  /// gets [right position] of object that [aligns left] when app is english (LTR)
  double rightPositionInLeftAlignmentEn(BuildContext context, double offsetFromRight){
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
  double leftPositionInLeftAlignmentEn(BuildContext context, double offsetFromLeft){
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
  double rightPositionInRightAlignmentEn(BuildContext context, double offsetFromRight){

    return
      leftPositionInLeftAlignmentEn(context, offsetFromRight);
  }
// -----------------------------------------------------------------------------
  /// gets [left position] of object that [aligns right] when app is english (LTR)
  double leftPositionInRightAlignmentEn(BuildContext context, double offsetFromLeft){

    return
      rightPositionInLeftAlignmentEn(context, offsetFromLeft);
  }
// -----------------------------------------------------------------------------
