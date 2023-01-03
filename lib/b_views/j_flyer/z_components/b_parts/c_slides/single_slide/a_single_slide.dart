import 'dart:typed_data';

import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/b_slide_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
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
    this.slideShadowIsOn = false,
    this.blurLayerIsOn = false,
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
    // --------------------
    // assert(slideModel.midColor != null, 'slideModel.midColor is null');
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
        // AnimateWidgetToMatrix(
        //   matrix: Trinity.renderSlideMatrix(
        //     matrix: slideModel?.matrix,
        //     flyerBoxWidth: flyerBoxWidth,
        //     flyerBoxHeight: flyerBoxHeight,
        //   ),
        //   child: SuperFilteredImage(
        //     width: flyerBoxWidth - 10,
        //     height: flyerBoxHeight,
        //     pic: slideModel?.uiImage,
        //     filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
        //     boxFit: slideModel?.picFit,
        //   ),
        // ),
        FutureBuilder(
          future: Floaters.getUint8ListFromUiImage(slideModel?.uiImage),
          builder: (_, AsyncSnapshot<Uint8List> snap){

            final Uint8List _bytes = snap?.data;

            if (Streamer.connectionIsLoading(snap) == true || _bytes == null){

              return SuperFilteredImage(
                width: flyerBoxWidth,
                height: flyerBoxHeight,
                pic: slideModel?.uiImage,
                filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
                boxFit: slideModel?.picFit,
              );

            // return SlideImagePart(
            //     key: const ValueKey<String>('SingleSlideImagePart'),
            //     flyerBoxWidth: flyerBoxWidth,
            //     flyerBoxHeight: flyerBoxHeight,
            //     tinyMode: tinyMode,
            //     slideModel: slideModel,//?.copyWith(midColor: Colorz.red255),
            //     onSlideBackTap: onSlideBackTap,
            //     onSlideNextTap: onSlideNextTap,
            //     onDoubleTap: onDoubleTap,
            //   );
            }

            else {
              return AnimateWidgetToMatrix(
                matrix: Trinity.renderSlideMatrix(
                  matrix: slideModel?.matrix,
                  flyerBoxWidth: flyerBoxWidth,
                  flyerBoxHeight: flyerBoxHeight,
                ),
                child: SuperFilteredImage(
                  width: flyerBoxWidth - 10,
                  height: flyerBoxHeight,
                  pic: slideModel?.uiImage,
                  filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
                  boxFit: slideModel?.picFit,
                ),
              );
            }

          },
        ),

        /// ----

        // /// STATIC IMAGE
        //   SlideImagePart(
        //     key: const ValueKey<String>('SingleSlideImagePart'),
        //     flyerBoxWidth: flyerBoxWidth,
        //     flyerBoxHeight: flyerBoxHeight,
        //     tinyMode: tinyMode,
        //     slideModel: slideModel,
        //     onSlideBackTap: onSlideBackTap,
        //     onSlideNextTap: onSlideNextTap,
        //     onDoubleTap: onDoubleTap,
        //   ),

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
