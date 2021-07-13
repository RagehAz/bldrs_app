import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
enum SlidingDirection{
  next,
  back,
  freeze,
}
// -----------------------------------------------------------------------------
class Sliders{
// -----------------------------------------------------------------------------
  static Future<int> slideToNextAndGetNewIndex(PageController slidingController, int numberOfSlides, int currentSlide) async {

    if (currentSlide+1 == numberOfSlides){
      print('Can not slide forward');
      return currentSlide;
    }

    else {
      await slidingController.animateToPage(currentSlide + 1,
          duration: Ratioz.duration400ms, curve: Curves.easeInOutCirc);

      return currentSlide + 1;
    }

  }
// -----------------------------------------------------------------------------
  /// this checks if its the first slide, it won't change index and won't slide, otherwise
  /// will slide back and return decreased index
  static Future<int> slideToBackAndGetNewIndex(PageController slidingController, int currentSlide) async {
  if (currentSlide == 0){
    print('can not slide back');
    return currentSlide;
  } else {
    await slidingController.animateToPage(currentSlide - 1,
        duration: Ratioz.duration400ms,
        curve: Curves.easeInOutCirc);

    return currentSlide - 1;
  }

}
// -----------------------------------------------------------------------------
  static Future<void> slideToNext(PageController slidingController, int numberOfSlides, int currentSlide) async {
  await slidingController.animateToPage(currentSlide + 1,
      duration: Ratioz.duration400ms, curve: Curves.easeInOutCirc);
}
// -----------------------------------------------------------------------------
  static Future<void> slideToBack(PageController slidingController, int currentSlide) async {
  if (currentSlide == 0){print('can not slide back');} else {
    await slidingController.animateToPage(currentSlide - 1,
        duration: Ratioz.duration400ms,
        curve: Curves.easeInOutCirc);

  }
}
// -----------------------------------------------------------------------------
  /// never used
//   static Future<void> snapToBack(PageController slidingController, int currentSlide) async {
//
//   if (currentSlide == 0){
//     print('can not slide back');
//   }
//
//   else {
//     await slidingController.jumpToPage(currentSlide - 1);
//   }
// }
// -----------------------------------------------------------------------------
  static Future<void> slideTo(PageController slidingController, int currentSlide,) async {

  if (slidingController.positions.length > 0 && slidingController.position.extentAfter == 0.0) {
    await slidingController.animateToPage(currentSlide,
        duration: Ratioz.duration400ms, curve: Curves.easeInOutCirc);
  }
}
// -----------------------------------------------------------------------------
  static Future<void> snapTo(PageController slidingController, int currentSlide) async {
  await slidingController.jumpToPage(currentSlide,);
}
// -----------------------------------------------------------------------------
  static SlidingDirection slidingDecision(int numberOfSlides, int currentSlide){
  SlidingDirection decision =
  numberOfSlides == 0 ? SlidingDirection.freeze :
  numberOfSlides == 1 ? SlidingDirection.freeze :
  numberOfSlides > 1 && currentSlide + 1 == numberOfSlides ? SlidingDirection.back :
  numberOfSlides > 1 && currentSlide == 0 ? SlidingDirection.next :
  SlidingDirection.back;
  return decision;
}
// -----------------------------------------------------------------------------
  static Future<void> slidingAction(PageController slidingController, int numberOfSlides, int currentSlide) async {
  // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before slidingAction');
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.next ? await slideToNext(slidingController, numberOfSlides, currentSlide) :
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.back ? await slideToBack(slidingController, currentSlide) :
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.freeze ? await slideTo(slidingController, currentSlide,)
        :
    print('no sliding possible ');
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingAction');
}
// -----------------------------------------------------------------------------
  static void zombie (int slideIndex){
  print('i wont fucking slide');
}
// -----------------------------------------------------------------------------
}
