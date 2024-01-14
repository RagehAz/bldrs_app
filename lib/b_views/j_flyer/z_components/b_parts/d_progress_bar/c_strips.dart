import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/static_progress_bar/static_strip.dart';
import 'package:flutter/material.dart';

class Strips extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Strips({
    required this.flyerBoxWidth,
    required this.progressBarModel,
    required this.tinyMode,
    this.barIsOn = true,
    this.margins,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final bool barIsOn;
  final EdgeInsets? margins;
  final bool tinyMode;
  // -----------------------------------------------------------------------------
  static bool canBuildStrips(int? numberOfStrips) {
    bool _canBuild = false;

    if (numberOfStrips != null) {
      if (numberOfStrips > 0) {
        _canBuild = true;
      }
    }

    return _canBuild;
  }
  // --------------------
  static int _getNumberOfWhiteStrips({
    required SwipeDirection swipeDirection,
    required int currentSlideIndex,
    required int numberOfStrips,
  }) {
    // -----------------------------------------o
    int? _numberOfStrips;
    final SwipeDirection _swipeDirection = swipeDirection;
    // -----------------------------------------o
    /// A - at first slide
    if (currentSlideIndex == 0) {
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
    else if (currentSlideIndex + 1 == numberOfStrips) {
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
        _numberOfStrips = currentSlideIndex + 3;
      }
    }
    // -----------------------------------------o
    /// A - at middle slides
    // -----------------------------------------o
    else {
      /// B - FREEZING
      if (_swipeDirection == SwipeDirection.freeze) {
        // print('5 at middle slide frozen');
        _numberOfStrips = currentSlideIndex + 1;
      }

      /// B - GOING NEXT
      else if (_swipeDirection == SwipeDirection.next) {
        // print('5 at middle slide going next');
        _numberOfStrips = currentSlideIndex + 1;
      }

      /// B - GOING PREVIOUS
      else {
        // print('6 at middle slide going previous');
        _numberOfStrips = currentSlideIndex + 2;
      }
    }
    // -----------------------------------------o

    // blog('_getNumberOfWhiteStrips : $_numberOfStrips : index : ${currentSlideIndex}');

    return _numberOfStrips ?? 1;
  }
  // --------------------
  Tween<double> _tween(ProgressBarModel _progModel) {
    Tween<double> _tween;

    final double _aStripLength = FlyerDim.progressStripLength(
      flyerBoxWidth: flyerBoxWidth,
      numberOfStrips: _progModel.numberOfStrips,
    );

    /// NO TWEEN
    if (_progModel.swipeDirection == SwipeDirection.freeze) {
      _tween = Tween<double>(begin: _aStripLength, end: _aStripLength);
    }

    /// GOING NEXT
    else if (_progModel.swipeDirection  == SwipeDirection.next) {
      _tween = Tween<double>(begin: 0, end: _aStripLength);
    }

    /// GOING PREVIOUS
    else {
      _tween = Tween<double>(begin: _aStripLength, end: 0);
    }

    return _tween;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (tinyMode == true || barIsOn == false){
      return const SizedBox();
    }

    else {

      return ValueListenableBuilder(
          valueListenable: progressBarModel,
          builder: (_, ProgressBarModel? _progModel, Widget? singleSlideProgBar){

            final double _aStripLength = FlyerDim.progressStripLength(
              flyerBoxWidth: flyerBoxWidth,
              numberOfStrips: _progModel?.numberOfStrips,
            );

            final int _numberOfStrips = _getNumberOfWhiteStrips(
              currentSlideIndex: _progModel?.index ?? 0,
              numberOfStrips: _progModel?.numberOfStrips ?? 1,
              swipeDirection: _progModel?.swipeDirection ?? SwipeDirection.freeze,
            );

            if (_progModel?.numberOfStrips == 1){
              return singleSlideProgBar!;
            }

            else {
              return ProgressBox(
                  flyerBoxWidth: flyerBoxWidth,
                  margins: margins,
                  stripsStack: <Widget>[

                    /// --- BASE STRIP
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        if (_progModel?.numberOfStrips != null && _progModel?.numberOfStrips != 0)
                        ...List<Widget>.generate(_progModel!.numberOfStrips, (int index) {

                          return StaticStrip(
                            flyerBoxWidth: flyerBoxWidth,
                            stripWidth: _aStripLength,
                            numberOfSlides: _progModel.numberOfStrips,
                            margins: margins,
                            isWhite: false,
                          );

                        }
                        )

                      ],
                    ),

                    /// --- TOP STRIP
                    if (_progModel != null)
                    TweenAnimationBuilder<double>(
                      key: ValueKey<String>('top_strip_${_progModel.index}'),
                      duration: Ratioz.duration150ms,
                      tween: _tween(_progModel),
                      curve: Curves.easeOut,
                      child: StaticStrip(
                        flyerBoxWidth: flyerBoxWidth,
                        stripWidth: _aStripLength,
                        numberOfSlides: _progModel.numberOfStrips,
                        isWhite: true,
                      ),
                      builder: (BuildContext context, double tweenVal, Widget? childC) {

                        final double _tweenVal = _progModel.swipeDirection == SwipeDirection.freeze ? _aStripLength : tweenVal;

                        // blog('_numberOfStrips : $_numberOfStrips');

                        return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              ...List<Widget>.generate(_numberOfStrips, (int index) {

                                /// IF ITS LAST STRIP
                                if (index + 1 == _numberOfStrips){
                                  return StaticStrip(
                                    flyerBoxWidth: flyerBoxWidth,
                                    stripWidth: _tweenVal,
                                    numberOfSlides: _progModel.numberOfStrips,
                                    isWhite: true,
                                  );
                                }

                                /// IF STATIC STRIPS
                                else {
                                  return childC!;
                                }

                              }
                              ),

                            ],
                          );
                      },
                    ),

                  ]
              );
            }

          },
        child: ProgressBox(
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
        ),
      );

    }

  }
// -----------------------------------------------------------------------------
}
