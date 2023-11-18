import 'package:basics/animators/widgets/animate_widget_to_matrix.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/b_slide_tap_areas.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';
import 'package:basics/super_image/super_image.dart';

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
    required this.canUseFilter,
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
  final bool canUseFilter;
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
        child: AnimateWidgetToMatrix(
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
            fit: BoxFit.fitWidth,
            loading: loading,
            // canUseFilter: canUseFilter,

          ),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
