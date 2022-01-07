import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//   PageTransitionType superHorizontalTransition(BuildContext context){
//     return
//       appIsLeftToRight(context) ?
//       PageTransitionType.rightToLeft : PageTransitionType.leftToRight;
//
//   }
// -----------------------------------------------------------------------------
Sliders.SwipeDirection getSwipeDirection({int oldIndex, int newIndex}) {
  Sliders.SwipeDirection _swipeDirection;
  if (newIndex > oldIndex) {
    _swipeDirection = Sliders.SwipeDirection.next;
  } else if (newIndex < oldIndex) {
    _swipeDirection = Sliders.SwipeDirection.back;
  } else {
    _swipeDirection = Sliders.SwipeDirection.freeze;
  }

  // print('getSwipeDirection concluded going from [ old index ($oldIndex) ] to [ new index ($newIndex) ] is [$_swipeDirection]');
  return _swipeDirection;
}

// -----------------------------------------------------------------------------
//   List<bool> createSlidesVisibilityList(int numberOfSlides){
//     List<bool> _visibilityList = <bool>[];
//
//     for (int i = 0; i<numberOfSlides; i++){
//       _visibilityList.add(true);
//     }
//
//     return _visibilityList;
//   }
// -----------------------------------------------------------------------------
void disposePageControllerIfPossible(PageController controller) {
  if (controller != null) {
    controller.dispose();
  }
}

// -----------------------------------------------------------------------------
void disposeScrollControllerIfPossible(ScrollController controller) {
  if (controller != null) {
    controller.dispose();
  }
}
// -----------------------------------------------------------------------------
