import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
 void onHorizontalSlideSwipe({
   @required BuildContext context,
   @required int newIndex,
   @required ValueNotifier<int> currentSlideIndex,
   @required ValueNotifier<Sliders.SwipeDirection> swipeDirection,
}) {


  // blog('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
   final Sliders.SwipeDirection _direction = Animators.getSwipeDirection(
     newIndex: newIndex,
     oldIndex: currentSlideIndex.value,
   );

  /// A - if Keyboard is active
  if (Keyboarders.keyboardIsOn(context) == true) {
    blog('KEYBOARD IS ACTIVE');

    /// B - when direction is going next
    if (_direction == Sliders.SwipeDirection.next) {
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
    else if (_direction == Sliders.SwipeDirection.back) {
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
  @required ValueNotifier<Sliders.SwipeDirection> swipeDirection,
  @required Sliders.SwipeDirection newSwipeDirection,
}){

  currentSlideIndex.value = newIndex;
  swipeDirection.value = newSwipeDirection;

}
// -----------------------------------------------------------------------------
