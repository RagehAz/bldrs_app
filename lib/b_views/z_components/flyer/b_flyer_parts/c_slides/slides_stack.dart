import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/flyer_slides.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class SlidesStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesStack({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.currentSlideIndex,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    @required this.canShowGalleryPage,
    @required this.numberOfSlides,
    @required this.inFlight,
    this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final ValueNotifier<int> currentSlideIndex;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final String heroTag;
  final bool canShowGalleryPage;
  final int numberOfSlides;
  final bool inFlight;
  /// --------------------------------------------------------------------------
  bool _canShowSaveButton(){
    bool _canShow = false;

    if (
    currentSlideIndex?.value != null &&
    canLoopList(flyerModel?.slides) == true
    ){
      _canShow = true;
    }

    return _canShow;
  }
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
      currentSlideIndex: currentSlideIndex,
      heroTag: heroTag,
      canShowGalleryPage : canShowGalleryPage,
      numberOfSlides: numberOfSlides,
      inFlight: inFlight,
    );
  }
}
