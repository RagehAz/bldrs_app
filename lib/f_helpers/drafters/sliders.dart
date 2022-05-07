import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
enum SwipeDirection {
  next,
  back,
  freeze,
}
// -----------------------------------------------------------------------------
Future<int> slideToNextAndGetNewIndex({
    @required PageController slidingController,
    @required int numberOfSlides,
    @required int currentSlide,
}) async {

  if (currentSlide + 1 == numberOfSlides) {
    blog('Can not slide forward');
    return currentSlide;
  }
  else {

    await slidingController.animateToPage(currentSlide + 1,
        duration: Ratioz.durationFading200,
        curve: Curves.easeInOutCirc
    );

    return currentSlide + 1;
  }
}
// -----------------------------------------------------------------------------
/// this checks if its the first slide, it won't change index and won't slide, otherwise
/// will slide back and return decreased index
Future<int> slideToBackAndGetNewIndex({
    @required PageController pageController,
    @required int currentSlide
}) async {

  if (currentSlide == 0) {
    blog('can not slide back');
    return currentSlide;
  } else {

    await pageController.animateToPage(currentSlide - 1,
        duration: Ratioz.durationFading200,
        curve: Curves.easeInOutCirc
    );

    return currentSlide - 1;
  }
}
// -----------------------------------------------------------------------------
Future<void> slideToNext({
  @required PageController pageController,
  @required int numberOfSlides,
  @required int currentSlide,
}) async {

  await pageController.animateToPage(currentSlide + 1,
      duration: Ratioz.durationSliding400,
      curve: Curves.easeInOutCirc,
  );

}
// -----------------------------------------------------------------------------
Future<void> slideToBackFrom({
  @required PageController pageController,
  @required int currentSlide,
  Curve curve = Curves.easeInOutCirc,
}) async {

  if (currentSlide == 0) {
    blog('can not slide back');
  }

  else {
    await pageController.animateToPage(
      currentSlide - 1,
      duration: Ratioz.durationSliding400,
      curve: curve,
    );
  }

}
// -----------------------------------------------------------------------------
/// never used
//   Future<void> snapToBack(PageController slidingController, int currentSlide) async {
//
//   if (currentSlide == 0){
//     blog('can not slide back');
//   }
//
//   else {
//     await slidingController.jumpToPage(currentSlide - 1);
//   }
// }
// -----------------------------------------------------------------------------
Future<void> slideTo({
  @required PageController controller,
  @required int toIndex,
}) async {

  // if (slidingController.positions.length > 0 && slidingController.position.extentAfter == 0.0) {
  await controller.animateToPage(toIndex,
      duration: Ratioz.duration1000ms, curve: Curves.easeInOutCirc);
  // }

}
// -----------------------------------------------------------------------------
void snapTo({
  @required PageController pageController,
  @required int currentSlide
}) {

  pageController.jumpToPage(
    currentSlide,
  );

}
// -----------------------------------------------------------------------------
SwipeDirection slidingDecision(int numberOfSlides, int currentSlide) {

  final SwipeDirection _decision =
  numberOfSlides == 0 ? SwipeDirection.freeze
      :
  numberOfSlides == 1 ? SwipeDirection.freeze
      :
  numberOfSlides > 1 && currentSlide + 1 == numberOfSlides ? SwipeDirection.back
      :
  numberOfSlides > 1 && currentSlide == 0 ? SwipeDirection.next
      :
  SwipeDirection.back;
  return _decision;

}
// -----------------------------------------------------------------------------
Future<void> slidingAction({
  @required PageController slidingController,
  @required int numberOfSlides,
  @required int currentSlide,
}) async {

  // blog('i: $currentSlide || #: $numberOfSlides || -> before slidingAction');

  slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.next ?
  await slideToNext(
      pageController: slidingController,
      numberOfSlides: numberOfSlides,
      currentSlide: currentSlide
  )
      :
  slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.back ?
  await slideToBackFrom(
      pageController: slidingController,
      currentSlide: currentSlide
  )
      :
  slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.freeze ?
  await slideTo(
      controller: slidingController,
      toIndex: currentSlide
  )
      :
  blog('no sliding possible ');

  // blog('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingAction');

}
// -----------------------------------------------------------------------------
void zombie(int slideIndex) {
  blog('i wont slide');
}
// -----------------------------------------------------------------------------
