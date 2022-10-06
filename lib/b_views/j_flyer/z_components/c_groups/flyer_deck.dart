import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_static_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:flutter/material.dart';

class FlyerDeck extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerDeck({
    @required this.maxPossibleWidth,
    @required this.deckHeight,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.expansion,
    @required this.minSlideHeightFactor,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double maxPossibleWidth;
  final double deckHeight;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// HEIGHT FACTOR OF SMALLEST SLIDE TO THE BIGGEST SLIDE HEIGHT
  final double minSlideHeightFactor;
  final double expansion;
  // -----------------------------------------------------------------------------
  static double concludeDeckWidth({
    @required int numberOfSlides,
    @required double deckHeight,
    @required double maxPossibleWidth,
    @required double expansion, // 0 will be stacked above each other => 1 will be side by side
    @required double minSlideHeightFactor,
  }){

    final double _biggestSlideWidth = FlyerDim.flyerWidthByFlyerHeight(deckHeight);

    if (numberOfSlides == 1){
      return _biggestSlideWidth;
    }

    else {

      final double _sumOfSlidesWidths = _getSumOfSlidesWidths(
        maxSlideHeight: deckHeight,
        minSlideHeightFactor: minSlideHeightFactor,
        numberOfSlides: numberOfSlides,
      );

      final double _maxWidth = _sumOfSlidesWidths > maxPossibleWidth ? maxPossibleWidth : _sumOfSlidesWidths;

      // blog('_maxWidth : $_maxWidth : _sumOfSlidesWidths : $_sumOfSlidesWidths : _biggestSlideWidth : $_biggestSlideWidth : maxPossibleWidth : $maxPossibleWidth');

      return Animators.limitTweenImpact(
        maxDouble: _maxWidth,
        minDouble: _biggestSlideWidth,
        tweenValue: expansion,
      );
    }

  }
  // --------------------
  static double _getSlideWidth({
    @required double maxSlideHeight,
    @required int reverseIndex,
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
  }){

    final double _scale = _getSlideScaleByReverseIndex(
      reverseIndex: reverseIndex,
      minSlideHeightFactor: minSlideHeightFactor,
      numberOfSlides: numberOfSlides,
    );

    // blog('_scale : $_scale');

    return FlyerDim.flyerWidthByFlyerHeight(_scale * maxSlideHeight);
  }
  // --------------------
  static double _getSumOfSlidesWidths({
    @required double maxSlideHeight,
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
  }){

    double _total = 0;
    for (int i = 0; i < numberOfSlides; i++){
      final double _slideWidth = _getSlideWidth(
        numberOfSlides: numberOfSlides,
        minSlideHeightFactor: minSlideHeightFactor,
        maxSlideHeight: maxSlideHeight,
        reverseIndex: i,
      );
      _total = _total + _slideWidth;
    }

    return _total;
  }
  // --------------------
  static double _getShiftWidth({
    @required int numberOfSlides,
    @required double maxSlideHeight,
    @required double minSlideHeightFactor,
    @required double deckWidth,
  }){

    final double _allSlidesWidths = _getSumOfSlidesWidths(
      maxSlideHeight: maxSlideHeight,
      minSlideHeightFactor: minSlideHeightFactor,
      numberOfSlides: numberOfSlides,
    );

    final double _allShiftsWidths = _allSlidesWidths - deckWidth;

    return _allShiftsWidths / (numberOfSlides - 1);
  }
  // --------------------
  static double _getSlideOffset({
    @required double maxSlideHeight,
    @required int reverseIndex,
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
    @required double deckWidth,
  }){

    if (reverseIndex == 0){
      return 0;
    }

    else {

      final double _lastOffset = _getSlideOffset(
        reverseIndex: reverseIndex - 1,
        numberOfSlides: numberOfSlides,
        minSlideHeightFactor: minSlideHeightFactor,
        maxSlideHeight: maxSlideHeight,
        deckWidth: deckWidth,
      );

      final double _lastSlideWidth = _getSlideWidth(
        reverseIndex: reverseIndex - 1,
        numberOfSlides: numberOfSlides,
        minSlideHeightFactor: minSlideHeightFactor,
        maxSlideHeight: maxSlideHeight,
      );

      final double _shift = _getShiftWidth(
        numberOfSlides: numberOfSlides,
        minSlideHeightFactor: minSlideHeightFactor,
        maxSlideHeight: maxSlideHeight,
        deckWidth: deckWidth,
      );

      final double _step = _lastOffset + (_lastSlideWidth - _shift);

      return _step;
    }

  }
  // --------------------
  static double _getStepScale({
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
  }){

    // blog('minSlideHeightFactor : $minSlideHeightFactor : numberOfSlides : $numberOfSlides');

    if (numberOfSlides == 1){
      return 1;
    }
    else {
      final double _stepScale = (1 - minSlideHeightFactor) / (numberOfSlides - 1);
      return _stepScale;
    }

  }
  // --------------------
  /*
  static double _getSlideScaleByIndex({
    @required int slideIndex,
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
  }){

    final double _stepScale = _getStepScale(
      minSlideHeightFactor: minSlideHeightFactor,
      numberOfSlides: numberOfSlides,
    );

    return 1 - ( _stepScale * slideIndex);
  }
   */
  // --------------------
  static double _getSlideScaleByReverseIndex({
    @required int reverseIndex,
    @required double minSlideHeightFactor,
    @required int numberOfSlides,
  }){

    final double _stepScale = _getStepScale(
      minSlideHeightFactor: minSlideHeightFactor,
      numberOfSlides: numberOfSlides,
    );

    final double _scale = minSlideHeightFactor + (_stepScale * reverseIndex);

    // blog('reverseIndex : $reverseIndex : _scale : $_scale : numberOfSlides : $numberOfSlides : _stepScale : $_stepScale : minSlideHeightFactor : $minSlideHeightFactor');

    return _scale;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel == null){
      return const SizedBox();
    }

    else {

      final double _deckWidth = concludeDeckWidth(
        numberOfSlides: flyerModel.slides.length,
        deckHeight: deckHeight,
        maxPossibleWidth: maxPossibleWidth,
        expansion: expansion,
        minSlideHeightFactor: minSlideHeightFactor,
      );

      return SizedBox(
        width: _deckWidth,
        height: deckHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            ...List.generate(flyerModel.slides.length, (_index){

              final _reverseIndex = Numeric.reverseIndex(
                listLength: flyerModel.slides.length,
                index: _index,
              );

              final double _flyerBoxWidth = _getSlideWidth(
                maxSlideHeight: deckHeight,
                reverseIndex: _index,
                minSlideHeightFactor: minSlideHeightFactor,
                numberOfSlides: flyerModel.slides.length,
              );

              return SuperPositioned(
                enAlignment: Alignment.centerLeft,
                horizontalOffset: _getSlideOffset(
                  deckWidth: _deckWidth,
                  reverseIndex: _index,
                  maxSlideHeight: deckHeight,
                  minSlideHeightFactor: minSlideHeightFactor,
                  numberOfSlides: flyerModel.slides.length,
                ),
                child:

                _index + 1 ==  flyerModel.slides.length?
                StaticFlyer(
                  bzModel: bzModel,
                  flyerModel: flyerModel,
                  flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(deckHeight),
                  flyerShadowIsOn: true,
                )

                    :

                SingleSlide(
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth),
                  slideModel: flyerModel.slides[_reverseIndex],
                  tinyMode: false,
                  onSlideNextTap: null,
                  onSlideBackTap: null,
                  onDoubleTap: null,
                  slideShadowIsOn: true,
                ),
              );

            }),

          ],
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
