import 'dart:typed_data';

import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:colorizer/colorizer.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Matrix4 initializeMatrix({
  @required DraftSlide slide,
}){
  Matrix4 _output;
  if (slide.matrix == null){
    _output = Matrix4.identity();
  }

  else {
    _output = slide.matrix;
  }
  return _output;
}
// -----------------------------------------------------------------------------

/// CANCELLING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSlideEdits({
  @required BuildContext context,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onCancelSlideEdits',
  );

}
// -----------------------------------------------------------------------------

/// RESET

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onResetMatrix({
  @required BuildContext context,
  @required DraftSlide originalDraft,
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<bool> canResetMatrix,
  @required ValueNotifier<Matrix4> matrix,
  @required bool mounted,
}) async {

  final bool _go = await Dialogs.confirmProceed(
    context: context,
    titleVerse: const Verse(
      id: 'phid_reset_orientation_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      id: 'phid_this_will_reset_zoom_rotation_of_slide',
      translate: true,
    ),
    invertButtons: true,
  );

  if (_go == true){

    setNotifier(
        notifier: draftNotifier,
        mounted: mounted,
        value: originalDraft.copyWith(
          matrix: Matrix4.identity(),
          filter: ImageFilterModel.noFilter(),
        )
    );

    setNotifier(
      notifier: matrix,
      mounted: mounted,
      value: Matrix4.identity(),
    );

    setNotifier(
      notifier: canResetMatrix,
      mounted: mounted,
      value: false,
    );

  }

}
// -----------------------------------------------------------------------------

/// ANIMATION TRIGGER

// --------------------
/// TESTED : WORKS PERFECT
void onTriggerAnimation({
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<bool> canResetMatrix,
  @required ValueNotifier<bool> isPlayingAnimation,
  @required bool mounted,
}){

  final Curve _oldCurve = draftNotifier.value.animationCurve;
  final Curve _newCurve = _oldCurve == Curves.easeInOut ? null : Curves.easeInOut;
  bool _shouldReanimate = false;

  DraftSlide _newSlide;
  if (_oldCurve == null){
    _newSlide = draftNotifier.value.copyWith(
      animationCurve: _newCurve,
    );

    _shouldReanimate = true;

  }

  else {
    _newSlide = draftNotifier.value.nullifyField(
      animationCurve: true,
    );
  }

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: _newSlide,
  );

  if (_shouldReanimate == true){
    onReplayAnimation(
       mounted: mounted,
       draftNotifier: draftNotifier,
       canResetMatrix: canResetMatrix,
       isPlayingAnimation: isPlayingAnimation,
     );
  }
  else {
    stopAnimation(
      mounted: mounted,
      isPlayingAnimation: isPlayingAnimation,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onReplayAnimation({
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<bool> canResetMatrix,
  @required ValueNotifier<bool> isPlayingAnimation,
  @required bool mounted,
}){

    if (
        // isPlayingAnimation.value == false && // to allow reanimate when playing
        canResetMatrix.value == true &&
        draftNotifier.value.animationCurve != null
    ){

      setNotifier(
          notifier: isPlayingAnimation,
          mounted: mounted,
          value: false, // to allow reanimate when playing
        );

      setNotifier(
        notifier: isPlayingAnimation,
        mounted: mounted,
        value: true,
      );

    }

}
// --------------------
/// TESTED : WORKS PERFECT
void stopAnimation({
  @required ValueNotifier<bool> isPlayingAnimation,
  @required bool mounted,
}){
  setNotifier(
      notifier: isPlayingAnimation,
      mounted: mounted,
      value: false,
  );
}
// -----------------------------------------------------------------------------

/// CROPPING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCropSlide({
  @required BuildContext context,
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<ImageFilterModel> filterNotifier,
  @required ValueNotifier<Matrix4> matrixNotifier,
  @required String bzID,
  @required bool mounted,
}) async {

  final Uint8List _bytes = await PicMaker.cropPic(
    context: context,
    bytes: draftNotifier.value.picModel.bytes,
    aspectRatio: FlyerDim.flyerAspectRatio(
      forceMaxHeight: true,
    ),
  );

  if (_bytes != null){

    setNotifier(
        notifier: draftNotifier,
        mounted: mounted,
        value: draftNotifier.value.copyWith(
          midColor: await Colorizer.getAverageColor(_bytes),
          picModel: draftNotifier.value.picModel.copyWith(
            bytes: _bytes,
          ),
        ),
    );

  }

}
// -----------------------------------------------------------------------------

/// COLOR FILTER

// --------------------
/// TESTED : WORKS PERFECT
void onToggleFilter({
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<ImageFilterModel> currentFilter,
  @required bool mounted,
}){

  final ImageFilterModel _currentFilter = currentFilter.value;

  final List<ImageFilterModel> _bldrsFilters = ImageFilterModel.bldrsImageFilters;
  int _filterIndex = _bldrsFilters.indexWhere((fil) => fil.id == _currentFilter.id);

  _filterIndex++;
  if (_filterIndex >= _bldrsFilters.length){
    _filterIndex = 0;
  }

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        filter: _bldrsFilters[_filterIndex],
      ),
  );

  // blog('currentFilter : ${currentFilter.value.id} :  _bldrsFilters[_filterIndex] : ${
  //     _bldrsFilters[_filterIndex].id}');

  setNotifier(
      notifier: currentFilter,
      mounted: mounted,
      value: _bldrsFilters[_filterIndex],
  );

}
// -----------------------------------------------------------------------------

/// HEADLINE

// --------------------
/// TESTED : WORKS PERFECT
void onSlideHeadlineChanged({
  @required ValueNotifier<DraftSlide> draftSlide,
  @required String text,
  @required bool mounted,
}){

  setNotifier(
      notifier: draftSlide,
      mounted: mounted,
      value: draftSlide.value.copyWith(
        headline: text,
      ),
  );

}
// -----------------------------------------------------------------------------

/// CONFIRMATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmSlideEdits({
  @required BuildContext context,
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {


  final DraftSlide _slide = draftNotifier.value.copyWith(
    matrix: matrix.value,
    filter: filter.value,
  );

  await Nav.goBack(
    context: context,
    invoker: 'onConfirmSlideEdits',
    passedData: _slide,
  );

}
// -----------------------------------------------------------------------------
