import 'package:bldrs/providers/combined_models/co_slide.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'slides_items/single_slide.dart';

class Slides extends StatefulWidget {
  final List<CoSlide> coSlides;
  final double flyerZoneWidth;
  final bool slidingIsOn;
  final Function sliding;
  final int currentSlideIndex;

  Slides({
    @required this.coSlides,
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
    int slideIndex = widget.currentSlideIndex >= widget.coSlides?.length ? 0 : widget.currentSlideIndex ;
    // ----------------------------------------------------------------------

    return
      microMode == true || widget.slidingIsOn == false ?
      SingleSlide(
        flyerZoneWidth: widget.flyerZoneWidth,
        title: widget.coSlides[0]?.slide?.headline,
        picture: widget.coSlides[0]?.slide?.picture,
        saves: widget.coSlides[0]?.savesCount,
        shares: widget.coSlides[0]?.sharesCount,
        views: widget.coSlides[0]?.horuseeCount,
        slideIndex: 0,
      )
          :
      // -- FLYER SLIDES
      PageView.builder(
        itemCount: widget.coSlides?.length,
        controller: PageController(viewportFraction: 1, initialPage: slideIndex, keepPage: true),
        allowImplicitScrolling: true,
        pageSnapping: true,
        onPageChanged: widget.sliding,
        // key: const PageStorageKey<String>('slide'),
        itemBuilder: (_, i) {

          return SingleSlide(
            flyerZoneWidth: widget.flyerZoneWidth,
            title: widget.coSlides[i].slide.headline,
            picture: widget.coSlides[i].slide.picture,
            saves: widget.coSlides[i].savesCount,
            shares: widget.coSlides[i].sharesCount,
            views: widget.coSlides[i].horuseeCount,
            slideIndex : i,
          );

          },

      );

  }
}
