import 'package:basics/components/animators/matrix_animator.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/b_slide_tap_areas.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';
import 'package:basics/components/super_image/super_image.dart';

class SlideImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideImage({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slideModel,
    required this.loading,
    required this.slidePicType,
    required this.onSlideNextTap,
    required this.onSlideBackTap,
    required this.onDoubleTap,
    required this.canTapSlide,
    required this.canAnimateMatrix,
    required this.canPinch,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel? slideModel;
  final SlidePicType slidePicType;
  final bool loading;
  final Function? onSlideNextTap;
  final Function? onSlideBackTap;
  final Function? onDoubleTap;
  final bool canTapSlide;
  final bool canAnimateMatrix;
  final bool canPinch;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ZoomableImage(
      key: const ValueKey<String>('SlideImage_tree'),
      canZoom: canPinch,
      child: SlideTapAreas(
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: flyerBoxHeight,
        onTapNext: onSlideNextTap,
        onTapBack: onSlideBackTap,
        onDoubleTap: onDoubleTap,
        canTap: canTapSlide,
        splashColor: slideModel?.midColor ?? Colorz.white20,
        child: MatrixAnimator(
          matrix: Trinity.renderSlideMatrix(
            matrix: slideModel?.matrix,
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
          ),
          matrixFrom: Trinity.renderSlideMatrix(
            matrix: slideModel?.matrixFrom,
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
          ),
          canAnimate: canAnimateMatrix,
          repeat: false,
          child: BldrsImage(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            pic: slideModel?.frontImage ?? SlideModel.generateSlidePicPath(
                flyerID: slideModel?.flyerID,
                slideIndex: slideModel?.slideIndex,
                type: slidePicType,
            ),
            fit: BoxFit.contain,
            loading: loading,
            // canUseFilter: canUseFilter,

          ),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
