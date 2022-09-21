import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/progress_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strip.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StaticStrips extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticStrips({
    @required this.flyerBoxWidth,
    @required this.numberOfStrips,
    @required this.swipeDirection,
    this.barIsOn = true,
    this.slideIndex = 0,
    this.margins,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool barIsOn;
  final int numberOfStrips;
  final int slideIndex;
  final EdgeInsets margins;
  final SwipeDirection swipeDirection;
  /// --------------------------------------------------------------------------
  static double boxWidth(double flyerBoxWidth) {
    return flyerBoxWidth;
  }
  // --------------------
  static double boxHeight(double flyerBoxWidth) {
    final double _boxHeight = flyerBoxWidth * Ratioz.xxProgressBarHeightRatio;
    return _boxHeight;
  }
  // --------------------
  static EdgeInsets boxMargins({
    EdgeInsets margins,
    double flyerBoxWidth,
  }) {
    final EdgeInsets _boxMargins = margins ?? EdgeInsets.only(top: flyerBoxWidth * 0.27);
    return _boxMargins;
  }
  // --------------------
  static double stripsTotalLength(double flyerBoxWidth) {
    final double _stripsTotalLength = flyerBoxWidth * 0.895;
    return _stripsTotalLength;
  }
  // --------------------
  static double stripThickness(double flyerBoxWidth) {
    final double _thickness = flyerBoxWidth * 0.007;
    return _thickness;
  }
  // --------------------
  static double stripCornerValue(double flyerBoxWidth) {
    final double _thickness = stripThickness(flyerBoxWidth);
    final double _stripCorner = _thickness * 0.5;
    return _stripCorner;
  }
  // --------------------
  static BorderRadius stripBorders({
    BuildContext context,
    double flyerBoxWidth,
  }) {
    final double _stripCorner = stripCornerValue(flyerBoxWidth);
    final BorderRadius _borders = Borderers.superBorderAll(context, _stripCorner);
    return _borders;
  }
  // --------------------
  static double stripsOneSideMargin(double flyerBoxWidth) {
    final double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    final double _allStripsOneSideMargin = (flyerBoxWidth - _stripsTotalLength) / 2;
    return _allStripsOneSideMargin;
  }
  // --------------------
  static double oneStripLength({double flyerBoxWidth, int numberOfStrips}) {
    final double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    final int _numberOfStrips = numberOfStrips ?? 0;
    final double _oneStripLength = _stripsTotalLength / _numberOfStrips;
    return _oneStripLength;
  }
  // --------------------
  static const Color stripOffColor = Colorz.white10;
  static const Color stripFadedColor = Colorz.white80;
  static const Color stripOnColor = Colorz.white200;
  static const Color stripLoadingColor = Colorz.yellow200;
  // --------------------
  static Color stripColor({
    bool isWhite,
    int numberOfSlides,
  }) {
    final int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;

    final Color _stripColor = !isWhite ?
    stripFadedColor
        :
    _numberOfSlides == 0 ? stripOffColor
        :
    stripOnColor;

    return _stripColor;
  }
  // --------------------
  static bool canBuildStrips(int numberOfStrips) {
    bool _canBuild = false;

    if (numberOfStrips != null) {
      if (numberOfStrips > 0) {
        _canBuild = true;
      }
    }

    return _canBuild;
  }
  // --------------------
  int _getNumberOfWhiteStrips() {
    // -----------------------------------------o
    int _numberOfStrips;
    final SwipeDirection _swipeDirection = swipeDirection;
    // -----------------------------------------o
    /// A - at first slide
    if (slideIndex == 0) {
      /// B - FREEZING
      if (_swipeDirection == SwipeDirection.freeze) {
        // print('1 at first slide frozen');
        _numberOfStrips = 1;
      }

      /// B - GOING NEXT
      else if (_swipeDirection == SwipeDirection.next) {
        // print('1 at first slide going next');
        _numberOfStrips = 1;
      }

      /// B - GOING PREVIOUS
      else if (_swipeDirection == SwipeDirection.back) {
        // print('2 at first slide going previous');
        _numberOfStrips = 2;
      }
    }
    // -----------------------------------------o
    /// A - at last slide
    else if (slideIndex + 1 == numberOfStrips) {
      /// B - FREEZING
      if (_swipeDirection == SwipeDirection.freeze) {
        // print('3- at last slide frozen');
        _numberOfStrips = numberOfStrips;
      }

      /// B - GOING NEXT
      else if (_swipeDirection == SwipeDirection.next) {
        // print('3 at last slide going next');
        _numberOfStrips = numberOfStrips;
      }

      /// B - GOING PREVIOUS
      else {
        // print('4 at last slide going previous');
        _numberOfStrips = slideIndex + 3;
      }
    }
    // -----------------------------------------o
    /// A - at middle slides
    // -----------------------------------------o
    else {
      /// B - FREEZING
      if (_swipeDirection == SwipeDirection.freeze) {
        // print('5 at middle slide frozen');
        _numberOfStrips = slideIndex + 1;
      }

      /// B - GOING NEXT
      else if (_swipeDirection == SwipeDirection.next) {
        // print('5 at middle slide going next');
        _numberOfStrips = slideIndex + 1;
      }

      /// B - GOING PREVIOUS
      else {
        // print('6 at middle slide going previous');
        _numberOfStrips = slideIndex + 2;
      }
    }
    // -----------------------------------------o

    // blog('_getNumberOfWhiteStrips : $_numberOfStrips : index : $slideIndex');

    return _numberOfStrips;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /*
    // print('========= BUILDING PROGRESS BAR FOR ||| index : $slideIndex, numberOfSlides : $numberOfStrips, slidingNext $swipeDirection');
    // int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
    // double _aStripThickness = flyerBoxWidth * 0.007;
    // double _aStripOnePadding = _aStripThickness / 2;
    // Color _stripColor = Colorz.White80;
    // double _stripCorner = _aStripThickness * 0.5;
    // Color _currentStripColor = numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
    // double _boxWidth = boxWidth(flyerBoxWidth);
    // double _boxHeight = boxHeight(flyerBoxWidth);
     */
    // --------------------
    final double _stripsTotalLength = stripsTotalLength(flyerBoxWidth);
    // EdgeInsets _boxMargins = boxMargins(margins: margins, flyerBoxWidth: flyerBoxWidth);
    // double _allStripsOneSideMargin = stripsOneSideMargin(flyerBoxWidth);
    final double _aStripLength = oneStripLength(
      flyerBoxWidth: flyerBoxWidth,
      numberOfStrips: numberOfStrips,
    );
    // --------------------
    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
    // --------------------
    Tween<double> _tween() {
      Tween<double> _tween;

      /// NO TWEEN
      if (swipeDirection == SwipeDirection.freeze) {
        _tween = Tween<double>(begin: _aStripLength, end: _aStripLength);
      }

      /// GOING NEXT
      else if (swipeDirection == SwipeDirection.next) {
        _tween = Tween<double>(begin: 0, end: _aStripLength);
      }

      /// GOING PREVIOUS
      else {
        _tween = Tween<double>(begin: _aStripLength, end: 0);
      }

      return _tween;
    }
    // --------------------
    final int _numberOfStrips = _getNumberOfWhiteStrips();
    // --------------------
    return _tinyMode == true || barIsOn == false ? Container() :
    numberOfStrips == 1 ?
    ProgressBox(
        flyerBoxWidth: flyerBoxWidth,
        margins: margins,
        stripsStack: <Widget>[

          StaticStrip(
            flyerBoxWidth: flyerBoxWidth,
            stripWidth: _stripsTotalLength,
            numberOfSlides: 1,
            isWhite: true,
          ),

        ]
    )
        :
    ProgressBox(
        flyerBoxWidth: flyerBoxWidth,
        margins: margins,
        stripsStack: <Widget>[

          /// --- BASE STRIP
          Row(
            mainAxisSize: MainAxisSize.min,
            children:
            List<Widget>.generate(numberOfStrips, (int index) {

              return StaticStrip(
                flyerBoxWidth: flyerBoxWidth,
                stripWidth: _aStripLength,
                numberOfSlides: numberOfStrips,
                margins: margins,
                isWhite: false,
              );
            }
            ),
          ),

          /// --- TOP STRIP
          TweenAnimationBuilder<double>(
            duration: Ratioz.duration150ms,
            tween: _tween(),
            curve: Curves.easeOut,
            // onEnd: (){},
            key: ValueKey<int>(slideIndex),
            builder: (BuildContext context, double tweenVal, Widget child) {

              final double _tweenVal = swipeDirection == SwipeDirection.freeze ? _aStripLength : tweenVal;

              // blog('_numberOfStrips : $_numberOfStrips');

              return
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    ...List<Widget>.generate(_numberOfStrips,
                            (int index) {
                          // print('numberOfSlides : $numberOfSlides ,currentSlide : $currentSlide, index : $index, _numberOfWhiteStrips() : ${_numberOfWhiteStrips()}' );
                          return
                            /// IF ITS LAST STRIP
                            // index == slideIndex ?
                            index + 1 == _numberOfStrips ?
                            StaticStrip(
                              flyerBoxWidth: flyerBoxWidth,
                              stripWidth: _tweenVal,
                              numberOfSlides: numberOfStrips,
                              isWhite: true,
                            )
                                :
                            /// IF STATIC STRIPS
                            StaticStrip(
                              flyerBoxWidth: flyerBoxWidth,
                              stripWidth: _aStripLength,
                              numberOfSlides: numberOfStrips,
                              isWhite: true,
                            );
                        }
                    ),

                  ],
                );
            },
          ),

        ]
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
