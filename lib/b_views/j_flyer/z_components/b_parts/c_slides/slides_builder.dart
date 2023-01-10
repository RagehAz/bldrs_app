import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/gallery_slide/gallery_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/horizontal_bouncer.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SlidesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesBuilder({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.flyerModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    @required this.progressBarModel,
    @required this.flightDirection,
    @required this.heroTag,
    @required this.canTapSlides,
    @required this.showSlidesShadows,
    @required this.showSlidesBlurLayers,
    @required this.canAnimateSlides,
    @required this.canPinch,
    @required this.canUseFilter,
    @required this.showGallerySlide,
    this.onHorizontalExit,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel flyerModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final String heroTag;
  final FlightDirection flightDirection;
  final Function onHorizontalExit;
  final bool canTapSlides;
  final bool showSlidesShadows;
  final bool showSlidesBlurLayers;
  final bool canAnimateSlides;
  final bool canUseFilter;
  final bool canPinch;
  final bool showGallerySlide;
  // --------------------
  int concludeNumberOfPages(){
    final int _gallerySlideCount = showGallerySlide == true ? 1 : 0;
    final int _realSlidesCount = flyerModel?.slides?.length ?? 0;
    return _gallerySlideCount + _realSlidesCount;
  }
  // --------------------
  bool _canNavigateOnBounce(){
    bool _canNavigate;

    if (flightDirection == FlightDirection.pop){
      _canNavigate = false;
    }
    else {
      _canNavigate = true;
    }

    return _canNavigate;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    if (Mapper.checkCanLoopList(flyerModel?.slides) == true){

      final int _realNumberOfSlide = flyerModel.slides.length;
      final int _numberOfStrips = concludeNumberOfPages();

      blog('_numberOfStrips : $_numberOfStrips');

      return HorizontalBouncer(
        key: const ValueKey<String>('HorizontalBouncer'),
        numberOfSlides: _numberOfStrips,
        controller: horizontalController,
        canNavigate: _canNavigateOnBounce(),
        onNavigate: (){
          blog('HorizontalBouncer : onNavigate');
          onHorizontalExit();
        },
        child: PageView.builder(
          // key: PageStorageKey<String>('FlyerSlides_PageView_${widget.heroTag}'),
          controller: horizontalController,
          physics: tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          // clipBehavior: Clip.antiAlias,
          // restorationId: 'FlyerSlides_PageView_${widget.heroTag}',
          onPageChanged: (int i) => onSwipeSlide(i),
          itemCount: _numberOfStrips+1,
          itemBuilder: (_, int index){

            /// WHEN AT FLYER REAL SLIDES
            if (index < _realNumberOfSlide){

              final SlideModel _slide = flyerModel.slides[index];

              blog('Building slide $index : ${_slide.slideIndex}');

              return SingleSlide(
                key: const ValueKey<String>('slide_key'),
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: flyerBoxHeight,
                slideModel: _slide,
                tinyMode: tinyMode,
                onSlideNextTap: onSlideNextTap,
                onSlideBackTap: onSlideBackTap,
                onDoubleTap: onDoubleTap,
                canTapSlide: canTapSlides,
                slideShadowIsOn: showSlidesShadows,
                blurLayerIsOn: showSlidesBlurLayers,
                canAnimateMatrix: canAnimateSlides,
                canUseFilter: canUseFilter,
                canPinch: canPinch,
              );
            }

            /// WHEN AT FAKE BOUNCER SLIDE
            else if (index == _numberOfStrips){
              return const SizedBox();
            }

            /// WHEN AT GALLERY SLIDE IF EXISTED
            else {
              return GallerySlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: flyerBoxHeight,
                flyerModel: flyerModel,
                bzModel: flyerModel.bzModel,
                heroTag: heroTag,
              );
            }

          },
        ),
      );

    }

    else {

      blog('Building loading flyer blue : slides are empty');

      return FlyerLoading(
        flyerBoxWidth: flyerBoxWidth,
        animate: true,
        boxColor: Colorz.cyan255,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
