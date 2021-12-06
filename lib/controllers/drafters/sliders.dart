import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
enum SwipeDirection{
  next,
  back,
  freeze,
}
// -----------------------------------------------------------------------------
  Future<int> slideToNextAndGetNewIndex(PageController slidingController, int numberOfSlides, int currentSlide) async {

    if (currentSlide+1 == numberOfSlides){
      print('Can not slide forward');
      return currentSlide;
    }

    else {
      await slidingController.animateToPage(currentSlide + 1,
          duration: Ratioz.durationSliding400, curve: Curves.easeInOutCirc);

      return currentSlide + 1;
    }

  }
// -----------------------------------------------------------------------------
  /// this checks if its the first slide, it won't change index and won't slide, otherwise
  /// will slide back and return decreased index
  Future<int> slideToBackAndGetNewIndex(PageController slidingController, int currentSlide) async {
  if (currentSlide == 0){
    print('can not slide back');
    return currentSlide;
  } else {
    await slidingController.animateToPage(currentSlide - 1,
        duration: Ratioz.durationSliding400,
        curve: Curves.easeInOutCirc);

    return currentSlide - 1;
  }

}
// -----------------------------------------------------------------------------
  Future<void> slideToNext(PageController slidingController, int numberOfSlides, int currentSlide) async {
  await slidingController.animateToPage(currentSlide + 1,
      duration: Ratioz.durationSliding400, curve: Curves.easeInOutCirc);
}
// -----------------------------------------------------------------------------
  Future<void> slideToBackFrom(PageController slidingController, int currentSlide, {Curve curve}) async {

    final Curve _curve = curve == null ? Curves.easeInOutCirc : curve;

  if (currentSlide == 0){
    print('can not slide back');
  } else {
    await slidingController.animateToPage(currentSlide - 1,
        duration: Ratioz.durationSliding400,
        curve: _curve,
    );

  }
}
// -----------------------------------------------------------------------------
  /// never used
//   Future<void> snapToBack(PageController slidingController, int currentSlide) async {
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
  Future<void> slideTo({
    PageController controller,
    int toIndex,
  }) async {

  // if (slidingController.positions.length > 0 && slidingController.position.extentAfter == 0.0) {
    await controller.animateToPage(toIndex,
        duration: Ratioz.duration1000ms, curve: Curves.easeInOutCirc);
  // }
}
// -----------------------------------------------------------------------------
  void snapTo(PageController slidingController, int currentSlide) {
  slidingController.jumpToPage(currentSlide,);
  // await null;
}
// -----------------------------------------------------------------------------
SwipeDirection slidingDecision(int numberOfSlides, int currentSlide){
  final SwipeDirection _decision =
  numberOfSlides == 0 ? SwipeDirection.freeze :
  numberOfSlides == 1 ? SwipeDirection.freeze :
  numberOfSlides > 1 && currentSlide + 1 == numberOfSlides ? SwipeDirection.back :
  numberOfSlides > 1 && currentSlide == 0 ? SwipeDirection.next :
  SwipeDirection.back;
  return _decision;
}
// -----------------------------------------------------------------------------
  Future<void> slidingAction(
      PageController slidingController,
      int numberOfSlides,
      int currentSlide
      ) async {
  // print('i: $currentSlide || #: $numberOfSlides || -> before slidingAction');
    slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.next ?
    await slideToNext(slidingController, numberOfSlides, currentSlide)
        :
    slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.back ?
    await slideToBackFrom(slidingController, currentSlide)
        :
    slidingDecision(numberOfSlides, currentSlide) == SwipeDirection.freeze ?
    await slideTo(controller: slidingController, toIndex: currentSlide)
        :
    print('no sliding possible ');
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingAction');
}
// -----------------------------------------------------------------------------
  void zombie (int slideIndex){
  print('i wont slide');
}
