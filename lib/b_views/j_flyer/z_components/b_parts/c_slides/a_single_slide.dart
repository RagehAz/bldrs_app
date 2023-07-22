import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/a_slide_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/b_slide_image.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:flutter/material.dart';

/// THE OLD
class SingleSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SingleSlide({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slideModel,
    required this.tinyMode,
    required this.onSlideNextTap,
    required this.onSlideBackTap,
    required this.onDoubleTap,
    required this.canTapSlide,
    // required this.canAnimateMatrix,
    required this.slideShadowIsOn,
    required this.blurLayerIsOn,
    required this.canUseFilter,
    required this.canPinch,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel? slideModel;
  final bool tinyMode;
  final Function? onSlideNextTap;
  final Function? onSlideBackTap;
  final Function? onDoubleTap;
  final bool slideShadowIsOn;
  final bool blurLayerIsOn;
  final bool canTapSlide;
  // final bool canAnimateMatrix;
  final bool canUseFilter;
  final bool canPinch;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SlideBox(
      key: const ValueKey<String>('SingleSlideBox'),
      flyerBoxWidth: flyerBoxWidth,
      flyerBoxHeight: flyerBoxHeight,
      tinyMode: tinyMode,
      slideMidColor: slideModel?.midColor,
      shadowIsOn: slideShadowIsOn,
      stackChildren: <Widget>[

        // /// BACK GROUND COVER PIC
        if (blurLayerIsOn == true)
          SuperFilteredImage(
            key: const ValueKey<String>('BACKGROUND_SLIDE_BLUR_PIC'),
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            pic: slideModel?.uiImage,
            loading: false,
          ),

        /// BLUR LAYER
        if (blurLayerIsOn == true)
          BlurLayer(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            blurIsOn: true,
            blur: 20,
            borders: FlyerDim.flyerCorners(flyerBoxWidth),
          ),

        /// ANIMATED SLIDE
        SlideImage(
          canPinch: canPinch,
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: flyerBoxHeight,
          onDoubleTap: onDoubleTap,
          canAnimateMatrix: slideModel?.animationCurve != null,
          slideModel: slideModel,
          canUseFilter: canUseFilter,
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

/// NEW PROPOSAL
// class SingleSlide extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SingleSlide({
//     required this.flyerBoxWidth,
//     required this.flyerBoxHeight,
//     required this.slideModel,
//     required this.tinyMode,
//     required this.onSlideNextTap,
//     required this.onSlideBackTap,
//     required this.onDoubleTap,
//     required this.canTapSlide,
//     // required this.canAnimateMatrix,
//     required this.slideShadowIsOn,
//     required this.blurLayerIsOn,
//     required this.canUseFilter,
//     required this.canPinch,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final double flyerBoxHeight;
//   final SlideModel? slideModel;
//   final bool tinyMode;
//   final Function? onSlideNextTap;
//   final Function? onSlideBackTap;
//   final Function? onDoubleTap;
//   final bool slideShadowIsOn;
//   final bool blurLayerIsOn;
//   final bool canTapSlide;
//   // final bool canAnimateMatrix;
//   final bool canUseFilter;
//   final bool canPinch;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return SlideBox(
//       key: const ValueKey<String>('SingleSlideBox'),
//       flyerBoxWidth: flyerBoxWidth,
//       flyerBoxHeight: flyerBoxHeight,
//       tinyMode: tinyMode,
//       slideMidColor: slideModel?.midColor,
//       shadowIsOn: slideShadowIsOn,
//       stackChildren: <Widget>[
//
//         // /// BACK GROUND COVER PIC
//         if (blurLayerIsOn == true)
//           SuperFilteredImage(
//             key: const ValueKey<String>('BACKGROUND_SLIDE_BLUR_PIC'),
//             width: flyerBoxWidth,
//             height: flyerBoxHeight,
//             pic: slideModel?.uiImage,
//             loading: false,
//           ),
//
//         /// BLUR LAYER
//         if (blurLayerIsOn == true)
//           BlurLayer(
//             width: flyerBoxWidth,
//             height: flyerBoxHeight,
//             blurIsOn: true,
//             blur: 20,
//           ),
//
//         /// ANIMATED SLIDE
//         SlideImage(
//           canPinch: canPinch,
//           flyerBoxWidth: flyerBoxWidth,
//           flyerBoxHeight: flyerBoxHeight,
//           onDoubleTap: onDoubleTap,
//           canAnimateMatrix: slideModel?.animationCurve != null,
//           slideModel: slideModel,
//           canUseFilter: canUseFilter,
//           canTapSlide: canTapSlide,
//           onSlideNextTap: onSlideNextTap,
//           onSlideBackTap: onSlideBackTap,
//         ),
//
//         /// SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
//         SlideShadow(
//           key: const ValueKey<String>('SingleSlideShadow'),
//           flyerBoxWidth: flyerBoxWidth,
//         ),
//
//         /// BOTTOM SHADOW
//         FooterShadow(
//           key: const ValueKey<String>('FooterShadow'),
//           flyerBoxWidth: flyerBoxWidth,
//         ),
//
//         /// HEADLINE
//         SlideHeadline(
//           key: const ValueKey<String>('SlideHeadline'),
//           flyerBoxWidth: flyerBoxWidth,
//           text: slideModel?.headline,
//         ),
//
//       ],
//     );
//     // --------------------
//   }
//   // -----------------------------------------------------------------------------
// }
