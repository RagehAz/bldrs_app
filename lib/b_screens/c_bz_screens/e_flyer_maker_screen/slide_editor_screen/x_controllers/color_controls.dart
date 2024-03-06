import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/x_controllers/main_controls.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<MediaModel?> initializeSlideBlur({
  required DraftSlide? slide,
}) async {
  MediaModel? _backPic = slide?.backPic;

  return _backPic ??= await SlidePicMaker.createSlideBackground(
    bigPic: slide?.medPic ?? slide?.bigPic,
    flyerID: slide?.flyerID,
    slideIndex: slide?.slideIndex,
    overrideSolidColor: null,
  );

}
// -----------------------------------------------------------------------------

/// PANEL

// --------------------
/// TESTED : WORKS PERFECT
void onTriggerColorPanel({
  required ValueNotifier<bool> showAnimationPanel,
  required bool mounted,
  required ValueNotifier<bool> showColorPanel,
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
}){

  /// SWITCH OFF ANIMATION PANEL
  setNotifier(
    notifier: showAnimationPanel,
    mounted: mounted,
    value: false,
  );

  /// TRIGGER COLOR PANEL
  setNotifier(
    notifier: showColorPanel,
    mounted: mounted,
    value: !showColorPanel.value,
  );

  /// SWITCH OFF COLOR PICKER
  if (showColorPanel.value == false){
    switchOffColorPicker(
      isPickingBackColor: isPickingBackColor,
      slideBackColor: slideBackColor,
      draftSlideNotifier: draftSlideNotifier,
      draftFlyerNotifier: draftFlyerNotifier,
      mounted: mounted,
    );
  }

}
// -----------------------------------------------------------------------------

/// COLOR PICKER

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchColorPicker({
  required ValueNotifier<bool> isPickingBackColor,
  required bool switchTo,
  required bool mounted,
}){

  setNotifier(
    notifier: isPickingBackColor,
    mounted: mounted,
    value: switchTo,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void switchOffColorPicker({
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Color?> slideBackColor,
  required bool mounted,
}){

  if (isPickingBackColor.value == true){

    onSwitchColorPicker(
      isPickingBackColor: isPickingBackColor,
      switchTo: false,
      mounted: mounted,
    );

    /// UPDATE SLIDE AND FLYER
    _updateSlideColor(
      draftSlideNotifier: draftSlideNotifier,
      mounted: mounted,
      draftFlyerNotifier: draftFlyerNotifier,
      color: slideBackColor.value,
    );

  }



}
// -----------------------------------------------------------------------------

/// BUTTONS

// --------------------
/// TESTED : WORKS PERFECT
void onBlurBackTap({
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<Color?> slideBackColor,
  required ValueNotifier<bool> isPickingBackColor,
  required MediaModel? blurPic,
}){

    /// CLEAR COLOR
    setNotifier(
      notifier: slideBackColor,
      mounted: mounted,
      value: null,
    );

    /// SWITCH OFF COLOR PICKER
    setNotifier(
      notifier: isPickingBackColor,
      mounted: mounted,
      value: false,
    );

    /// UPDATE SLIDE AND FLYER
    _updateSlideBlur(
      draftSlideNotifier: draftSlideNotifier,
      mounted: mounted,
      draftFlyerNotifier: draftFlyerNotifier,
      blurPic: blurPic,
    );

}
// --------------------
/// TESTED : WORKS PERFECT
void onWhiteBackTap({
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
}){

  /// SWITCH OFF COLOR PICKER
  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
    slideBackColor: slideBackColor,
    mounted: mounted,
  );

  /// SET PICKED COLOR
  setNotifier(
    notifier: slideBackColor,
    mounted: mounted,
    value: Colorz.white255,
  );

  /// UPDATE SLIDE AND FLYER
  _updateSlideColor(
    draftSlideNotifier: draftSlideNotifier,
    mounted: mounted,
    draftFlyerNotifier: draftFlyerNotifier,
    color: Colorz.white255,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onBlackBackTap({
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<bool> isPickingBackColor,
  required ValueNotifier<Color?> slideBackColor,
}){

  /// SWITCH OFF COLOR PICKER
  switchOffColorPicker(
    isPickingBackColor: isPickingBackColor,
    draftFlyerNotifier: draftFlyerNotifier,
    draftSlideNotifier: draftSlideNotifier,
    slideBackColor: slideBackColor,
    mounted: mounted,
  );

  /// SET PICKED COLOR
  setNotifier(
    notifier: slideBackColor,
    mounted: mounted,
    value: Colorz.black255,
  );

  /// UPDATE SLIDE AND FLYER
  _updateSlideColor(
    draftSlideNotifier: draftSlideNotifier,
    mounted: mounted,
    draftFlyerNotifier: draftFlyerNotifier,
    color: Colorz.black255,
  );


}
// --------------------
/// TESTED : WORKS PERFECT
void onColorPickerTap({
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required ValueNotifier<bool> isPickingBackColor,
}){

  /// SWITCH ON COLOR PICKER
  onSwitchColorPicker(
    mounted: mounted,
    isPickingBackColor: isPickingBackColor,
    switchTo: true,
  );

}
// -----------------------------------------------------------------------------

/// UPDATING SLIDE

// --------------------
/// TESTED : WORKS PERFECT
void _updateSlideColor({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required bool mounted,
  required Color? color,
}){

  DraftSlide? _slide = draftSlideNotifier.value;

  /// CLEAR BLUR PIC
  _slide = _slide?.nullifyField(
    backPic: true,
  );

  /// UPDATE BACK COLOR
  _slide = _slide?.copyWith(
    backColor: color,
  );

  /// SET FLYER AND SLIDE
  setFlyerAndSlide(
    draftSlide: _slide,
    draftSlideNotifier: draftSlideNotifier,
    draftFlyerNotifier: draftFlyerNotifier,
    mounted: mounted,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _updateSlideBlur({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required MediaModel? blurPic,
  required bool mounted,
}) async {

  DraftSlide? _slide = draftSlideNotifier.value;

  if (_slide != null){

    /// CLEAR COLOR
    _slide = _slide.nullifyField(
      backColor: true,
    );

    _slide = _slide.copyWith(
      backPic: blurPic,
    );

    setFlyerAndSlide(
        draftSlideNotifier: draftSlideNotifier,
        draftFlyerNotifier: draftFlyerNotifier,
        draftSlide: _slide,
        mounted: mounted
    );

  }

}
// -----------------------------------------------------------------------------
