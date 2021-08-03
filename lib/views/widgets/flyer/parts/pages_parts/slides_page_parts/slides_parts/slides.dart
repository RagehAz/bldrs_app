import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';

class Slides extends StatelessWidget {
  final SuperFlyer superFlyer;

  const Slides({
    @required this.superFlyer,

    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  void _onSingleSlideTap(BuildContext context){

    bool _tinyMode = Scale.superFlyerTinyMode(context, superFlyer.flyerZoneWidth);

    if (Keyboarders.keyboardIsOn(context)){
      Keyboarders.closeKeyboard(context);
    }

    if (_tinyMode == true){
      superFlyer.onTinyFlyerTap();
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
      controller: superFlyer.horizontalController,
      physics: const BouncingScrollPhysics(),
      pageSnapping: true,
      allowImplicitScrolling: false,
      clipBehavior: Clip.antiAlias,
      restorationId: '${superFlyer.key.value}',
      onPageChanged: superFlyer.listenToSwipe ? (i) => superFlyer.onHorizontalSlideSwipe(i) : (i) => Sliders.zombie(i),
      children: <Widget>[

        ...List.generate(superFlyer.numberOfSlides, (i){

          // print('========= BUILDING PROGRESS BAR FOR ||| index : $draft.currentSlideIndex, numberOfSlides : $draft.numberOfSlides');

          BoxFit _currentPicFit =
          superFlyer.boxesFits == null ? null :
          superFlyer.boxesFits?.length == 0 ? null : superFlyer.boxesFits[superFlyer.currentSlideIndex];


          // ImageSize _originalAssetSize =
          // superFlyer.assetsFiles == null ? null :
          // superFlyer.numberOfSlides == 0 ? null :
          // superFlyer.assetsSources.length == 0 ? null :
          //
          // await Imagers.superImageSize(superFlyer.assetsFiles[superFlyer.currentSlideIndex]);


          dynamic _slidePic =
          superFlyer.editMode == true ? superFlyer.assetsFiles[i] : superFlyer.mutableSlides[i].picture;
          // superFlyer.editMode ? superFlyer.assetsFiles[i] : superFlyer.slides[i].picture

          String _slideTitle = superFlyer.editMode == true ? superFlyer.headlinesControllers[i].text : superFlyer.mutableSlides[i].headline ;

          return
            superFlyer.numberOfSlides == 0 ? Container() :
            AnimatedOpacity(
              // key: ObjectKey('${superFlyer.key.value}${i}'),
              opacity: superFlyer.slidesVisibilities[i] == true ? 1 : 0,
              duration: Ratioz.durationFading200,
              child: Stack(
                children: <Widget>[

                  SingleSlide(
                    superFlyer: superFlyer,
                    flyerZoneWidth: superFlyer.flyerZoneWidth,
                    slideIndex: i,
                    // key: ObjectKey('${superFlyer.key.value}${i}'),
                    flyerID: superFlyer.flyerID, //_flyer.flyerID,
                    picture: _slidePic,
                    // slideMode: superFlyer.editMode ? SlideMode.Editor : SlideMode.View,//slidesModes[index],
                    boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                    titleController: superFlyer.editMode == true ? superFlyer.headlinesControllers[i] : null,
                    title: _slideTitle,
                    imageSize: superFlyer.mutableSlides[i].imageSize,
                    textFieldOnChanged: (text){
                      print('text is : $text');
                    },
                    onTap: () => _onSingleSlideTap(context),
                  ),

                  if (superFlyer.editMode != true)
                    FlyerFooter(
                      flyerZoneWidth: superFlyer.flyerZoneWidth,
                      saves: superFlyer.firstTimer == true ? 0 : superFlyer.mutableSlides[superFlyer.currentSlideIndex].savesCount,
                      shares: superFlyer.firstTimer == true? 0 : superFlyer.mutableSlides[superFlyer.currentSlideIndex].sharesCount,
                      views: superFlyer.firstTimer == true ? 0 : superFlyer.mutableSlides[superFlyer.currentSlideIndex].viewsCount,
                      onShareTap: () => superFlyer.onShareTap(),
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
