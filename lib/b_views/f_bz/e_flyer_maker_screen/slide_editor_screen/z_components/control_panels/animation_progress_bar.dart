import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip_with_headline.dart';
import 'package:flutter/material.dart';

class SlideAnimationProgressBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideAnimationProgressBar({
    required this.isPlayingAnimation,
    required this.draftSlide,
    required this.flyerBoxWidth,
    super.key
  });
  // --------------------
  final ValueNotifier<bool> isPlayingAnimation;
  final DraftSlide draftSlide;
  final double flyerBoxWidth;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Positioned(
      bottom: 0,
      child: ValueListenableBuilder(
          valueListenable: isPlayingAnimation,
          builder: (_, bool isPlaying, Widget? child) {
            return WidgetFader(
              fadeType: isPlaying == true ? FadeType.fadeIn : FadeType.stillAtMin,
              duration:  const Duration(seconds: 3),
              curve: draftSlide.animationCurve ?? Curves.easeInOut,
              builder: (double value, Widget? child){

                return DataStripValue(
                  width: flyerBoxWidth - (FlyerDim.flyerBottomCornerValue(flyerBoxWidth) * 2),
                  height: 3,
                  valueIsPercentage: true,
                  topColor: Colorz.yellow125,
                  backColor: Colorz.white20,
                  dataValue: value * 100,
                  onTap: null,
                  horizontalMargin: 0,
                  valueString: null,
                );

                },
            );
          }
          ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
