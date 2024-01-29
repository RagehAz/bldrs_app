import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/a_slide_box.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/b_slide_image.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';

class SingleSlide extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SingleSlide({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slideModel,
    required this.slidePicType,
    required this.loading,
    required this.tinyMode,
    required this.onSlideNextTap,
    required this.onSlideBackTap,
    required this.onDoubleTap,
    required this.canTapSlide,
    required this.slideShadowIsOn,
    required this.canPinch,
    super.key
  });
  // --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel? slideModel;
  final SlidePicType slidePicType;
  final bool loading;
  final bool tinyMode;
  final Function? onSlideNextTap;
  final Function? onSlideBackTap;
  final Function? onDoubleTap;
  final bool slideShadowIsOn;
  final bool canTapSlide;
  final bool canPinch;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SlideBox(
      key: const ValueKey<String>('SingleSlideBox'),
      flyerBoxWidth: flyerBoxWidth,
      flyerBoxHeight: flyerBoxHeight,
      tinyMode: tinyMode,
      slideMidColor: slideModel?.backColor ?? slideModel?.midColor,
      shadowIsOn: slideShadowIsOn,
      stackChildren: <Widget>[

        // /// BACKGROUND COLOR
        // if (slideModel?.backColor != null)
        //   Container(
        //     width: flyerBoxWidth,
        //     height: flyerBoxHeight,
        //     color: slideModel!.backColor,
        //   ),

        /// BACKGROUND PIC
        if (slideModel?.backColor == null)
          BldrsImage(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            pic: slideModel?.backImage ?? SlideModel.generateSlidePicPath(
              flyerID: slideModel?.flyerID,
              slideIndex: slideModel?.slideIndex,
              type: SlidePicType.back,
            ),
          ),

        /// ANIMATED SLIDE
        if (slideModel != null)
        SlideImage(
          canPinch: canPinch,
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: flyerBoxHeight,
          onDoubleTap: onDoubleTap,
          canAnimateMatrix: slideModel?.animationCurve != null,
          slideModel: slideModel,
          slidePicType: SlideModel.getSmallSlidePicTypeIfAnimated(
            slideModel: slideModel!,
            ifStatic: slidePicType,
          ),
          loading: loading,
          canTapSlide: canTapSlide,
          onSlideNextTap: onSlideNextTap,
          onSlideBackTap: onSlideBackTap,
        ),

        /// SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
        SlideShadow(
          key: const ValueKey<String>('SingleSlideShadow'),
          flyerBoxWidth: flyerBoxWidth,
        ),

        /// BOTTOM SHADOW
        FooterShadow(
          key: const ValueKey<String>('FooterShadow'),
          flyerBoxWidth: flyerBoxWidth,
        ),

        /// HEADLINE
        SlideHeadline(
          key: const ValueKey<String>('SlideHeadline'),
          flyerBoxWidth: flyerBoxWidth,
          text: slideModel?.headline,
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
