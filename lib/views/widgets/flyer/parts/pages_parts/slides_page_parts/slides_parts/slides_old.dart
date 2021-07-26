import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';

/// TASK : try InteractiveViewer() in slides to zoom and pan
class Slides extends StatefulWidget {
  final SuperFlyer superFlyer;
  // final List<SlideModel> slides;
  // final String flyerID;
  // final double flyerZoneWidth;
  // final bool listenToSwipe;
  // final Function onHorizontalSlideSwipe;
  // final int currentSlideIndex;
  // final Function onSwipeFlyer;
  // final Function onTap;

  Slides({
    @required this.superFlyer,
    // @required this.slides,
    // @required this.flyerID,
    // @required this.flyerZoneWidth,
    // @required this.listenToSwipe,
    // @required this.onHorizontalSlideSwipe,
    // @required this.currentSlideIndex,
    // this.onSwipeFlyer,
    // @required this.onTap,
});

  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  // int _currentSlideIndex;
  int _slidesLength;
  PageController _slidingController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _currentSlideIndex = widget.currentSlideIndex;
    _slidesLength = widget.superFlyer.slides?.length ?? 0;
    _slidingController = PageController(viewportFraction: 1, initialPage: widget.superFlyer.currentSlideIndex, keepPage: true);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _slidingController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    print('------------------------- building slides with index ${widget.superFlyer.currentSlideIndex}');
// -----------------------------------------------------------------------------
    double _progressBarHeight = widget.superFlyer.flyerZoneWidth * 0.0125;
    double _headerHeight = Scale.superHeaderHeight(false, widget.superFlyer.flyerZoneWidth);
    double _footerHeight = FlyerFooter.boxHeight(context: context, flyerZoneWidth: widget.superFlyer.flyerZoneWidth);
    double _flyerHeight = Scale.superFlyerZoneHeight(context, widget.superFlyer.flyerZoneWidth);
    double _tapAreaHeight = _flyerHeight - (_headerHeight+_progressBarHeight+_footerHeight);
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, widget.superFlyer.flyerZoneWidth);
// -----------------------------------------------------------------------------
    // int _slideIndex = _currentSlideIndex >= _slidesLength ? 0 : _currentSlideIndex ;
// -----------------------------------------------------------------------------

    return
      _microMode == true || widget.superFlyer.listenToSwipe == false ?
      SingleSlide(
        flyerID: widget.superFlyer.flyerID,
        flyerZoneWidth: widget.superFlyer.flyerZoneWidth,
        title: widget.superFlyer.slides[0]?.headline,
        picture: widget.superFlyer.slides[0]?.picture,
        saves: widget.superFlyer.slides[0]?.savesCount,
        shares: widget.superFlyer.slides[0]?.sharesCount,
        views: widget.superFlyer.slides[0]?.viewsCount,
        slideIndex: 0,
        onTap: widget.superFlyer.onTinyFlyerTap,
        slideMode: SlideMode.View,
      )
          :
      // -- FLYER SLIDES
      Stack(
        children: <Widget>[

          // PageView.builder(
          //   itemCount: _slidesLength,
          //   controller: _slidingController,
          //   allowImplicitScrolling: false,
          //   physics: NeverScrollableScrollPhysics(),
          //
          //   pageSnapping: true,
          //   // onPageChanged: (int){
          //   //   widget.sliding(int);
          //   //   print(int);
          //   // },
          //   // key: const PageStorageKey<String>('slide'),
          //   itemBuilder: (_, i) {
          //
          //     return SingleSlide(
          //       flyerZoneWidth: widget.flyerZoneWidth,
          //       title: widget.slides[i].headline,
          //       picture: widget.slides[i].picture,
          //       saves: widget.slides[i].savesCount,
          //       shares: widget.slides[i].sharesCount,
          //       views: widget.slides[i].viewsCount,
          //       slideIndex : i,
          //       slideMode: SlideMode.View,
          //       flyerID: widget.flyerID,
          //     );
          //
          //   },
          //
          // ),

          if (widget.superFlyer.slides.length > 1)
          PageView(
            controller: _slidingController,
            allowImplicitScrolling: true,
            physics: const BouncingScrollPhysics(),
            pageSnapping: true,
            onPageChanged: (i) => widget.superFlyer.onHorizontalSlideSwipe(i),
            children: <Widget>[

              ...List.generate(_slidesLength, (i) => SingleSlide(
                flyerZoneWidth: widget.superFlyer.flyerZoneWidth,
                title: widget.superFlyer.slides[i].headline,
                picture: widget.superFlyer.slides[i].picture,
                saves: widget.superFlyer.slides[i].savesCount,
                shares: widget.superFlyer.slides[i].sharesCount,
                views: widget.superFlyer.slides[i].viewsCount,
                slideIndex : i,
                slideMode: SlideMode.View,
                flyerID: widget.superFlyer.flyerID,
                onTap: (){
                  print('on single slide tap inside slides old thing');
                },
              )),

            ],
          ),

          /// TAP AREAS
          Row(
            children: <Widget>[

              /// --- back tap area
              GestureDetector(
                onTap: () async {
                  print('widget.currentSlideIndex was : ${widget.superFlyer.currentSlideIndex}');
                  int _newIndex = await Sliders.slideToBackAndGetNewIndex(_slidingController, widget.superFlyer.currentSlideIndex);

                  /// if its first slide swipe to last flyer
                  if (_newIndex == widget.superFlyer.currentSlideIndex){
                    widget.superFlyer.onSwipeFlyer(SwipeDirection.back);
                  }
                  /// if its a middle or last slide, slide to the new index
                  else {
                    widget.superFlyer.onHorizontalSlideSwipe(_newIndex);
                    print('widget.currentSlideIndex after sliding is : $_newIndex');
                  }

                  },
                child: Container(
                  width: widget.superFlyer.flyerZoneWidth * 0.25,
                  height: _tapAreaHeight,
                  margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
                  color: Colorz.Nothing,
                ),
              ),

              // /// --- front tap area
              // GestureDetector(
              //   onTap: () async {
              //     print('widget.currentSlideIndex was : ${widget.currentSlideIndex}');
              //     int _newIndex = await Sliders.slideToNextAndGetNewIndex(_slidingController, _slidesLength, widget.currentSlideIndex);
              //
              //     /// if its last slide swipe to next flyer
              //     if (_newIndex == widget.currentSlideIndex){
              //       widget.swipeFlyer(SwipeDirection.next);
              //     }
              //     /// if its a middle or last slide, slide to the new index
              //     else {
              //       widget.sliding(_newIndex);
              //       print('widget.currentSlideIndex after sliding is : $_newIndex');
              //     }
              //   },
              //   child: Container(
              //     width: widget.flyerZoneWidth * 0.75,
              //     height: _tapAreaHeight,
              //     margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
              //     color: Colorz.Nothing,
              //   ),
              // ),

            ],
          ),

        ],
      );

  }
}
