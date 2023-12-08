import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class PlaySlideAnimationLayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PlaySlideAnimationLayer({
    required this.flyerBoxWidth,
    required this.isTransforming,
    required this.isPlayingAnimation,
    required this.draftSlide,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final ValueNotifier<bool> isTransforming;
  final ValueNotifier<bool> isPlayingAnimation;
  final DraftSlide? draftSlide;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (draftSlide?.animationCurve == null){
      return const SizedBox();
    }

    else {
      return ValueListenableBuilder(
          valueListenable: isTransforming,
          builder: (_, bool isTransforming, Widget? childA) {

            return ValueListenableBuilder(
              valueListenable: isPlayingAnimation,
              builder: (_, bool isPlaying, Widget? childB){

                if (isTransforming == true || isPlaying == true){
                  return const SizedBox();
                }

                else {
                  return IgnorePointer(
                    child: WidgetFader(
                      fadeType: FadeType.fadeIn,
                      duration: const Duration(seconds: 1),
                      child: FlyerBox(
                        flyerBoxWidth: flyerBoxWidth,
                        boxColor: Colorz.nothing,
                        stackWidgets: <Widget>[

                          /// WHITE
                          Center(
                            child: BldrsBox(
                              height: flyerBoxWidth * 0.9,
                              width: flyerBoxWidth * 0.9,
                              icon: Iconz.play,
                              iconSizeFactor: 0.6,
                              iconColor: Colorz.white50,
                              bubble: false,
                            ),
                          ),

                          /// BLACK
                          Center(
                            child: BldrsBox(
                              height: flyerBoxWidth * 0.9,
                              width: flyerBoxWidth * 0.9,
                              icon: Iconz.play,
                              iconSizeFactor: 0.6,
                              iconColor: Colorz.black20,
                              bubble: false,
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }

                },
            );

          }
          );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
