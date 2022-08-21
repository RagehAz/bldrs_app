import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';

class Animators {
// --------------------------------------------------------------------------

  const Animators();

// --------------------------------------------------------------------------

  /// SWIPE DIRECTION

// ----------------------------------
  static SwipeDirection getSwipeDirection({
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
// --------------------------------------------------------------------------

  /// PAGE CONTROLLERS

// ----------------------------------
  static void disposePageControllerIfPossible(PageController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
// -----------------------------------------------------------------------------
  static void disposeScrollControllerIfPossible(ScrollController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
// --------------------------------------------------------------------------

  /// Animation<double>

// ----------------------------------
  static Animation<double> animateDouble({
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
// --------------------------------------------------------------------------
}
