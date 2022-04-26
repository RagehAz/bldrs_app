import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/progress_bar_child.drat.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBar({
    @required this.flyerBoxWidth,
    @required this.numberOfSlides,
    @required this.currentSlideIndex,
    @required this.progressBarOpacity,
    @required this.swipeDirection,
    @required this.tinyMode,
    this.loading = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final int numberOfSlides;
  final ValueNotifier<int> currentSlideIndex; /// p
  final ValueNotifier<double> progressBarOpacity; /// p
  final ValueNotifier<Sliders.SwipeDirection> swipeDirection; /// p
  final bool loading;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: flyerBoxWidth,
      child: ValueListenableBuilder<double>(
        valueListenable: progressBarOpacity,
        builder: (_, double _progressBarOpacity, Widget child){

          return AnimatedOpacity(
            duration: Ratioz.durationFading200,
            opacity: _progressBarOpacity,
            child: child,
          );

        },

        child: ProgressBarChild(
          flyerBoxWidth: flyerBoxWidth,
          currentSlideIndex: currentSlideIndex,
          swipeDirection: swipeDirection,
          numberOfSlides: numberOfSlides,
          tinyMode: tinyMode,
          loading: loading,
        ),

      ),
    );
  }
}
