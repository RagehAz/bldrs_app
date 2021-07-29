import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  // final Duration duration;
  // final double opacity;
  final double flyerZoneWidth;
  // final DraftFlyerModel draft;
  final SuperFlyer superFlyer;

  const ProgressBar({
    // @required this.duration,
    // @required this.opacity,
    @required this.flyerZoneWidth,
    // @required this.draft,
    @required this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('building progress bar');

    return Container(
      width: flyerZoneWidth,
      child: AnimatedOpacity(
        duration: superFlyer.fadingDuration,
        opacity: superFlyer.progressBarOpacity,
        child:

        superFlyer.numberOfSlides > 0?
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
