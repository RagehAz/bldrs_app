import 'dart:math' as math;
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class Animators{
// -----------------------------------------------------------------------------
  static PageTransitionType superHorizontalTransition(BuildContext context){
    return
      appIsLeftToRight(context) ?
      PageTransitionType.rightToLeft : PageTransitionType.leftToRight;

  }
// -----------------------------------------------------------------------------
  /// remember that dart starts from angle 0 on the right,, rotates clockWise when
  /// incrementing the angle degree,, while rotates counter clockwise when decrementing
  /// the angle degree.
  /// simply, Negative value goes counter ClockWise
  double angleByDegree(double degree){
    double radian = degree * ( math.pi / 180 );
    return radian;
  }
// -----------------------------------------------------------------------------
  static bool slidingNext({int currentIndex, int newIndex}){
    bool _slidingNext;
    if( newIndex > currentIndex ){
      _slidingNext = true;
    } else {
      _slidingNext = false;
    }

    return _slidingNext;
  }
// -----------------------------------------------------------------------------
}