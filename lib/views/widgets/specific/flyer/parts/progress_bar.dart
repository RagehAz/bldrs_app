import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int numberOfSlides;
  final int numberOfStrips;
  final int index;
  // final Duration duration;
  final double opacity;
  final double flyerBoxWidth;
  // final DraftFlyerModel draft;
  final bool loading;
  final SwipeDirection swipeDirection;
  final EdgeInsets margins;

  const ProgressBar({
    @required this.numberOfSlides,
    @required this.numberOfStrips,
    @required this.index,
    // @required this.duration,
    @required this.opacity,
    @required this.flyerBoxWidth,
    // @required this.draft,
    this.loading = true,
    @required this.swipeDirection,
    this.margins,
  });

  @override
  Widget build(BuildContext context) {

    print('B---> ProgressBar : numberOfSlides : ${numberOfSlides}');

    return Container(
      width: flyerBoxWidth,
      child: AnimatedOpacity(
        duration: Ratioz.durationFading200,
        opacity: opacity == null ? 1 : opacity,
        child:

        // superFlyer.loading == true ?
        loading == true || numberOfStrips == null?
        ProgressBox(
              flyerBoxWidth: flyerBoxWidth,
              margins: margins,
              strips: <Widget>[
                Container(
                  width: Strips.stripsTotalLength(flyerBoxWidth),
                  height: Strips.stripThickness(flyerBoxWidth),
                  decoration: BoxDecoration(
                    color: Strips.stripOffColor,
                    borderRadius: Strips.stripBorders(context: context, flyerBoxWidth: flyerBoxWidth),
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: Colorz.Nothing,
                    minHeight: Strips.stripThickness(flyerBoxWidth),
                    valueColor: AlwaysStoppedAnimation(Strips.stripFadedColor),

                  ),
                ),
              ]
            )

            :
        Strips.canBuildStrips(numberOfStrips) == true?
        Strips(
          flyerBoxWidth: flyerBoxWidth,
          numberOfStrips: numberOfStrips,
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
