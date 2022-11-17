import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:flutter/material.dart';

class SlideBackCoverImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideBackCoverImage({
    @required this.filterModel,
    @required this.slide,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<ImageFilterModel> filterModel;
  final DraftSlide slide;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('SlideBackCoverImage'),
        valueListenable: filterModel,
        builder: (_, ImageFilterModel _filterModel, Widget child){

          return SuperFilteredImage(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            pic: slide.picModel.bytes,
            filterModel: _filterModel,
          );
        }
        );

  }
/// --------------------------------------------------------------------------
}
