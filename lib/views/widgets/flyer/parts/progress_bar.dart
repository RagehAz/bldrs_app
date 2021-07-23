import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final Duration duration;
  final double opacity;
  final double flyerZoneWidth;
  final DraftFlyerModel draft;

  const ProgressBar({
    @required this.duration,
    @required this.opacity,
    @required this.flyerZoneWidth,
    @required this.draft,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: opacity,
      child: Strips(
        flyerZoneWidth: flyerZoneWidth,
        numberOfStrips: draft.numberOfStrips,
        slideIndex: draft.currentSlideIndex,
        swipeDirection: draft.swipeDirection,
      ),
    );
  }
}
