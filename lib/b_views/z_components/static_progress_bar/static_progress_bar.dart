import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StaticProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticProgressBar({
    @required this.numberOfSlides,
    @required this.index,
    @required this.opacity,
    @required this.flyerBoxWidth,
    @required this.swipeDirection,
    this.loading = true,
    this.margins,
    this.shrinkThickness = 1,
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
  final SwipeDirection swipeDirection;
  final EdgeInsets margins;
  final double shrinkThickness;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // print('B---> ProgressBar : numberOfSlides : ${numberOfSlides}');

    return SizedBox(
      width: flyerBoxWidth,
      child: Opacity(
        opacity: opacity ?? 1,
        child:

        loading == true || numberOfSlides == null ?
        ProgressBox(
            flyerBoxWidth: flyerBoxWidth,
            margins: margins,
            stripsStack: <Widget>[

              Container(
                width: StaticStrips.stripsTotalLength(flyerBoxWidth),
                height: StaticStrips.stripThickness(flyerBoxWidth),
                decoration: BoxDecoration(
                  color: StaticStrips.stripOffColor,
                  borderRadius: StaticStrips.stripBorders(
                      context: context, flyerBoxWidth: flyerBoxWidth),
                ),
                child: LinearProgressIndicator(
                  backgroundColor: Colorz.nothing,
                  minHeight: StaticStrips.stripThickness(flyerBoxWidth),
                  valueColor: const AlwaysStoppedAnimation(StaticStrips.stripFadedColor),
                ),
              ),

            ]
        )
                :
        StaticStrips.canBuildStrips(numberOfSlides) == true ?
        Transform.scale(
          scaleY: shrinkThickness,
          alignment: Alignment.bottomCenter,
          child: StaticStrips(
                flyerBoxWidth: flyerBoxWidth,
                numberOfStrips: numberOfSlides,
                slideIndex: index,
                swipeDirection: swipeDirection,
                margins: margins,
              ),
        )
                :
            Container(),
      ),
    );
  }
}
