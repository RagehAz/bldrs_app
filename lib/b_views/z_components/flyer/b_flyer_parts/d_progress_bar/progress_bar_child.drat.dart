import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/loading_progress_bar.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/strips.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:flutter/material.dart';

class ProgressBarChild extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBarChild({
    @required this.flyerBoxWidth,
    @required this.numberOfSlides,
    @required this.swipeDirection,
    @required this.currentSlideIndex,
    @required this.tinyMode,
    this.loading = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final int numberOfSlides;
  final ValueNotifier<Sliders.SwipeDirection> swipeDirection;
  final ValueNotifier<int> currentSlideIndex;
  final bool tinyMode;
  final bool loading;
  /// --------------------------------------------------------------------------
  bool _progressBarIsLoading(){
    bool _isLoading = false;

    if (loading == true || numberOfSlides == null){
      _isLoading = true;
    }

    return _isLoading;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_progressBarIsLoading() == true){
      return LoadingProgressBar(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else if (Strips.canBuildStrips(numberOfSlides) == true){
      return Strips(
        flyerBoxWidth: flyerBoxWidth,
        numberOfStrips: numberOfSlides + 1, /// FOR THE EXTRA SLIDE
        currentSlideIndex: currentSlideIndex,
        swipeDirection: swipeDirection,
        tinyMode: tinyMode,
      );
    }

    else {
      return Container();
    }
  }

}
