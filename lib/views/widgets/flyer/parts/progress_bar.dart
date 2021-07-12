import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double flyerZoneWidth;
  final bool barIsOn;
  final int numberOfSlides;
  final int currentSlide;
  final EdgeInsets margins;
  final bool slidingNext;

  ProgressBar({
    @required this.flyerZoneWidth,
    this.barIsOn = true,
    @required this.numberOfSlides,
    this.currentSlide = 0,
    this.margins,
    @required this.slidingNext,
  });

  @override
  Widget build(BuildContext context) {
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
// -----------------------------------------------------------------------------
    double _boxWidth = flyerZoneWidth;
    double _boxHeight = flyerZoneWidth * Ratioz.xxProgressBarHeightRatio;
    EdgeInsets _boxMargins = margins == null ? EdgeInsets.only(top: flyerZoneWidth * 0.27) : margins;
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _allStripsOneSideMargin = (flyerZoneWidth - _allStripsLength) / 2;
    double _aStripThickness = flyerZoneWidth * 0.007;
    double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / _numberOfSlides);
    Color _stripColor = Colorz.White80;
    double _stripCorner = _aStripThickness * 0.5;
    Color _currentStripColor = numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);
// -----------------------------------------------------------------------------
    double _beginGoingNext = 0;
    double _endGoingNext = _aStripLength;

    double _beginGoingPrevious = _aStripLength;
    double _endGoingPrevious = 0;
    // --------------------------------------------------------o
    Tween _tween(){
      Tween _tween;

      /// GOING NEXT
      if(slidingNext == null || slidingNext == true){
        _tween = Tween<double>(begin: _beginGoingNext, end: _endGoingNext);
      }
      /// GOING PREVIOUS
      else {
        _tween = Tween<double>(begin: _beginGoingPrevious, end: _endGoingPrevious);
      }

      return _tween;
    }
// -----------------------------------------------------------------------------
    int _numberOfWhiteStrips(){
      int _numberOfStrips;
      bool _goingNext = slidingNext == null || slidingNext == true ? true : false;
      /// A - at first slide
      if(currentSlide == 0){
        /// B - GOING NEXT
        if(_goingNext){
          print('at first slide going next');
          _numberOfStrips = 1;
        }
        /// B - GOING PREVIOUS
        else{
          print('at first slide going previous');
          _numberOfStrips = 2;
        }
      }
      // --------------------------------------------------------o
      /// A - at last slide
      else if (currentSlide + 1 == numberOfSlides){

        /// B - GOING NEXT
        if(_goingNext){
          print('at last slide going next');
          _numberOfStrips = numberOfSlides;
        }
        /// B - GOING PREVIOUS
        else{
          print('at last slide going previous');
          _numberOfStrips = currentSlide + 3;
        }
      }
      /// A - at middle slides
      else {
        /// B - GOING NEXT
        if(_goingNext){
          print('at middle slide going next');
          _numberOfStrips = currentSlide + 1;
        }
        /// B - GOING PREVIOUS
        else{
          print('at middle slide going previous');
          _numberOfStrips = currentSlide + 2;
        }
      }

      return _numberOfStrips;
    }

    return
      _microMode == true || barIsOn == false  ?
      Container()
          :
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
            children: <Widget>[

              /// --- BASE STRIP
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_numberOfSlides, (index) {

                  // --- PROGRESS BAR BASE STRIP
                  return
                    Strip(
                      flyerZoneWidth: flyerZoneWidth,
                      stripWidth: _aStripLength,
                      numberOfSlides: numberOfSlides,
                      margins: margins,
                      isWhite: false,
                    );

                }),
              ),

              /// --- TOP STRIP
              TweenAnimationBuilder<double>(
                duration: Ratioz.fadingDuration,
                tween: _tween(),
                curve: Curves.easeOut,
                onEnd: (){},
                key: ValueKey(currentSlide),
                builder: (BuildContext context,double tweenVal, Widget child){
                  return
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          ...List.generate(_numberOfWhiteStrips(), (index) {
                            print('numberOfSlides : $numberOfSlides ,currentSlide : $currentSlide, index : $index, _numberOfWhiteStrips() : ${_numberOfWhiteStrips()}' );

                            return
                              /// IF ITS LAST STRIP
                              index == currentSlide ?
                              Strip(
                                flyerZoneWidth: flyerZoneWidth,
                                stripWidth: tweenVal,
                                numberOfSlides: numberOfSlides,
                                isWhite: true,
                              )
                                  :
                              /// IF STATIC STRIPS
                              Strip(
                                flyerZoneWidth: flyerZoneWidth,
                                stripWidth: _aStripLength,
                                numberOfSlides: numberOfSlides,
                                isWhite: true,
                              );

                          }),
                        ],
                      ),
                    );

                  },
              ),


            ],
          ),
    ),
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
    double _boxWidth = flyerZoneWidth;
    double _boxHeight = flyerZoneWidth * Ratioz.xxProgressBarHeightRatio;
    EdgeInsets _boxMargins = margins == null ? EdgeInsets.only(top: flyerZoneWidth * 0.27) : margins;
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _allStripsOneSideMargin = (flyerZoneWidth - _allStripsLength) / 2;
    double _aStripThickness = flyerZoneWidth * 0.007;
    double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / _numberOfSlides);
    double _stripCorner = _aStripThickness * 0.5;
    Color _stripColor = !isWhite ? Colorz.White80 : numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
// -----------------------------------------------------------------------------
    return Flexible(
      child: Container(
        width: stripWidth,
        height: _aStripThickness,
        padding: EdgeInsets.symmetric(horizontal: _aStripOnePadding),
        // color: Colorz.BloodTest,
        child: Container(
          width: _aStripLength - (2 * _aStripOnePadding),
          height: _aStripThickness,
          decoration: BoxDecoration(
              color: _stripColor,
              borderRadius: Borderers.superBorderAll(context, _stripCorner)
          ),
        ),
      ),
    );
  }
}
