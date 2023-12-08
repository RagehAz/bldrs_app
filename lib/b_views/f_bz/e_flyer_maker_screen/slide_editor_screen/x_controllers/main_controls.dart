import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SETTING SLIDE / FLYER

// --------------------
/// TESTED : WORKS PERFECT
void setDraftFlyerSlideMatrixes({
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required bool mounted,
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required Matrix4? matrix,
  required Matrix4? matrixFrom,
}){

  final DraftSlide? _slide = draftSlideNotifier.value?.copyWith(
    matrix: matrix,
    matrixFrom: matrixFrom,
  );

  if (_slide != null){

    setFlyerAndSlide(
      mounted: mounted,
      draftFlyerNotifier: draftFlyerNotifier,
      draftSlideNotifier: draftSlideNotifier,
      draftSlide: _slide,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void setFlyerAndSlide({
  required ValueNotifier<DraftSlide?> draftSlideNotifier,
  required ValueNotifier<DraftFlyer?> draftFlyerNotifier,
  required DraftSlide? draftSlide,
  required bool mounted,
}){

  if (draftSlide != null && draftSlideNotifier.value != null){

    final List<DraftSlide> _updatedSlides = DraftSlide.replaceSlide(
      drafts: draftFlyerNotifier.value?.draftSlides,
      draft: draftSlide,
    );

    setNotifier(
      notifier: draftSlideNotifier,
      mounted: mounted,
      value: draftSlide,
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

/// DEPRECATED

// --------------------
/*
/// TESTED : WORKS PERFECT
Future<void> onCancelSlideEdits({
  required BuildContext context,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onCancelSlideEdits',
  );

}
 */
// -----------------------------------------------------------------------------

/// CROPPING

// --------------------
/// NOT USED ANYMORE
/*
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

      final PicModel? _med = await SlidePicMaker.compressSlideBigPicTo(
          slidePic: _croppedBig,
          flyerID: draftNotifier.value!.flyerID,
          slideIndex: draftNotifier.value!.slideIndex,
          type: SlidePicType.med,
      );

      final PicModel? _small = await SlidePicMaker.compressSlideBigPicTo(
          slidePic: _croppedBig,
          flyerID: draftNotifier.value!.flyerID,
          slideIndex: draftNotifier.value!.slideIndex,
          type: SlidePicType.small,
      );

      final PicModel? _back = await SlidePicMaker.createSlideBackground(
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
 */
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
