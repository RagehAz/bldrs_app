import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:flutter/material.dart';
import 'slides_parts/single_slide.dart';

class Slides extends StatefulWidget {
  final List<SlideModel> slides;
  final String flyerID;
  final double flyerZoneWidth;
  final bool slidingIsOn;
  final Function sliding;
  final int currentSlideIndex;
  final Function swipeFlyer;

  Slides({
    @required this.slides,
    @required this.flyerID,
    @required this.flyerZoneWidth,
    @required this.slidingIsOn,
    @required this.sliding,
    @required this.currentSlideIndex,
    this.swipeFlyer,
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
    _slidesLength = widget.slides?.length ?? 0;
    _slidingController = PageController(viewportFraction: 1, initialPage: widget.currentSlideIndex, keepPage: true);
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
    print('------------------------- building slides with index ${widget.currentSlideIndex}');
// -----------------------------------------------------------------------------
    double _progressBarHeight = widget.flyerZoneWidth * 0.0125;
    double _headerHeight = Scale.superHeaderHeight(false, widget.flyerZoneWidth);
    double _footerHeight = Scale.superFlyerFooterHeight(widget.flyerZoneWidth);
    double _flyerHeight = Scale.superFlyerZoneHeight(context, widget.flyerZoneWidth);
    double _tapAreaHeight = _flyerHeight - (_headerHeight+_progressBarHeight+_footerHeight);
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, widget.flyerZoneWidth);
// -----------------------------------------------------------------------------
    // int _slideIndex = _currentSlideIndex >= _slidesLength ? 0 : _currentSlideIndex ;
// -----------------------------------------------------------------------------

    return
      _microMode == true || widget.slidingIsOn == false ?
      SingleSlide(
        flyerID: widget.flyerID,
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

          PageView(
            controller: _slidingController,
            allowImplicitScrolling: true,
            physics: NeverScrollableScrollPhysics(),
            pageSnapping: true,
            children: <Widget>[

              ...List.generate(_slidesLength, (i) => SingleSlide(
                flyerZoneWidth: widget.flyerZoneWidth,
                title: widget.slides[i].headline,
                picture: widget.slides[i].picture,
                saves: widget.slides[i].savesCount,
                shares: widget.slides[i].sharesCount,
                views: widget.slides[i].viewsCount,
                slideIndex : i,
                slideMode: SlideMode.View,
                flyerID: widget.flyerID,
              )),

            ],
          ),

          /// TAP AREAS
          Row(
            children: <Widget>[

              /// --- back tap area
              GestureDetector(
                onTap: (){
                  print('widget.currentSlideIndex was : ${widget.currentSlideIndex}');
                  int _newIndex = slideToBackAndGetNewIndex(_slidingController, widget.currentSlideIndex);

                  /// if its first slide swipe to last flyer
                  if (_newIndex == widget.currentSlideIndex){
                    widget.swipeFlyer(SlidingDirection.back);
                  }
                  /// if its a middle or last slide, slide to the new index
                  else {
                    widget.sliding(_newIndex);
                    print('widget.currentSlideIndex after sliding is : $_newIndex');
                  }

                  },
                child: Container(
                  width: widget.flyerZoneWidth * 0.25,
                  height: _tapAreaHeight,
                  margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
                  color: Colorz.Nothing,
                ),
              ),

              /// --- front tap area
              GestureDetector(
                onTap: (){
                  print('widget.currentSlideIndex was : ${widget.currentSlideIndex}');
                  int _newIndex = slideToNextAndGetNewIndex(_slidingController, _slidesLength, widget.currentSlideIndex);

                  /// if its last slide swipe to next flyer
                  if (_newIndex == widget.currentSlideIndex){
                    widget.swipeFlyer(SlidingDirection.next);
                  }
                  /// if its a middle or last slide, slide to the new index
                  else {
                    widget.sliding(_newIndex);
                    print('widget.currentSlideIndex after sliding is : $_newIndex');
                  }
                },
                child: Container(
                  width: widget.flyerZoneWidth * 0.75,
                  height: _tapAreaHeight,
                  margin: EdgeInsets.only(top: _headerHeight + _progressBarHeight),
                  color: Colorz.Nothing,
                ),
              ),

            ],
          ),

        ],
      );

  }
}
