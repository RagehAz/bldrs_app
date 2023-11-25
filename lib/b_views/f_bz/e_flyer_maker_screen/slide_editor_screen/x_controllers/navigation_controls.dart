import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/b_slide_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/color_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/main_controls.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoNextSlide({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Matrix4?> matrixNotifier,
  required ValueNotifier<Matrix4?> matrixFromNotifier,
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
  required DraftSlide nextSlide,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    slideBackColor: slideBackColor,
    draftSlideNotifier: draftSlideNotifier,
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
  );

  setDraftFlyerSlideMatrixes(
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
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
  required DraftSlide previousSlide,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    slideBackColor: slideBackColor,
    draftSlideNotifier: draftSlideNotifier,
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
  );

  setDraftFlyerSlideMatrixes(
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
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
  required bool mounted,
}) async {

  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    slideBackColor: slideBackColor,
    draftSlideNotifier: draftSlideNotifier,
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
  );

  setDraftFlyerSlideMatrixes(
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
// -----------------------------------------------------------------------------
