import 'package:bldrs/b_views/widgets/specific/flyer/parts/progress_bar_parts/old_strips.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/progress_box.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class OldProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldProgressBar({
    @required this.numberOfSlides,
    @required this.index,
    @required this.opacity,
    @required this.flyerBoxWidth,
    @required this.swipeDirection,
    this.loading = true,
    this.margins,
    // @required this.duration,
    // @required this.draft,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int numberOfSlides;
  final int index;
  // final Duration duration;
  final double opacity;
  final double flyerBoxWidth;
  // final DraftFlyerModel draft;
  final bool loading;
  final Sliders.SwipeDirection swipeDirection;
  final EdgeInsets margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // print('B---> ProgressBar : numberOfSlides : ${numberOfSlides}');

    return SizedBox(
      width: flyerBoxWidth,
      child: AnimatedOpacity(
        duration: Ratioz.durationFading200,
        opacity: opacity ?? 1,
        child:

            // superFlyer.loading == true ?
        loading == true || numberOfSlides == null ? ProgressBox(
            flyerBoxWidth: flyerBoxWidth,
            margins: margins,
            stripsStack: <Widget>[

              Container(
                width: OldStrips.stripsTotalLength(flyerBoxWidth),
                height: OldStrips.stripThickness(flyerBoxWidth),
                decoration: BoxDecoration(
                  color: OldStrips.stripOffColor,
                  borderRadius: OldStrips.stripBorders(
                      context: context, flyerBoxWidth: flyerBoxWidth),
                ),
                child: LinearProgressIndicator(
                  backgroundColor: Colorz.nothing,
                  minHeight: OldStrips.stripThickness(flyerBoxWidth),
                  valueColor: const AlwaysStoppedAnimation(OldStrips.stripFadedColor),
                ),
              ),

            ]
        )
                :
            OldStrips.canBuildStrips(numberOfSlides) == true ?
            OldStrips(
              flyerBoxWidth: flyerBoxWidth,
              numberOfStrips: numberOfSlides,
              slideIndex: index,
              swipeDirection: swipeDirection,
              margins: margins,
            )
                :
            Container(),
      ),
    );
  }
}
