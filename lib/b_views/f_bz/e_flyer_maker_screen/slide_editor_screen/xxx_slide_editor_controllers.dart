import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/b_slide_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// CANCELLING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSlideEdits({
  required BuildContext context,
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
  required DraftSlide? originalDraft,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<bool> canResetMatrix,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required bool mounted,
  required double flyerBoxWidth,
  required double flyerBoxHeight,
}) async {

  final bool _go = await Dialogs.confirmProceed(
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

    final Matrix4 _matrix = Matrix4.identity();
    final Matrix4 _matrixFrom = Trinity.slightlyZoomed(
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: flyerBoxHeight
    );

    setNotifier(
        notifier: draftSlideNotifier,
        mounted: mounted,
        value: draftSlideNotifier.value?.copyWith(
          matrix: _matrix,
          matrixFrom: _matrixFrom,
        )
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

    setDraftFlyerSlide(
      draftFlyerNotifier: draftFlyerNotifier,
      draftSlideNotifier: draftSlideNotifier,
      matrixNotifier: matrixNotifier,
      matrixFromNotifier: matrixFromNotifier,
      mounted: mounted,
    );

    setNotifier(
      notifier: canResetMatrix,
      mounted: mounted,
      value: false,
    );

  }

}
// -----------------------------------------------------------------------------

/// ANIMATION CONTROLS

// --------------------
/// TESTED : WORKS PERFECT
void onTriggerAnimation({
  required ValueNotifier<DraftSlide?> draftNotifier,
  required ValueNotifier<bool> canResetMatrix,
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
}){

  final Curve? _oldCurve = draftNotifier.value?.animationCurve;
  final Curve? _newCurve = _oldCurve == Curves.easeInOut ? null : Curves.easeInOut;
  bool _shouldReanimate = false;

  DraftSlide? _newSlide;
  if (_oldCurve == null){
    _newSlide = draftNotifier.value?.copyWith(
      animationCurve: _newCurve,
    );

    _shouldReanimate = true;

  }

  else {
    _newSlide = draftNotifier.value?.nullifyField(
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
  required ValueNotifier<DraftSlide?> draftNotifier,
  required ValueNotifier<bool> canResetMatrix,
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
}){

  if (
  // isPlayingAnimation.value == false && // to allow reanimate when playing
  canResetMatrix.value == true &&
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
void onFromTap({
  required ValueNotifier<bool> isPlayingAnimation,
  required ValueNotifier<bool> isDoingMatrixFrom,
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
}){

  /// SET SLIDE
  setDraftFlyerSlide(
    mounted: mounted,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
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
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
}){

  /// SET SLIDE
  setDraftFlyerSlide(
    mounted: mounted,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
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
// --------------------
/// TESTED : WORKS PERFECT
void onPlayTap({
  required ValueNotifier<bool> isPlayingAnimation,
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required ValueNotifier<bool> isDoingMatrixFrom,
}){

  /// SET SLIDE
  setDraftFlyerSlide(
    mounted: mounted,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
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
// -----------------------------------------------------------------------------

/// CROPPING

// --------------------
/// NOT USED ANYMORE
Future<void> onCropSlide({
  required ValueNotifier<DraftSlide?> draftNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required String? bzID,
  required bool mounted,
}) async {

  if (draftNotifier.value != null){

    final PicModel? _croppedBig = await BldrsPicMaker.cropPic(
      pic: draftNotifier.value?.bigPic,
      compressionQuality: Standards.slideBigQuality,
      aspectRatio: FlyerDim.flyerAspectRatio(),
    );

    if (_croppedBig != null){

      final PicModel? _med = await BldrsPicMaker.compressSlideBigPicTo(
          slidePic: _croppedBig,
          flyerID: draftNotifier.value!.flyerID,
          slideIndex: draftNotifier.value!.slideIndex,
          type: SlidePicType.med,
      );

      final PicModel? _small = await BldrsPicMaker.compressSlideBigPicTo(
          slidePic: _croppedBig,
          flyerID: draftNotifier.value!.flyerID,
          slideIndex: draftNotifier.value!.slideIndex,
          type: SlidePicType.small,
      );

      final PicModel? _back = await BldrsPicMaker.createSlideBackground(
          bigPic: _croppedBig,
          flyerID: draftNotifier.value!.flyerID,
          slideIndex: draftNotifier.value!.slideIndex,
      );

      if (_med != null && _small != null && _back != null){
        setNotifier(
            notifier: draftNotifier,
            mounted: mounted,
            value: draftNotifier.value?.copyWith(
              midColor: await Colorizer.getAverageColor(_small.bytes),
              bigPic: _croppedBig,
              medPic: _med,
              smallPic: _small,
              backPic: _back,
            ),
        );
      }


    }

  }

}
// -----------------------------------------------------------------------------

/// COLOR FILTER

// --------------------
/// DEPRECATED
/*
void onToggleFilter({
  required ValueNotifier<DraftSlide?> draftNotifier,
  required ValueNotifier<ImageFilterModel?> currentFilter,
  required bool mounted,
}){

  final ImageFilterModel? _currentFilter = currentFilter.value;

  final List<ImageFilterModel> _bldrsFilters = ImageFilterModel.bldrsImageFilters;
  int _filterIndex = _bldrsFilters.indexWhere((fil) => fil.id == _currentFilter?.id);

  _filterIndex++;
  if (_filterIndex >= _bldrsFilters.length){
    _filterIndex = 0;
  }

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
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
 */
// -----------------------------------------------------------------------------

/// HEADLINE

// --------------------
/// TESTED : WORKS PERFECT
void onSlideHeadlineChanged({
  required ValueNotifier<DraftSlide?> draftSlide,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required String? text,
  required bool mounted,
}){

  setNotifier(
    notifier: draftSlide,
    mounted: mounted,
    value: draftSlide.value?.copyWith(
      headline: text,
    ),
  );

  setNotifier(
    notifier: draftFlyer,
    mounted: mounted,
    value: DraftFlyer.updateHeadline(
      draft: draftFlyer.value,
      newHeadline: text,
      slideIndex: draftSlide.value?.slideIndex ?? 0,
    ),
  );

}
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoNextSlide({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required DraftSlide nextSlide,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  setDraftFlyerSlide(
    draftFlyerNotifier: draftFlyerNotifier,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
    mounted: mounted,
    draftSlideNotifier: draftSlideNotifier,
  );

  await Nav.replaceScreen(
    context: getMainContext(),
    transitionType: Nav.superHorizontalTransition(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      // enAnimatesLTR: false,
    ),
    // duration: const Duration(milliseconds: 350),
    screen: SlideEditorScreen(
      slide: nextSlide,
      draftFlyerNotifier: draftFlyerNotifier,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoPreviousSlide({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required DraftSlide previousSlide,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  setDraftFlyerSlide(
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
    draftSlideNotifier: draftSlideNotifier,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
  );

  await Nav.replaceScreen(
    context: getMainContext(),
    transitionType: Nav.superHorizontalTransition(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enAnimatesLTR: true,
    ),
    // duration: const Duration(milliseconds: 300),
    screen: SlideEditorScreen(
      slide: previousSlide,
      draftFlyerNotifier: draftFlyerNotifier,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onExitSlideEditor({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required bool mounted,
}) async {

  setDraftFlyerSlide(
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
    matrixNotifier: matrixNotifier,
    matrixFromNotifier: matrixFromNotifier,
    mounted: mounted,
  );

  await Nav.goBack(
    context: getMainContext(),
    invoker: 'onConfirmSlideEdits',
  );

}
// --------------------
void setDraftFlyerSlide({
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
}){

  final DraftSlide? _slide = draftSlideNotifier.value?.copyWith(
    matrix: matrixNotifier.value,
    matrixFrom: matrixFromNotifier.value,
  );

  if (_slide != null){

    final List<DraftSlide> _updatedSlides = DraftSlide.replaceSlide(
      drafts: draftFlyerNotifier.value?.draftSlides,
      draft: _slide,
    );

    setNotifier(
        notifier: draftSlideNotifier,
        mounted: mounted,
        value: _slide,
    );

    setNotifier(
      notifier: draftFlyerNotifier,
      mounted: mounted,
      value: draftFlyerNotifier.value?.copyWith(
        draftSlides: _updatedSlides,
      ),
    );

  }

}
// -----------------------------------------------------------------------------
