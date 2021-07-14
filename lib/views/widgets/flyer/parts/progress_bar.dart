import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double flyerZoneWidth;
  final bool barIsOn;
  final int numberOfStrips;
  final int slideIndex;
  final EdgeInsets margins;
  final bool slidingNext;

  ProgressBar({
    @required this.flyerZoneWidth,
    this.barIsOn = true,
    @required this.numberOfStrips,
    this.slideIndex = 0,
    this.margins,
    @required this.slidingNext,
  });

  @override
  Widget build(BuildContext context) {
    print('========= BUILDING PROGRESS BAR FOR ||| index : $slideIndex, numberOfSlides : $numberOfStrips');

    // int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
// -----------------------------------------------------------------------------
    double _boxWidth = flyerZoneWidth;
    double _boxHeight = flyerZoneWidth * Ratioz.xxProgressBarHeightRatio;
    EdgeInsets _boxMargins = margins == null ? EdgeInsets.only(top: flyerZoneWidth * 0.27) : margins;
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _allStripsOneSideMargin = (flyerZoneWidth - _allStripsLength) / 2;
    // double _aStripThickness = flyerZoneWidth * 0.007;
    // double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / numberOfStrips);
    // Color _stripColor = Colorz.White80;
    // double _stripCorner = _aStripThickness * 0.5;
    // Color _currentStripColor = numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);
// -----------------------------------------------------------------------------
    Tween _tween(){
      Tween _tween;

      /// GOING NEXT
      if(slidingNext == null || slidingNext == true){
        _tween = Tween<double>(begin: 0, end: _aStripLength);
      }
      /// GOING PREVIOUS
      else {
        _tween = Tween<double>(begin: _aStripLength, end: 0);
      }

      return _tween;
    }
// -----------------------------------------------------------------------------
    int _numberOfWhiteStrips(){
      // -----------------------------------------o
      int _numberOfStrips;
      bool _goingNext = slidingNext == null || slidingNext == true ? true : false;
      // -----------------------------------------o
      /// A - at first slide
      if(slideIndex == 0){
        /// B - GOING NEXT
        if(_goingNext){
          // print('1 at first slide going next');
          _numberOfStrips = 1;
        }
        /// B - GOING PREVIOUS
        else{
          // print('2 at first slide going previous');
          _numberOfStrips = 2;
        }
      }
      // -----------------------------------------o
      /// A - at last slide
      else if (slideIndex + 1 == numberOfStrips){

        /// B - GOING NEXT
        if(_goingNext){
          // print('3 at last slide going next');
          _numberOfStrips = numberOfStrips;
        }
        /// B - GOING PREVIOUS
        else{
          // print('4 at last slide going previous');
          _numberOfStrips = slideIndex + 3;
        }
      }
      /// A - at middle slides
      // -----------------------------------------o
      else {
        /// B - GOING NEXT
        if(_goingNext){
          // print('5 at middle slide going next');
          _numberOfStrips = slideIndex + 1;
        }
        /// B - GOING PREVIOUS
        else{
          // print('6 at middle slide going previous');
          _numberOfStrips = slideIndex + 2;
        }
      }
      // -----------------------------------------o
      return _numberOfStrips;
    }
// -----------------------------------------------------------------------------
    Widget _progressBox({List<Widget> children}){
      return
        Align(
          alignment: Aligners.superTopAlignment(context),
          child: Container(
            width: _boxWidth,
            height: _boxHeight,
            margin: _boxMargins,
            padding: EdgeInsets.symmetric(horizontal: _allStripsOneSideMargin),
            alignment: Alignment.center,
            child: Stack(
              alignment: Aligners.superCenterAlignment(context),
              children: children,
            ),
          ),
        );
    }
// -----------------------------------------------------------------------------
    return
      _microMode == true || barIsOn == false  ?
      Container()

      :

      numberOfStrips == 1 ?
      _progressBox(
        children: <Widget>[
          Strip(
              flyerZoneWidth: flyerZoneWidth,
              stripWidth: _allStripsLength,
              numberOfSlides: 1,
              isWhite: true
          ),
        ]
      )

          :

      _progressBox(
        children: <Widget>[

          /// --- BASE STRIP
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(numberOfStrips, (index) {

              return
                Strip(
                  flyerZoneWidth: flyerZoneWidth,
                  stripWidth: _aStripLength,
                  numberOfSlides: numberOfStrips,
                  margins: margins,
                  isWhite: false,
                );

            }),
          ),

          /// --- TOP STRIP
          TweenAnimationBuilder<double>(
            duration: Ratioz.duration150ms,
            tween: _tween(),
            curve: Curves.easeOut,
            // onEnd: (){},
            key: ValueKey(slideIndex),
            builder: (BuildContext context,double tweenVal, Widget child){
              return
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      ...List.generate(_numberOfWhiteStrips(), (index) {
                        // print('numberOfSlides : $numberOfSlides ,currentSlide : $currentSlide, index : $index, _numberOfWhiteStrips() : ${_numberOfWhiteStrips()}' );

                        return
                          /// IF ITS LAST STRIP
                          index == slideIndex ?
                          Strip(
                            flyerZoneWidth: flyerZoneWidth,
                            stripWidth: tweenVal,
                            numberOfSlides: numberOfStrips,
                            isWhite: true,
                          )
                              :
                          /// IF STATIC STRIPS
                          Strip(
                            flyerZoneWidth: flyerZoneWidth,
                            stripWidth: _aStripLength,
                            numberOfSlides: numberOfStrips,
                            isWhite: true,
                          );

                      }),
                    ],
                  ),
                );

            },
          ),

        ]
      );
  }
}

class Strip extends StatelessWidget {
  final double flyerZoneWidth;
  final double stripWidth;
  final int numberOfSlides;
  final EdgeInsets margins;
  final bool isWhite;

  Strip({
    @required this.flyerZoneWidth,
    @required this.stripWidth,
    @required this.numberOfSlides,
    this.margins,
    @required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
// -----------------------------------------------------------------------------
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _aStripThickness = flyerZoneWidth * 0.007;
    double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / _numberOfSlides);
    double _stripCorner = _aStripThickness * 0.5;
    Color _stripColor = !isWhite ? Colorz.White80 : numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
// -----------------------------------------------------------------------------
    return Container(
      width: stripWidth,
      height: _aStripThickness,
      padding: EdgeInsets.symmetric(horizontal: _aStripOnePadding),
      child: Container(
        width: _aStripLength - (2 * _aStripOnePadding),
        height: _aStripThickness,
        decoration: BoxDecoration(
            color: _stripColor,
            borderRadius: Borderers.superBorderAll(context, _stripCorner)
        ),
      ),
    );
  }
}
