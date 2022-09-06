import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_image_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_shadow.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class SingleSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SingleSlide({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.slideModel,
    @required this.tinyMode,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel slideModel;
  final bool tinyMode;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  /*
  int _getSlideTitleSize(BuildContext context){
    final double _screenWidth = Scale.superScreenWidth(context);

    final int _slideTitleSize = flyerBoxWidth <= _screenWidth && flyerBoxWidth > (_screenWidth * 0.75) ? 4
        :
    flyerBoxWidth <= (_screenWidth * 0.75) && flyerBoxWidth > (_screenWidth * 0.5) ? 3
        :
    flyerBoxWidth <= (_screenWidth * 0.5) && flyerBoxWidth > (_screenWidth * 0.25) ? 2
        :
    flyerBoxWidth <= (_screenWidth * 0.25) && flyerBoxWidth > (_screenWidth * 0.1) ? 1
        :
    0;

    return _slideTitleSize;
  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
//     blog('${slideModel.slideIndex} : single slide title is : ${slideModel?.headline} and tinyMode is : $_tinyMode');
// -----------------------------------------------------------------------------
//     double _blurImageScale = 1.5;
    // -----------------------------o
    // bool _blurLayerIsActive = true;
    // Imagers().slideBlurIsOn(
    //   pic: picture,
    //   boxFit: boxFit,
    //   flyerBoxWidth: flyerBoxWidth,
    //   imageSize: imageSize,
    // );

// -----------------------------------------------------------------------------
    return SlideBox(
      key: const ValueKey<String>('SingleSlideBox'),
      flyerBoxWidth: flyerBoxWidth,
      flyerBoxHeight: flyerBoxHeight,
      tinyMode: tinyMode,
      slideMidColor: slideModel.midColor,
      stackChildren: <Widget>[

        /// --- IMAGE NETWORK
        if (ObjectCheck.isAbsoluteURL(slideModel.pic))
          SlideImagePart(
            key: const ValueKey<String>('SingleSlideImagePart'),
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
            tinyMode: tinyMode,
            slideModel: slideModel,
            onSlideBackTap: onSlideBackTap,
            onSlideNextTap: onSlideNextTap,
            onDoubleTap: onDoubleTap,
          ),

        /// --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
        SlideShadow(
          key: const ValueKey<String>('SingleSlideShadow'),
          flyerBoxWidth: flyerBoxWidth,
        ),

        /// HEADLINE
        SlideHeadline(
          key: const ValueKey<String>('SlideHeadline'),
          flyerBoxWidth: flyerBoxWidth,
          verse: slideModel.headline,
          // verseColor: Colorz.white255,
          tappingVerse: () {
            blog('Flyer Title clicked');
            },
        ),

      ],
    );

  }
}
