import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/color_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/main_controls.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeSlideAnimation({
  required DraftSlide? slide,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required bool mounted,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required ValueNotifier<bool> isTransforming,
  required double flyerBoxWidth,
}){

  /// INITIALIZE TEMP SLIDE
  final DraftSlide? _initialSlide = slide?.copyWith(
    matrix: slide.matrix ?? DraftSlide.createInitialMatrix(isMatrixFrom: false, flyerBoxWidth: flyerBoxWidth),
    matrixFrom: slide.matrixFrom ?? DraftSlide.createInitialMatrix(isMatrixFrom: true, flyerBoxWidth: flyerBoxWidth),
  );

  /// SET DRAFT
  setNotifier(
    notifier: draftSlideNotifier,
    mounted: mounted,
    value: _initialSlide,
  );

  /// SET MATRIX
  setNotifier(
    notifier: matrixNotifier,
    mounted: mounted,
    value: _initialSlide?.matrix,
  );

  /// SET MATRIX FROM
  setNotifier(
    notifier: matrixFromNotifier,
    mounted: mounted,
    value: _initialSlide?.matrixFrom,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> transformationListener({
  required ValueNotifier<bool> isTransforming,
  required bool mounted,
}) async {

    if (isTransforming.value  == true){

      await Future.delayed(const Duration(seconds: 1), (){

        setNotifier(
          notifier: isTransforming,
          mounted: mounted,
          value: false,
        );

      });
    }

  }
// -----------------------------------------------------------------------------

/// ANIMATION - STILL - CURVE

// --------------------
/// TESTED : WORKS PERFECT
void onTriggerAnimationPanel({
  required bool mounted,
  required ValueNotifier<bool> showColorPanel,
  required ValueNotifier<bool> showAnimationPanel,
  required ValueNotifier<bool> isDoingMatrixFrom,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
}){

  /// SWITCH OFF COLOR PICKER
  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    slideBackColor: slideBackColor,
    draftSlideNotifier: draftSlideNotifier,
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
  );

  /// SWITCH OFF COLOR PANEL
  setNotifier(
    notifier: showColorPanel,
    mounted: mounted,
    value: false,
  );

  /// TRIGGER ANIMATION PANEL
  setNotifier(
    notifier: showAnimationPanel,
    mounted: mounted,
    value: !showAnimationPanel.value,
  );

  // setSlideIsAnimated(
  //     curve: Curves.easeInOut,
  //     draftNotifier: draftNotifier,
  //     mounted: mounted,
  //     isPlayingAnimation: isPlayingAnimation,
  //     isDoingMatrixFrom: isDoingMatrixFrom
  // );

}
// --------------------
/// TESTED : WORKS PERFECT
void onTriggerSlideIsAnimated({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isDoingMatrixFrom,
  required bool mounted,
}){

  final Curve? _oldCurve = draftSlideNotifier.value?.animationCurve;
  final Curve? _newCurve = _oldCurve == Curves.easeInOut ? null : Curves.easeInOut;

  DraftSlide? _newSlide;
  if (_newCurve == null){
    _newSlide = draftSlideNotifier.value?.nullifyField(
      animationCurve: true,
    );
  }
  else {
    _newSlide = draftSlideNotifier.value?.copyWith(
      animationCurve: _newCurve,
    );
  }

  setFlyerAndSlide(
    mounted: mounted,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
    draftSlide: _newSlide,
  );

  stopAnimation(
    mounted: mounted,
    isPlayingAnimation: isPlayingAnimation,
  );

  setNotifier(
    notifier: isDoingMatrixFrom,
    mounted: mounted,
    value: _newCurve != null,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void setSlideIsAnimated({
  required Curve? curve,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required bool mounted,
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isDoingMatrixFrom,
}){



}
// -----------------------------------------------------------------------------

/// ANIMATION PLAYING

// --------------------
/// TESTED : WORKS PERFECT
void onPlayTap({
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required Matrix4? matrix,
  required Matrix4? matrixFrom,
  required ValueNotifier<bool> isDoingMatrixFrom,
}){

  /// SET SLIDE
  setDraftFlyerSlideMatrixes(
    mounted: mounted,
    matrix: matrix,
    matrixFrom: matrixFrom,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
  );

  /// TRIGGER IS PLAYING
  setNotifier(
    notifier: isPlayingAnimation,
    mounted: true,
    value: !isPlayingAnimation.value,
  );

  /// LAND ON THE TO MATRIX
  setNotifier(
      notifier: isDoingMatrixFrom,
      mounted: mounted,
      value: false,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onReplayAnimation({
  required ValueNotifier<DraftSlide?> draftNotifier,
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
}){

  Keyboard.closeKeyboard();

  if (
  // isPlayingAnimation.value == false && // to allow reanimate when playing
      draftNotifier.value?.animationCurve != null
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
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
}){
  setNotifier(
      notifier: isPlayingAnimation,
      mounted: mounted,
      value: false,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAnimationEnds({
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  setNotifier(
    notifier: isPlayingAnimation,
    mounted: mounted,
    value: false,
  );
}
// -----------------------------------------------------------------------------

/// MATRIX CONTROLS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onResetMatrix({
  required DraftSlide? originalDraft,
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required bool mounted,
  required double flyerBoxWidth,
  required double flyerBoxHeight,
}) async {

  // final bool _go = await Dialogs.confirmProceed(
  //   titleVerse: const Verse(
  //     id: 'phid_reset_orientation_?',
  //     translate: true,
  //   ),
  //   bodyVerse: const Verse(
  //     id: 'phid_this_will_reset_zoom_rotation_of_slide',
  //     translate: true,
  //   ),
  //   invertButtons: true,
  // );

  const bool _go = true;

  if (_go == true){

    /// SWITCH OFF ANIMATION IF PLAYING
    if (isPlayingAnimation.value == true){
      setNotifier(
        notifier: isPlayingAnimation,
        mounted: mounted,
        value: false,
      );
    }

    final Matrix4 _matrix = DraftSlide.createInitialMatrix(
        isMatrixFrom: false,
        flyerBoxWidth: flyerBoxWidth,
    );
    final Matrix4 _matrixFrom = DraftSlide.createInitialMatrix(
        isMatrixFrom: true,
        flyerBoxWidth: flyerBoxWidth,
    );

    /// TO LET THE SLIDE TRANSFORMER REBUILD MrAnderson
    if (draftSlideNotifier.value?.animationCurve == null){
      setNotifier(
        notifier: isPlayingAnimation,
        mounted: mounted,
        value: true,
      );
    }

    setDraftFlyerSlideMatrixes(
      draftFlyerNotifier: draftFlyerNotifier,
      draftSlideNotifier: draftSlideNotifier,
      matrix: _matrix,
      matrixFrom: _matrixFrom,
      mounted: mounted,
    );

    setNotifier(
      notifier: matrixNotifier,
      mounted: mounted,
      value: _matrix,
    );

    setNotifier(
      notifier: matrixFromNotifier,
      mounted: mounted,
      value: _matrixFrom,
    );

    /// TO LET THE SLIDE TRANSFORMER REBUILD MrAnderson
    if (draftSlideNotifier.value?.animationCurve == null){
      await Future.delayed(const Duration(milliseconds: 100));
      setNotifier(
        notifier: isPlayingAnimation,
        mounted: mounted,
        value: false,
      );
    }

    /// SWITCH ON ANIMATION IF NOT STILL SLIDE
    if (draftSlideNotifier.value?.animationCurve != null){
      setNotifier(
        notifier: isPlayingAnimation,
        mounted: mounted,
        value: true,
      );
    }

  }

}
// -----------------------------------------------------------------------------

/// FRAME SELECTION

// --------------------
/// TESTED : WORKS PERFECT
void onFromTap({
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isDoingMatrixFrom,
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required Matrix4? matrix,
  required Matrix4? matrixFrom,
}){

  /// SET SLIDE
  setDraftFlyerSlideMatrixes(
    mounted: mounted,
    matrix: matrix,
    matrixFrom: matrixFrom,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
  );

  /// SWITCH OFF ANIMATION
  if (isPlayingAnimation.value == true){
    setNotifier(
      notifier: isPlayingAnimation,
      mounted: mounted,
      value: false,
    );
  }

  /// SET DOING MATRIX FROM
  setNotifier(
    notifier: isDoingMatrixFrom,
    mounted: mounted,
    value: true,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onToTap({
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isDoingMatrixFrom,
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required Matrix4? matrix,
  required Matrix4? matrixFrom,
}){

  /// SET SLIDE
  setDraftFlyerSlideMatrixes(
    mounted: mounted,
    matrix: matrix,
    matrixFrom: matrixFrom,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
  );

  /// SWITCH OFF ANIMATION
  if (isPlayingAnimation.value == true){
    setNotifier(
      notifier: isPlayingAnimation,
      mounted: true,
      value: false,
    );
  }

  /// SET DOING MATRIX FROM
  setNotifier(
    notifier: isDoingMatrixFrom,
    mounted: true,
    value: false,
  );

}
// -----------------------------------------------------------------------------
