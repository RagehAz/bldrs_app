import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/flyer_methods.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class Slides extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  const Slides({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
  });
// -----------------------------------------------------------------------------
  void _onSingleSlideTap(BuildContext context){

    bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);

    if (Keyboarders.keyboardIsOn(context)){
      Keyboarders.closeKeyboard(context);
    }

    if (_tinyMode == true){
      superFlyer.nav.onTinyFlyerTap();
    }

    else {
      print(' tapping slides new while tinyMode is false baby');
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: superFlyer.nav.horizontalController,
      physics: const BouncingScrollPhysics(),
      pageSnapping: true,
      allowImplicitScrolling: false,
      clipBehavior: Clip.antiAlias,
      restorationId: '${superFlyer.key.value}',
      onPageChanged: superFlyer.nav.listenToSwipe ? (i) => superFlyer.nav.onHorizontalSlideSwipe(i) : (i) => Sliders.zombie(i),
      children: <Widget>[

        ...List.generate(superFlyer.numberOfSlides, (i){

          BoxFit _currentPicFit = FlyerMethod.getCurrentBoxFitFromSuperFlyer(superFlyer: superFlyer);
          // ------------------------------------------------------o
          dynamic _slidePic = superFlyer.edit.editMode == true || superFlyer.mSlides[i].picURL == null?
          superFlyer.mSlides[i].picFile
              :
          superFlyer.mSlides[i].picURL;
          // ------------------------------------------------------o
          String _slideTitle = superFlyer.edit.editMode == true ?
          superFlyer.mSlides[i].headlineController.text
              :
          superFlyer.mSlides[i].headline ;
          // ------------------------------------------------------o
          return
            superFlyer.mSlides.length == 0 ? Container() :
            AnimatedOpacity(
              // key: ObjectKey('${superFlyer.key.value}${i}'),
              opacity: superFlyer.mSlides[i].opacity,
              duration: Ratioz.durationFading200,
              child: Stack(
                children: <Widget>[

                  SingleSlide(
                    superFlyer: superFlyer,
                    flyerZoneWidth: flyerZoneWidth,
                    slideIndex: i,
                    // key: ObjectKey('${superFlyer.key.value}${i}'),
                    flyerID: superFlyer.flyerID, //_flyer.flyerID,
                    picture: _slidePic,
                    // slideMode: superFlyer.editMode ? SlideMode.Editor : SlideMode.View,//slidesModes[index],
                    boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                    titleController: superFlyer.edit.editMode == true ? superFlyer.mSlides[i].headlineController : null,
                    title: _slideTitle,
                    imageSize: superFlyer.mSlides[i].imageSize,
                    slideColor: superFlyer.mSlides[i].midColor,
                    views: superFlyer.mSlides[i].viewsCount,
                    saves: superFlyer.mSlides[i].savesCount,
                    shares: superFlyer.mSlides[i].sharesCount,
                    textFieldOnChanged: (text){
                      print('text is : $text');
                    },
                    onTap: () => _onSingleSlideTap(context),
                  ),

                  if (superFlyer.edit.editMode != true)
                    FlyerFooter(
                      flyerZoneWidth: flyerZoneWidth,
                      saves: superFlyer.edit.firstTimer == true ? 0 : superFlyer.mSlides[superFlyer.currentSlideIndex].savesCount,
                      shares: superFlyer.edit.firstTimer == true? 0 : superFlyer.mSlides[superFlyer.currentSlideIndex].sharesCount,
                      views: superFlyer.edit.firstTimer == true ? 0 : superFlyer.mSlides[superFlyer.currentSlideIndex].viewsCount,
                      onShareTap: () => superFlyer.rec.onShareTap(),
                      onCountersTap: (){print('tapping slide counter');},
                    ),

                  // /// TAP AREAS
                  // Row(
                  //   children: <Widget>[
                  //
                  //     /// --- back tap area
                  //     GestureDetector(
                  //       onTap: () async {
                  //         print('widget.currentSlideIndex was : ${widget.superFlyer.currentSlideIndex}');
                  //         int _newIndex = await Sliders.slideToBackAndGetNewIndex(_slidingController, widget.superFlyer.currentSlideIndex);
                  //
                  //         /// if its first slide swipe to last flyer
                  //         if (_newIndex == widget.superFlyer.currentSlideIndex){
                  //           widget.superFlyer.onSwipeFlyer(SwipeDirection.back);
                  //         }
                  //         /// if its a middle or last slide, slide to the new index
                  //         else {
                  //           widget.superFlyer.onHorizontalSlideSwipe(_newIndex);
                  //           print('widget.currentSlideIndex after sliding is : $_newIndex');
                  //         }
                  //
                  //       },
                  //       child: Container(
                  //         width: widget.superFlyer.flyerZoneWidth * 0.25,
                  //         height: _tapAreaHeight,
                  //         margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
                  //         color: Colorz.Nothing,
                  //       ),
                  //     ),
                  //
                  //     // /// --- front tap area
                  //     // GestureDetector(
                  //     //   onTap: () async {
                  //     //     print('widget.currentSlideIndex was : ${widget.currentSlideIndex}');
                  //     //     int _newIndex = await Sliders.slideToNextAndGetNewIndex(_slidingController, _slidesLength, widget.currentSlideIndex);
                  //     //
                  //     //     /// if its last slide swipe to next flyer
                  //     //     if (_newIndex == widget.currentSlideIndex){
                  //     //       widget.swipeFlyer(SwipeDirection.next);
                  //     //     }
                  //     //     /// if its a middle or last slide, slide to the new index
                  //     //     else {
                  //     //       widget.sliding(_newIndex);
                  //     //       print('widget.currentSlideIndex after sliding is : $_newIndex');
                  //     //     }
                  //     //   },
                  //     //   child: Container(
                  //     //     width: widget.flyerZoneWidth * 0.75,
                  //     //     height: _tapAreaHeight,
                  //     //     margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
                  //     //     color: Colorz.Nothing,
                  //     //   ),
                  //     // ),
                  //
                  //   ],
                  // ),


                ],
              ),
            );

        }),

      ],
    );
  }
}
