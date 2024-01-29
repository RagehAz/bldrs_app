import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/static_progress_bar/static_strip.dart';
import 'package:flutter/material.dart';

class StaticStrips extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticStrips({
    required this.flyerBoxWidth,
    required this.numberOfStrips,
    required this.swipeDirection,
    this.barIsOn = true,
    this.slideIndex = 0,
    this.margins,
    this.stripsColors,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool barIsOn;
  final int numberOfStrips;
  final int slideIndex;
  final EdgeInsets? margins;
  final SwipeDirection swipeDirection;
  final List<Color>? stripsColors;
  /// --------------------------------------------------------------------------
  int _getNumberOfWhiteStrips() {
    // -----------------------------------------o
    int? _numberOfStrips;
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

    return _numberOfStrips ?? 1;
  }
  // -----------------------------------------------------------------------------
  Tween<double> _tween() {
    Tween<double> _tween;

    final double _aStripLength = FlyerDim.progressStripLength(
      flyerBoxWidth: flyerBoxWidth,
      numberOfStrips: numberOfStrips,
    );

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
  // -----------------------------------------------------------------------------
  Color _stripColorOverride(int index){

    // blog('stripsColors : $stripsColors}');

    if (Lister.checkCanLoop(stripsColors) == true){
      return stripsColors![index]; // ?? Colorz.white10;
    }

    else {
      return FlyerColors.progressStripOnColor;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (barIsOn == false){
      return const SizedBox();
    }

    else if (numberOfStrips == 1){
      return ProgressBox(
          flyerBoxWidth: flyerBoxWidth,
          margins: margins,
          stripsStack: <Widget>[

            StaticStrip(
              flyerBoxWidth: flyerBoxWidth,
              stripWidth: FlyerDim.progressStripsTotalLength(flyerBoxWidth),
              numberOfSlides: 1,
              isWhite: true,
            ),

          ]
      );
    }

    else {
      // --------------------
      final int _numberOfStrips = _getNumberOfWhiteStrips();
      // --------------------
      final double _aStripLength = FlyerDim.progressStripLength(
        flyerBoxWidth: flyerBoxWidth,
        numberOfStrips: numberOfStrips,
      );
      // --------------------
      return ProgressBox(
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
                  isWhite: true,
                  stripColor: _stripColorOverride(index).withAlpha(100),
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
              builder: (BuildContext context, double tweenVal, Widget? child) {

                final double _tweenVal = swipeDirection == SwipeDirection.freeze ? _aStripLength : tweenVal;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    ...List<Widget>.generate(_numberOfStrips, (int index) {

                      /// IF ITS LAST STRIP
                      if (index + 1 == _numberOfStrips){
                        return StaticStrip(
                          flyerBoxWidth: flyerBoxWidth,
                          stripWidth: _tweenVal,
                          numberOfSlides: numberOfStrips,
                          isWhite: true,
                          stripColor: _stripColorOverride(index),
                        );
                      }

                      /// IF STATIC STRIPS
                      else {
                        return StaticStrip(
                          flyerBoxWidth: flyerBoxWidth,
                          stripWidth: _aStripLength,
                          numberOfSlides: numberOfStrips,
                          isWhite: true,
                          stripColor: _stripColorOverride(index),
                        );
                      }

                    }),

                  ],
                );

              },
            ),

          ]
      );

    }

  }
// -----------------------------------------------------------------------------
}
