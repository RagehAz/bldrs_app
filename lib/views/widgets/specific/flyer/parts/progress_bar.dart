import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBar({
    @required this.numberOfSlides,
    @required this.numberOfStrips,
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
  final int numberOfStrips;
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
                    backgroundColor: Colorz.nothing,
                    minHeight: Strips.stripThickness(flyerBoxWidth),
                    valueColor: const AlwaysStoppedAnimation(Strips.stripFadedColor),

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
