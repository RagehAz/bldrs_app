import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/b_slide_tap_areas.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/images/cc_zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:space_time/space_time.dart';
import 'package:flutter/material.dart';

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

    return ZoomablePicture(
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
