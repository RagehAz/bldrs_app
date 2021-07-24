import 'package:bldrs/controllers/drafters/sliders.dart';
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
  // import 'dart:math' as math;
  // static double angleByDegree(double degree){
  //   double radian = degree * ( math.pi / 180 );
  //   return radian;
  // }
// -----------------------------------------------------------------------------
  static SwipeDirection getSwipeDirection({int oldIndex, int newIndex}){
    SwipeDirection _swipeDirection;
    if( newIndex > oldIndex ){
      _swipeDirection = SwipeDirection.next;
    }
    else if( newIndex < oldIndex)
      _swipeDirection = SwipeDirection.back;
    else {
      _swipeDirection = SwipeDirection.freeze;
    }

    // print('getSwipeDirection concluded going from [ old index ($oldIndex) ] to [ new index ($newIndex) ] is [$_swipeDirection]');
    return _swipeDirection;
  }
// -----------------------------------------------------------------------------
  static List<bool> createSlidesVisibilityList(int numberOfSlides){
    List<bool> _visibilityList = new List();

    for (int i = 0; i<numberOfSlides; i++){
      _visibilityList.add(true);
    }

    return _visibilityList;
  }
// -----------------------------------------------------------------------------
}