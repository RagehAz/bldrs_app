import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/static_flyer/a_static_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:numeric/numeric.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FlyerDeck extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerDeck({
    @required this.maxPossibleWidth,
    @required this.deckHeight,
    @required this.flyerModel,
    @required this.expansion,
    @required this.minSlideHeightFactor,
    @required this.screenName,
    this.draft,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double maxPossibleWidth;
  final double deckHeight;
  final FlyerModel flyerModel;
  /// HEIGHT FACTOR OF SMALLEST SLIDE TO THE BIGGEST SLIDE HEIGHT
  final double minSlideHeightFactor;
  final double expansion;
  final String screenName;
  final DraftFlyer draft;
  // -----------------------------------------------------------------------------
  static double concludeDeckWidth({
    @required BuildContext context,
    @required int numberOfSlides,
    @required double deckHeight,
    @required double maxPossibleWidth,
    @required double expansion, // 0 will be stacked above each other => 1 will be side by side
    @required double minSlideHeightFactor,
  }){

    final double _biggestSlideWidth = FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: deckHeight,
      forceMaxHeight: false,
    );

    if (numberOfSlides == 0){
      return 0;
    }

    else if (numberOfSlides == 1){
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

    return FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: _scale * maxSlideHeight,
      forceMaxHeight: false,
    );
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
  /// TESTED : WORKS PERFECT
  Future<FlyerModel> _transformDraft({
    @required BuildContext context,
    @required DraftFlyer draft,
  }) async {

    FlyerModel _flyer = await DraftFlyer.draftToFlyer(draft: draft, toLDB: false);
    _flyer = await FlyerProtocols.renderBigFlyer(
      context: context,
      flyerModel: _flyer,
    );

    final List<SlideModel> _flyerSlides = <SlideModel>[];

    for (int i = 0; i < _flyer.slides.length; i++){

      final SlideModel _slide = _flyer.slides[i];

      /// UI IMAGE IS MISSING
      if (_slide.uiImage == null){

        final DraftSlide _draft = draft.draftSlides.firstWhere((element) => element.slideIndex == _slide.slideIndex);
        final ui.Image _image = await Floaters.getUiImageFromUint8List(_draft.picModel.bytes);
        final SlideModel _updatedSlide = _slide.copyWith(
          uiImage: _image,
        );
        _flyerSlides.add(_updatedSlide);
      }

      /// UI IMAGE IS DEFINED
      else {

        _flyerSlides.add(_slide);

      }

    }

    return _flyer.copyWith(
      slides: _flyerSlides,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel == null && draft == null){
      return const SizedBox();
    }

    /// BUILD DRAFT
    else if (draft != null){

      return FutureBuilder(
        future: _transformDraft(
          context: context,
          draft: draft,
        ),
        builder: (_, AsyncSnapshot<FlyerModel> snap){

          final FlyerModel _flyer = snap.data;
          _flyer?.blogFlyer(invoker: 'REBUILDING POSTER');


          return _TheDeck(
            screenName: screenName,
            flyerModel: _flyer,
            deckHeight: deckHeight,
            maxPossibleWidth: maxPossibleWidth,
            expansion: expansion,
            minSlideHeightFactor: minSlideHeightFactor,
          );

        },
      );

    }

    /// BUILD FLYER
    else {

      return _TheDeck(
        screenName: screenName,
        flyerModel: flyerModel,
        deckHeight: deckHeight,
        maxPossibleWidth: maxPossibleWidth,
        expansion: expansion,
        minSlideHeightFactor: minSlideHeightFactor,
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _TheDeck extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _TheDeck({
    @required this.maxPossibleWidth,
    @required this.deckHeight,
    @required this.flyerModel,
    @required this.expansion,
    @required this.minSlideHeightFactor,
    @required this.screenName,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double maxPossibleWidth;
  final double deckHeight;
  final FlyerModel flyerModel;
  final double minSlideHeightFactor;
  final double expansion;
  final String screenName;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final int _slidesLength = flyerModel?.slides?.length ?? 0;

    final double _deckWidth = FlyerDeck.concludeDeckWidth(
      context: context,
      numberOfSlides: _slidesLength,
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

          if (_slidesLength > 0)
          ...List.generate(_slidesLength, (_index){

            final _reverseIndex = Numeric.reverseIndex(
              listLength: _slidesLength,
              index: _index,
            );

            final double _flyerBoxWidth = FlyerDeck._getSlideWidth(
              maxSlideHeight: deckHeight,
              reverseIndex: _index,
              minSlideHeightFactor: minSlideHeightFactor,
              numberOfSlides: _slidesLength,
            );

            return SuperPositioned(
              enAlignment: Alignment.centerLeft,
              horizontalOffset: FlyerDeck._getSlideOffset(
                deckWidth: _deckWidth,
                reverseIndex: _index,
                maxSlideHeight: deckHeight,
                minSlideHeightFactor: minSlideHeightFactor,
                numberOfSlides: _slidesLength,
              ),
              child:

              _index + 1 ==  _slidesLength?
              StaticFlyer(
                flyerModel: flyerModel,
                flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(
                  flyerBoxHeight: deckHeight,
                  forceMaxHeight: false,
                ),
                slideIndex: _index,
                // flyerShadowIsOn: true,
                // bluerLayerIsOn: true,
                // slideShadowIsOn: true,
                // canAnimateMatrix: true,
              )

                  :

              SingleSlide(
                flyerBoxWidth: _flyerBoxWidth,
                flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
                  flyerBoxWidth: _flyerBoxWidth,
                  forceMaxHeight: false,
                ),
                slideModel: flyerModel.slides[_reverseIndex],
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
                slideShadowIsOn: true,
                blurLayerIsOn: true,
                canTapSlide: false,
                canAnimateMatrix: true,
                canUseFilter: true,
                canPinch: false,
              ),

            );

          }),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
