import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'slides_parts/single_slide.dart';

class Slides extends StatefulWidget {
  final List<SlideModel> slides;
  final double flyerZoneWidth;
  final bool slidingIsOn;
  final Function sliding;
  final int currentSlideIndex;

  Slides({
    @required this.slides,
    @required this.flyerZoneWidth,
    @required this.slidingIsOn,
    @required this.sliding,
    this.currentSlideIndex,
});

  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------------------
    bool microMode = superFlyerMicroMode(context, widget.flyerZoneWidth);
    // ----------------------------------------------------------------------
    int slideIndex = widget.currentSlideIndex >= widget.slides?.length ? 0 : widget.currentSlideIndex ;
    // ----------------------------------------------------------------------

    return
      microMode == true || widget.slidingIsOn == false ?
      SingleSlide(
        flyerZoneWidth: widget.flyerZoneWidth,
        title: widget.slides[0]?.headline,
        picture: widget.slides[0]?.picture,
        saves: widget.slides[0]?.savesCount,
        shares: widget.slides[0]?.sharesCount,
        views: widget.slides[0]?.viewsCount,
        slideIndex: 0,
        slideMode: SlideMode.View,
      )
          :
      // -- FLYER SLIDES
      PageView.builder(
        itemCount: widget.slides?.length,
        controller: PageController(viewportFraction: 1, initialPage: slideIndex, keepPage: true),
        allowImplicitScrolling: true,
        pageSnapping: true,
        onPageChanged: widget.sliding,
        // key: const PageStorageKey<String>('slide'),
        itemBuilder: (_, i) {

          return SingleSlide(
            flyerZoneWidth: widget.flyerZoneWidth,
            title: widget.slides[i].headline,
            picture: widget.slides[i].picture,
            saves: widget.slides[i].savesCount,
            shares: widget.slides[i].sharesCount,
            views: widget.slides[i].viewsCount,
            slideIndex : i,
            slideMode: SlideMode.View,
          );

          },

      );

  }
}
