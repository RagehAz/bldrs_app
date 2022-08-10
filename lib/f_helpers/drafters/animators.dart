import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//   PageTransitionType superHorizontalTransition(BuildContext context){
//     return
//       appIsLeftToRight(context) ?
//       PageTransitionType.rightToLeft : PageTransitionType.leftToRight;
//
//   }
// -----------------------------------------------------------------------------
SwipeDirection getSwipeDirection({
  @required int oldIndex,
  @required int newIndex
}) {
  SwipeDirection _swipeDirection;

  if (newIndex > oldIndex) {
    _swipeDirection = SwipeDirection.next;
  }

  else if (newIndex < oldIndex) {
    _swipeDirection = SwipeDirection.back;
  }

  else {
    _swipeDirection = SwipeDirection.freeze;
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
Animation<double> animateDouble({
  @required double begin,
  @required double end,
  @required AnimationController controller
}) {
  return Tween<double>(
    begin: begin,
    end: end,
  ).animate(controller);

  /// can do stuff here
  //   ..addListener(() {
  //   // setState(() {
  //   //
  //   // });
  // })
  //   ..addStatusListener((status) {
  //     // if (status == AnimationStatus.completed) {
  //     //   _controller.reverse();
  //     // } else if (status == AnimationStatus.dismissed) {
  //     //   _controller.forward();
  //     // }
  //   })

}
