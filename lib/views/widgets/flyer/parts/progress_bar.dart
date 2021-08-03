import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  // final Duration duration;
  // final double opacity;
  final double flyerZoneWidth;
  // final DraftFlyerModel draft;
  final SuperFlyer superFlyer;
  final bool loading;

  const ProgressBar({
    // @required this.duration,
    // @required this.opacity,
    @required this.flyerZoneWidth,
    // @required this.draft,
    @required this.superFlyer,
    this.loading = true,
    Key key,
  });

  @override
  Widget build(BuildContext context) {

    print('B---> ProgressBar : numberOfSlides : ${superFlyer.numberOfSlides}');

    return Container(
      width: flyerZoneWidth,
      child: AnimatedOpacity(
        duration: Ratioz.durationFading200,
        opacity: superFlyer?.progressBarOpacity == null ? 1 : superFlyer.progressBarOpacity,
        child:

        // superFlyer.loading == true ?
        loading == true || superFlyer?.numberOfStrips == null?
        ProgressBox(
              flyerZoneWidth: flyerZoneWidth,
              margins: null,
              strips: <Widget>[
                Container(
                  width: Strips.stripsTotalLength(flyerZoneWidth),
                  height: Strips.stripThickness(flyerZoneWidth),
                  decoration: BoxDecoration(
                    color: Strips.stripOffColor,
                    borderRadius: Strips.stripBorders(context: context, flyerZoneWidth: flyerZoneWidth),
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: Colorz.Nothing,
                    minHeight: Strips.stripThickness(flyerZoneWidth),
                    valueColor: AlwaysStoppedAnimation(Strips.stripFadedColor),

                  ),
                ),
              ]
            )

            :
        Strips.canBuildStrips(superFlyer?.numberOfStrips) == true?
        Strips(
          flyerZoneWidth: flyerZoneWidth,
          numberOfStrips: superFlyer.numberOfStrips,
          slideIndex: superFlyer.currentSlideIndex,
          swipeDirection: superFlyer.swipeDirection,
        )

              :

        Container(),
      ),
    );
  }
}
