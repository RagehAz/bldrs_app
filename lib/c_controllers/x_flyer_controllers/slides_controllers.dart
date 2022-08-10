import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
 void onHorizontalSlideSwipe({
   @required BuildContext context,
   @required int newIndex,
   @required ValueNotifier<int> currentSlideIndex,
   @required ValueNotifier<SwipeDirection> swipeDirection,
}) {


  // blog('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
   final SwipeDirection _direction = Animators.getSwipeDirection(
     newIndex: newIndex,
     oldIndex: currentSlideIndex.value,
   );

  /// A - if Keyboard is active
  if (Keyboard.keyboardIsOn(context) == true) {
    blog('KEYBOARD IS ACTIVE');

    /// B - when direction is going next
    if (_direction == SwipeDirection.next) {
      blog('going next');
      FocusScope.of(context).nextFocus();

      _setSwipeDirectionAndCurrentIndex(
        newSwipeDirection: _direction,
        swipeDirection: swipeDirection,
        currentSlideIndex: currentSlideIndex,
        newIndex: newIndex,
        notify: true
      );

    }

    /// B - when direction is going back
    else if (_direction == SwipeDirection.back) {
      blog('going back');
      FocusScope.of(context).previousFocus();
      _setSwipeDirectionAndCurrentIndex(
          newSwipeDirection: _direction,
          swipeDirection: swipeDirection,
          currentSlideIndex: currentSlideIndex,
          newIndex: newIndex,
          notify: true
      );
    }

    /// B = when direction is freezing
    else {
      blog('going no where');
      _setSwipeDirectionAndCurrentIndex(
          newSwipeDirection: _direction,
          swipeDirection: swipeDirection,
          currentSlideIndex: currentSlideIndex,
          newIndex: newIndex,
          notify: true
      );
    }
  }

  /// A - if keyboard is not active
  else {
    // blog('KEYBOARD IS NOT ACTIVE');
    _setSwipeDirectionAndCurrentIndex(
        newSwipeDirection: _direction,
        swipeDirection: swipeDirection,
        currentSlideIndex: currentSlideIndex,
        newIndex: newIndex,
        notify: true
    );
  }
}
// -----------------------------------------------------------------------------
void _setSwipeDirectionAndCurrentIndex({
  @required ValueNotifier<int> currentSlideIndex,
  @required int newIndex,
  @required bool notify,
  @required ValueNotifier<SwipeDirection> swipeDirection,
  @required SwipeDirection newSwipeDirection,
}){

  currentSlideIndex.value = newIndex;
  swipeDirection.value = newSwipeDirection;

}
// -----------------------------------------------------------------------------
