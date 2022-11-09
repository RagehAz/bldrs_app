import 'dart:typed_data';

import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
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

/// SLIDE MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReset({
  @required DraftSlide originalSlide,
  @required ValueNotifier<DraftSlide> tempSlide,
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {
  tempSlide.value = originalSlide.copyWith(
    matrix: Matrix4.identity(),
    filter: ImageFilterModel.noFilter(),
  );
  filter.value = ImageFilterModel.noFilter();
  matrix.value = Matrix4.identity();
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCropSlide({
  @required BuildContext context,
  @required ValueNotifier<DraftSlide> draftNotifier,
  @required ValueNotifier<ImageFilterModel> filterNotifier,
  @required ValueNotifier<Matrix4> matrixNotifier,
  @required String bzID,
}) async {

  final Uint8List _bytes = await PicMaker.cropPic(
    context: context,
    bytes: draftNotifier.value.picModel.bytes,
    aspectRatio: FlyerDim.flyerAspectRatio,
  );

  if (_bytes != null){

    draftNotifier.value = draftNotifier.value.copyWith(
      midColor: await Colorizer.getAverageColor(_bytes),
      picModel: draftNotifier.value.picModel.copyWith(
        bytes: _bytes,
      ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onToggleFilter({
  @required ValueNotifier<DraftSlide> tempSlide,
  @required ValueNotifier<ImageFilterModel> currentFilter,
}){

  /// --------------------------------------------- FOR TESTING START
  // _index = _index == 0 ? 1 : 0;
  // const Color _color = Color.fromRGBO(210, 137, 28, 1.0);
  //
  // blog('color : ${_color.value}');
  //
  // final _fii = _index == 0 ?
  // bldrsImageFilters(context)[0]
  //     :
  // ColorFilterModel(
  //   name: 'cool',
  //   matrixes: <List<double>>[
  //     ColorFilterLayer.sepia(0.1),
  //     ColorFilterLayer.colorOverlay(255, 145, 0, 0.1),
  //     ColorFilterLayer.brightness(10),
  //     ColorFilterLayer.saturation(15),
  //   ],
  // );
  // _filterModel.value = _fii;
  /// --------------------------------------------- FOR TESTING END

  final ImageFilterModel _currentFilter = currentFilter.value;

  final List<ImageFilterModel> _bldrsFilters = ImageFilterModel.bldrsImageFilters;
  int _filterIndex = _bldrsFilters.indexWhere((fil) => fil.id == _currentFilter.id);

  _filterIndex++;
  if (_filterIndex >= _bldrsFilters.length){
    _filterIndex = 0;
  }

  tempSlide.value = tempSlide.value.copyWith(
    filter: _bldrsFilters[_filterIndex],
  );
  currentFilter.value = _bldrsFilters[_filterIndex];
}
// --------------------
void onSlideHeadlineChanged({
  @required ValueNotifier<DraftSlide> tempSlide,
  @required String text,
}){

  blog('onSlideHeadlineChanged : this should put the text and update temp slide and temp flyer and shit gets nasty');

}
// -----------------------------------------------------------------------------

/// CONFIRMATION - CANCELLING

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
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmSlideEdits({
  @required BuildContext context,
  @required DraftSlide originalSlide,
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
