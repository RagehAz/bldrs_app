import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/b_gallery_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/z_components/layouts/navigation/horizontal_bouncer.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:flutter/material.dart';

class SlidesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesBuilder({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.tinyMode,
    required this.flyerModel,
    required this.slidePicType,
    required this.horizontalController,
    required this.onSwipeSlide,
    required this.onSlideNextTap,
    required this.onSlideBackTap,
    required this.onDoubleTap,
    required this.progressBarModel,
    required this.flightDirection,
    required this.heroTag,
    required this.canTapSlides,
    required this.showSlidesShadows,
    required this.canAnimateSlides,
    required this.canPinch,
    required this.showGallerySlide,
    required this.onVerticalExit,
    required this.activePhid,
    this.onHorizontalExit,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel? flyerModel;
  final SlidePicType slidePicType;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final String heroTag;
  final FlightDirection flightDirection;
  final Function? onHorizontalExit;
  final Function? onVerticalExit;
  final bool canTapSlides;
  final bool showSlidesShadows;
  final bool canAnimateSlides;
  final bool canPinch;
  final bool showGallerySlide;
  final ValueNotifier<String?> activePhid;
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

    if (Lister.checkCanLoop(flyerModel?.slides) == true){

      final int _realNumberOfSlide = flyerModel?.slides?.length ?? 0;
      final int _numberOfStrips = concludeNumberOfPages();

      return HorizontalBouncer(
        key: const ValueKey<String>('HorizontalBouncer'),
        numberOfSlides: _numberOfStrips,
        controller: horizontalController,
        canNavigate: _canNavigateOnBounce(),
        onNavigate: onHorizontalExit,
        child: PageView.builder(
          key: const ValueKey<String>('FlyerSlides_PageView'),
          controller: horizontalController,
          scrollBehavior: const AppScrollBehavior(),
          physics: tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          onPageChanged: (int i) => onSwipeSlide(i),
          itemCount: _numberOfStrips,
          itemBuilder: (_, int index){

            /// WHEN AT FLYER REAL SLIDES
            if (index < _realNumberOfSlide){

              final SlideModel _slide = flyerModel!.slides![index];

              return SingleSlide(
                key: const ValueKey<String>('SingleSlide'),
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: flyerBoxHeight,
                slideModel: _slide,
                slidePicType: slidePicType,
                loading: false,
                tinyMode: tinyMode,
                onSlideNextTap: onSlideNextTap,
                onSlideBackTap: onSlideBackTap,
                onDoubleTap: onDoubleTap,
                canTapSlide: canTapSlides,
                slideShadowIsOn: showSlidesShadows,
                // canAnimateMatrix: _slide.animationCurve != null,// && canAnimateSlides == true,
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
                flyerModel: flyerModel!,
                bzModel: flyerModel!.bzModel!,
                heroTag: heroTag,
                onMaxBounce: onVerticalExit!,
                activePhid: activePhid,
              );
            }

          },
        ),
      );

    }

    else {

      return FlyerLoading(
        flyerBoxWidth: flyerBoxWidth,
        animate: false,
        boxColor: Colorz.cyan255,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
