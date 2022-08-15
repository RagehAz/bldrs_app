import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
 void onHorizontalSlideSwipe({
   @required BuildContext context,
   @required int newIndex,
   @required ValueNotifier<ProgressBarModel> progressBarModel,
}) {

  // blog('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
   final SwipeDirection _direction = Animators.getSwipeDirection(
     newIndex: newIndex,
     oldIndex: progressBarModel.value.index,
   );

  /// A - if Keyboard is active
  if (Keyboard.keyboardIsOn(context) == true) {
    blog('KEYBOARD IS ACTIVE');

    /// B - when direction is going next
    if (_direction == SwipeDirection.next) {
      blog('going next');
      FocusScope.of(context).nextFocus();

      _setSwipeDirectionAndCurrentIndex(
        progressBarModel: progressBarModel,
        newSwipeDirection: _direction,
        newIndex: newIndex,
      );

    }

    /// B - when direction is going back
    else if (_direction == SwipeDirection.back) {
      blog('going back');
      FocusScope.of(context).previousFocus();
      _setSwipeDirectionAndCurrentIndex(
          progressBarModel: progressBarModel,
          newSwipeDirection: _direction,
          newIndex: newIndex,
      );
    }

    /// B = when direction is freezing
    else {
      blog('going no where');
      _setSwipeDirectionAndCurrentIndex(
          progressBarModel: progressBarModel,
          newSwipeDirection: _direction,
          newIndex: newIndex,
      );
    }
  }

  /// A - if keyboard is not active
  else {
    // blog('KEYBOARD IS NOT ACTIVE');
    _setSwipeDirectionAndCurrentIndex(
        progressBarModel: progressBarModel,
        newSwipeDirection: _direction,
        newIndex: newIndex,
    );
  }
}
// -----------------------------------------------------------------------------
void _setSwipeDirectionAndCurrentIndex({
  @required ValueNotifier<ProgressBarModel> progressBarModel,
  @required int newIndex,
  @required SwipeDirection newSwipeDirection,
}){

  progressBarModel.value = progressBarModel.value.copyWith(
      swipeDirection: newSwipeDirection,
      index: newIndex,
  );

}
// -----------------------------------------------------------------------------
