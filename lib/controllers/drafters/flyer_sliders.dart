import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------
void slideToNext(PageController slidingController, int numberOfSlides, int currentSlide){
  slidingController.animateToPage(currentSlide + 1,
      duration: Ratioz.slidingDuration, curve: Curves.easeInOutCirc);
}
// ----------------------------------------------------------------------
void slideToBack(PageController slidingController, int currentSlide){
  if (currentSlide == 0){print('can not slide back');} else {
    slidingController.animateToPage(currentSlide - 1,
        duration: Ratioz.slidingDuration,
        curve: Curves.easeInOutCirc);

  }
}
// ----------------------------------------------------------------------
void snapToBack(PageController slidingController, int currentSlide){
  if (currentSlide == 0){print('can not slide back');} else {
    slidingController.jumpToPage(currentSlide - 1);
  }
}
// ----------------------------------------------------------------------
void slideTo(PageController slidingController, int currentSlide){
  slidingController.animateToPage(currentSlide,
      duration: Ratioz.slidingDuration, curve: Curves.easeInOutCirc);
}
// ----------------------------------------------------------------------
void snapTo(PageController slidingController, int currentSlide){
  slidingController.jumpToPage(currentSlide,);
}
// ----------------------------------------------------------------------
enum SlidingDirection{
  next,
  back,
  freeze,
}
// ----------------------------------------------------------------------
SlidingDirection slidingDecision(int numberOfSlides, int currentSlide){
  SlidingDirection decision =
  numberOfSlides == 0 ? SlidingDirection.freeze :
  numberOfSlides == 1 ? SlidingDirection.freeze :
  numberOfSlides > 1 && currentSlide + 1 == numberOfSlides ? SlidingDirection.back :
  numberOfSlides > 1 && currentSlide == 0 ? SlidingDirection.next :
  SlidingDirection.back;
  return decision;
}
// ----------------------------------------------------------------------
void slidingAction(PageController slidingController, int numberOfSlides, int currentSlide) {
  // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before slidingAction');
  slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.next ? slideToNext(slidingController, numberOfSlides, currentSlide) :
  slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.back ? slideToBack(slidingController, currentSlide) :
  slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.freeze ? slideTo(slidingController, currentSlide) :
  print('no sliding possible ');
  // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingAction');
}
// ----------------------------------------------------------------------
void zombie (int slideIndex){
  print('i wont fucking slide');
}
// ----------------------------------------------------------------------
