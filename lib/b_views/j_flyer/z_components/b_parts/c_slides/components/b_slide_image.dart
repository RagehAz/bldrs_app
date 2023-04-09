import 'package:animators/animators.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/b_slide_tap_areas.dart';
import 'package:space_time/space_time.dart';
import 'package:flutter/material.dart';
import 'package:super_image/super_image.dart';

class SlideImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideImage({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.slideModel,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    @required this.canTapSlide,
    @required this.canAnimateMatrix,
    @required this.canUseFilter,
    @required this.canPinch,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final SlideModel slideModel;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
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
        splashColor: slideModel?.midColor,
        child: AnimateWidgetToMatrix(
          matrix: Trinity.renderSlideMatrix(
            matrix: slideModel?.matrix,
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
          ),
          canAnimate: canAnimateMatrix,
          repeat: false,
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
    );

  }
  /// --------------------------------------------------------------------------
}
