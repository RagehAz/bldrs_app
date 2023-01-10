import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/b_slide_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/cc_slide_tap_area.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/images/cc_zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
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
    @required this.canTapSlide,
    @required this.canAnimateMatrix,
    @required this.slideShadowIsOn,
    @required this.blurLayerIsOn,
    @required this.canUseFilter,
    @required this.canPinch,
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
  final bool slideShadowIsOn;
  final bool blurLayerIsOn;
  final bool canTapSlide;
  final bool canAnimateMatrix;
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

        /// BACK GROUND COVER PIC
        if (blurLayerIsOn == true)
          SuperFilteredImage(
            key: const ValueKey<String>('BACKGROUND_SLIDE_BLUR_PIC'),
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            pic: slideModel?.uiImage,
            filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
          ),

        /// BLUR LAYER
        if (blurLayerIsOn == true)
          BlurLayer(
            key: const ValueKey<String>('blur_layer'),
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            blurIsOn: true,
            blur: 20,
            borders: FlyerDim.flyerCorners(context, flyerBoxWidth),
          ),

        /// ANIMATED SLIDE
        ZoomablePicture(
          key: const ValueKey<String>('FLYER_SLIDES_TREE'),
          canZoom: canPinch,
          child: SlideTapAreas(
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
            onTapNext: onSlideNextTap,
            onTapBack: onSlideBackTap,
            onDoubleTap: onDoubleTap,
            canTap: canTapSlide,
            splashColor: slideModel?.midColor,
            child: AnimateWidgetToMatrix(
              matrix: Trinity.renderSlideMatrix(
                matrix: slideModel?.matrix,
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: flyerBoxHeight,
              ),
              canAnimate: canAnimateMatrix,
              child: SuperFilteredImage(
                width: flyerBoxWidth,
                height: flyerBoxHeight,
                pic: slideModel?.uiImage,
                filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
                boxFit: slideModel?.picFit,
                canUseFilter: canUseFilter,
              ),
            ),
          ),
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
          verse: Verse(
            text: slideModel?.headline,
            translate: false,
          ),
        ),


      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
