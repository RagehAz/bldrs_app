import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class FlyerLoading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerLoading({
    required this.flyerBoxWidth,
    required this.animate,
    this.loadingColor = Colorz.white10,
    this.boxColor = Colorz.white20,
    this.direction = Axis.horizontal,
    this.verse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Color loadingColor;
  final Color boxColor;
  final bool animate;
  final Axis direction;
  final Verse? verse;
  /// --------------------------------------------------------------------------
  int _getRotation(BuildContext context){

    /// LEFT => RIGHT
    if (UiProvider.checkAppIsLeftToRight() == true){

      if (direction == Axis.horizontal){
        /// THING GOES RIGHT TO LEFT
        return 2;
      }
      else {
        ///
        return 3;
      }

    }

    /// RIGHT => LEFT
    else {

      if (direction == Axis.horizontal){
        /// THING GOES LEFT TO RIGHT
        return 0;
      }
      else {
        return 3;
      }

    }

  }
  @override
  Widget build(BuildContext context) {

    if (flyerBoxWidth == 0){
      return const SizedBox();
    }

    else {

      return Stack(
        children: <Widget>[

          FlyerBox(
            flyerBoxWidth: flyerBoxWidth,
            boxColor: boxColor,
            stackWidgets: <Widget>[

              if (animate == true)
                ClipRRect(
                  borderRadius: FlyerDim.flyerCorners(flyerBoxWidth),
                  child: RotatedBox(
                    quarterTurns: _getRotation(context),
                    child: LinearProgressIndicator(
                      color: loadingColor,
                      backgroundColor: Colorz.nothing,
                      minHeight: FlyerDim.flyerHeightByFlyerWidth(
                        flyerBoxWidth: flyerBoxWidth,
                      ),
                    ),
                  ),
                ),

              if (verse != null)
              WidgetFader(
                fadeType: FadeType.repeatAndReverse,
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticInOut,
                child: Align(
                  child: BldrsText(
                    verse: verse,
                    margin: flyerBoxWidth * 0.1,
                    scaleFactor: flyerBoxWidth * 0.008,
                    maxLines: 4,
                    color: Colorz.white125,
                  ),
                ),
              ),

            ],
          ),

        ],
      );

    }

  }
/// --------------------------------------------------------------------------
}
