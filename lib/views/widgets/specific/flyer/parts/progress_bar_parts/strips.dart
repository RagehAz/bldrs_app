import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar_parts/strip.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';

class ProgressBox extends StatelessWidget {
  final double flyerBoxWidth;
  final List<Widget> strips;
  final EdgeInsets margins;

  const ProgressBox({
    @required this.flyerBoxWidth,
    @required this.strips,
    @required this.margins,
});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Aligners.superTopAlignment(context),
      child: Container(
        width: Strips.boxWidth(flyerBoxWidth),
        height: Strips.boxHeight(flyerBoxWidth),
        margin: Strips.boxMargins(flyerBoxWidth: flyerBoxWidth, margins: margins),
        padding: EdgeInsets.symmetric(horizontal: Strips.stripsOneSideMargin(flyerBoxWidth)),
        alignment: Alignment.center,
        // color: Colorz.BloodTest,
        child: Stack(
          alignment: Aligners.superCenterAlignment(context),
          children: strips,
        ),
      ),
    );
  }
}


class Strips extends StatelessWidget {
  final double flyerBoxWidth;
  final bool barIsOn;
  final int numberOfStrips;
  final int slideIndex;
  final EdgeInsets margins;
  final SwipeDirection swipeDirection;

  Strips({
    @required this.flyerBoxWidth,
    this.barIsOn = true,
    @required this.numberOfStrips,
    this.slideIndex = 0,
    this.margins,
    @required this.swipeDirection,
  });
// -----------------------------------------------------------------------------
  static double boxWidth(double flyerBoxWidth){
    return flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  static double boxHeight(double flyerBoxWidth){
    double _boxHeight = flyerBoxWidth * Ratioz.xxProgressBarHeightRatio;
    return _boxHeight;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets boxMargins({EdgeInsets margins, double flyerBoxWidth}){
    EdgeInsets _boxMargins = margins == null ? EdgeInsets.only(top: flyerBoxWidth * 0.27) : margins;
    return _boxMargins;
  }
// -----------------------------------------------------------------------------
  static double stripsTotalLength(double flyerBoxWidth){
    double _stripsTotalLength = flyerBoxWidth * 0.895;
    return _stripsTotalLength;
  }
// -----------------------------------------------------------------------------
  static double stripThickness(double flyerBoxWidth){
    double _thickness = flyerBoxWidth * 0.007;
    return _thickness;
  }
// -----------------------------------------------------------------------------
  static double stripCornerValue(double flyerBoxWidth){
    double _thickness = stripThickness(flyerBoxWidth);
    double _stripCorner = _thickness * 0.5;
    return _stripCorner;
  }
// -----------------------------------------------------------------------------
  static BorderRadius stripBorders({BuildContext context, double flyerBoxWidth}){
    double _stripCorner = stripCornerValue(flyerBoxWidth);
    BorderRadius _borders = Borderers.superBorderAll(context, _stripCorner);
    return _borders;
  }
// -----------------------------------------------------------------------------
  static double stripsOneSideMargin(double flyerBoxWidth){
    double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    double _allStripsOneSideMargin = (flyerBoxWidth - _stripsTotalLength) / 2;
    return _allStripsOneSideMargin;
  }
// -----------------------------------------------------------------------------
  static double oneStripLength({double flyerBoxWidth, int numberOfStrips}){
    double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    int _numberOfStrips = numberOfStrips == null ? 0 : numberOfStrips;
    double _oneStripLength = (_stripsTotalLength / _numberOfStrips);
    return _oneStripLength;
  }
// -----------------------------------------------------------------------------
  static Color stripOffColor = Colorz.White10;
  static Color stripFadedColor = Colorz.White80;
  static Color stripOnColor = Colorz.White200;
  static Color stripLoadingColor = Colorz.Yellow200;

  static Color stripColor({bool isWhite, int numberOfSlides,}){
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;

    Color _stripColor =
    !isWhite ? stripFadedColor :
    _numberOfSlides == 0 ? stripOffColor :
    stripOnColor;

    return _stripColor;
  }
// -----------------------------------------------------------------------------
  static bool canBuildStrips(int numberOfStrips){
    bool _canBuild = false;

    if(numberOfStrips !=null){
      if(numberOfStrips > 0){
        _canBuild = true;
      }
    }

    return _canBuild;
  }

  @override
  Widget build(BuildContext context) {
    // print('========= BUILDING PROGRESS BAR FOR ||| index : $slideIndex, numberOfSlides : $numberOfStrips, slidingNext $swipeDirection');

    // int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
    // double _aStripThickness = flyerBoxWidth * 0.007;
    // double _aStripOnePadding = _aStripThickness / 2;
    // Color _stripColor = Colorz.White80;
    // double _stripCorner = _aStripThickness * 0.5;
    // Color _currentStripColor = numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
    // double _boxWidth = boxWidth(flyerBoxWidth);
    // double _boxHeight = boxHeight(flyerBoxWidth);
// -----------------------------------------------------------------------------
//     EdgeInsets _boxMargins = boxMargins(margins: margins, flyerBoxWidth: flyerBoxWidth);
    double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    // double _allStripsOneSideMargin = stripsOneSideMargin(flyerBoxWidth);
    double _aStripLength = oneStripLength(flyerBoxWidth: flyerBoxWidth, numberOfStrips: numberOfStrips);
// -----------------------------------------------------------------------------
    bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    Tween _tween(){
      Tween _tween;

      /// NO TWEEN
      if (swipeDirection == SwipeDirection.freeze){
        _tween = Tween<double>(begin: _aStripLength, end: _aStripLength);
      }
      /// GOING NEXT
      else if(swipeDirection == SwipeDirection.next){
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
      SwipeDirection _swipeDirection = swipeDirection;
      // -----------------------------------------o
      /// A - at first slide
      if(slideIndex == 0){

        /// B - FREEZING
        if(_swipeDirection == SwipeDirection.freeze){
          // print('1 at first slide frozen');
          _numberOfStrips = 1;
        }
        /// B - GOING NEXT
        else if(_swipeDirection == SwipeDirection.next){
          // print('1 at first slide going next');
          _numberOfStrips = 1;
        }
        /// B - GOING PREVIOUS
        else if (_swipeDirection == SwipeDirection.back){
          // print('2 at first slide going previous');
          _numberOfStrips = 2;
        }
      }
      // -----------------------------------------o
      /// A - at last slide
      else if (slideIndex + 1 == numberOfStrips){

        /// B - FREEZING
        if(_swipeDirection == SwipeDirection.freeze){
          // print('3- at last slide frozen');
          _numberOfStrips = numberOfStrips;
        }
        /// B - GOING NEXT
        else if(_swipeDirection == SwipeDirection.next){
          // print('3 at last slide going next');
          _numberOfStrips = numberOfStrips;
        }
        /// B - GOING PREVIOUS
        else{
          // print('4 at last slide going previous');
          _numberOfStrips = slideIndex + 3;
        }
      }
      // -----------------------------------------o
      /// A - at middle slides
      // -----------------------------------------o
      else {
        /// B - FREEZING
        if(_swipeDirection == SwipeDirection.freeze){
          // print('5 at middle slide frozen');
          _numberOfStrips = slideIndex + 1;
        }
        /// B - GOING NEXT
        else if(_swipeDirection == SwipeDirection.next){
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
    return
      _tinyMode == true || barIsOn == false  ?
      Container()

          :

      numberOfStrips == 1 ?
      ProgressBox(
          flyerBoxWidth: flyerBoxWidth,
          margins: margins,
          strips: <Widget>[
            Strip(
                flyerBoxWidth: flyerBoxWidth,
                stripWidth: _stripsTotalLength,
                numberOfSlides: 1,
                isWhite: true
            ),
          ]
      )

          :

      ProgressBox(
          flyerBoxWidth: flyerBoxWidth,
          margins: margins,
          strips: <Widget>[

            /// --- BASE STRIP
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(numberOfStrips, (index) {

                return
                  Strip(
                    flyerBoxWidth: flyerBoxWidth,
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

                double _tweenVal = swipeDirection == SwipeDirection.freeze ? _aStripLength : tweenVal;

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
                            // index == slideIndex ?
                            index + 1 == _numberOfWhiteStrips()?
                            Strip(
                              flyerBoxWidth: flyerBoxWidth,
                              stripWidth: _tweenVal,
                              numberOfSlides: numberOfStrips,
                              isWhite: true,
                            )
                                :
                            /// IF STATIC STRIPS
                            Strip(
                              flyerBoxWidth: flyerBoxWidth,
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
