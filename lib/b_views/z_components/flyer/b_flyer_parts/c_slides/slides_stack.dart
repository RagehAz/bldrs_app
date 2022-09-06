import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/flyer_slides.dart';
import 'package:flutter/material.dart';

class SlidesStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesStack({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.progressBarModel,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    @required this.flightDirection,
    this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final ValueNotifier<ProgressBarModel> progressBarModel; /// p
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final String heroTag;
  final FlightDirection flightDirection;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerSlides(
      key: const ValueKey<String>('SlidesStack_FlyerSlides'),
      flyerModel: flyerModel,
      bzModel: bzModel,
      flyerBoxWidth: flyerBoxWidth,
      flyerBoxHeight: flyerBoxHeight,
      tinyMode: tinyMode,
      horizontalController: horizontalController,
      onSwipeSlide: onSwipeSlide,
      onSlideBackTap: onSlideBackTap,
      onSlideNextTap: onSlideNextTap,
      onDoubleTap: onDoubleTap,
      progressBarModel: progressBarModel,
      heroTag: heroTag,
      flightDirection: flightDirection,
    );

  }
  // -----------------------------------------------------------------------------
}
