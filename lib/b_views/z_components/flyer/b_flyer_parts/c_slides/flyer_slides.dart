import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/horizontal_bouncer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/gallery_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerSlides extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerSlides({
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
    @required this.currentSlideIndex,
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
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final Function onDoubleTap;
  final ValueNotifier currentSlideIndex;
  final String heroTag;
  final bool canShowGalleryPage;
  final int numberOfSlides;
  final bool inFlight;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerSlides> createState() => _FlyerSlidesState();
}

class _FlyerSlidesState extends State<FlyerSlides> with AutomaticKeepAliveClientMixin<FlyerSlides>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.flyerModel.slides.isEmpty){
      return Container(
        width: widget.flyerBoxWidth,
        height: widget.flyerBoxHeight,
        color: Colorz.white50,
      );
    }

    // else if (widget.inFlight == true){
    //   return SingleSlide(
    //     key: const ValueKey<String>('slide_key'),
    //     flyerBoxWidth: widget.flyerBoxWidth,
    //     flyerBoxHeight: widget.flyerBoxHeight,
    //     slideModel: widget.flyerModel.slides[0],
    //     tinyMode: widget.tinyMode,
    //     onSlideNextTap: widget.onSlideNextTap,
    //     onSlideBackTap: widget.onSlideBackTap,
    //     onDoubleTap: widget.onDoubleTap,
    //   );
    // }

    else {

      return HorizontalBouncer(
        numberOfSlides: widget.numberOfSlides,
        controller: widget.horizontalController,
        child: PageView.builder(
          key: PageStorageKey<String>('FlyerSlides_PageView_${widget.heroTag}'),
          controller: widget.horizontalController,
          physics: widget.tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          // clipBehavior: Clip.antiAlias,
          // restorationId: 'FlyerSlides_PageView_${widget.heroTag}',
          onPageChanged: (int i) => widget.onSwipeSlide(i),
          itemCount: widget.numberOfSlides + 1,
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
            else if (index == widget.numberOfSlides){
              return const SizedBox();
            }

            /// WHEN AT GALLERY SLIDE IF EXISTED
            else {

              return GallerySlide(
                flyerBoxWidth: widget.flyerBoxWidth,
                flyerBoxHeight: widget.flyerBoxHeight,
                flyerModel: widget.flyerModel,
                bzModel: widget.bzModel,
                heroTag: widget.heroTag,
              );

            }

          },
        ),
      );

    }

  }
}
