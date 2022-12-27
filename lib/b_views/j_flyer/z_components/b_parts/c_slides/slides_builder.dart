import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/horizontal_bouncer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/gallery_slide/gallery_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class SlidesBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlidesBuilder({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.onDoubleTap,
    @required this.progressBarModel,
    @required this.flightDirection,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final String heroTag;
  final FlightDirection flightDirection;
  /// --------------------------------------------------------------------------
  @override
  State<SlidesBuilder> createState() => _SlidesBuilderState();
/// --------------------------------------------------------------------------
}

class _SlidesBuilderState extends State<SlidesBuilder> with AutomaticKeepAliveClientMixin<SlidesBuilder>{
  // -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
  // --------------------
  bool _canNavigateOnBounce(){
    bool _canNavigate;

    if (widget.flightDirection == FlightDirection.pop){
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
    super.build(context);

    if (widget.flyerModel.slides.isEmpty){

      blog('Building loading flyer blue : slides are empty');

      return FlyerLoading(
        flyerBoxWidth: widget.flyerBoxWidth,
        animate: true,
        boxColor: Colorz.cyan255,
      );

    }

    else {

      return ValueListenableBuilder(
        key: const ValueKey<String>('SlidesBuilder'),
        valueListenable: widget.progressBarModel,
          builder: (_, ProgressBarModel progModel, Widget gallerySlide){

          final int _count =
              /// keep one strip even if null
          progModel?.numberOfStrips  == null ? 1
              :
              /// when only one strip : add the fake box to activate horizontal hero swipe
          progModel?.numberOfStrips  == 1 ? 2
              :
              /// when one than 1 slide, do it normally
          progModel?.numberOfStrips;

            return HorizontalBouncer(
              numberOfSlides: progModel?.numberOfStrips,
              controller: widget.horizontalController,
              canNavigate: _canNavigateOnBounce(),
              child: PageView.builder(
                key: PageStorageKey<String>('FlyerSlides_PageView_${widget.heroTag}'),
                controller: widget.horizontalController,
                physics: widget.tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                // clipBehavior: Clip.antiAlias,
                // restorationId: 'FlyerSlides_PageView_${widget.heroTag}',
                onPageChanged: (int i) => widget.onSwipeSlide(i),
                itemCount: _count + 1,
                itemBuilder: (_, int index){

                  /// WHEN AT FLYER REAL SLIDES
                  if (index < widget.flyerModel.slides.length){

                    final SlideModel _slide = widget.flyerModel.slides[index];

                    return SingleSlide(
                      key: const ValueKey<String>('slide_key'),
                      flyerBoxWidth: widget.flyerBoxWidth,
                      flyerBoxHeight: widget.flyerBoxHeight,
                      slideModel: _slide,
                      tinyMode: widget.tinyMode,
                      onSlideNextTap: widget.onSlideNextTap,
                      onSlideBackTap: widget.onSlideBackTap,
                      onDoubleTap: widget.onDoubleTap,
                    );
                  }

                  /// WHEN AT FAKE BOUNCER SLIDE
                  else if (index == progModel.numberOfStrips){
                    return const SizedBox();
                  }

                  /// WHEN AT GALLERY SLIDE IF EXISTED
                  else {

                    return gallerySlide;

                  }

                },
              ),
            );

          },
        child: GallerySlide(
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: widget.flyerBoxHeight,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          heroTag: widget.heroTag,
        ),
      );

    }

  }
// -----------------------------------------------------------------------------
}
