import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/light_slide/b_static_light_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/light_slide/c_animated_light_slide.dart';
import 'package:flutter/material.dart';

class LightSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LightSlide({
    @required this.flyerBoxWidth,
    @required this.slideModel,
    @required this.isAnimated,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final SlideModel slideModel;
  final bool isAnimated;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (isAnimated == true){
      return AnimatedLightSlide(
        flyerBoxWidth: flyerBoxWidth,
        slideModel: slideModel,
      );
    }

    else {
      return StaticLightSlide(
        flyerBoxWidth: flyerBoxWidth,
        slideModel: slideModel,
      );
    }
    // --------------------
  }
/// --------------------------------------------------------------------------
}
