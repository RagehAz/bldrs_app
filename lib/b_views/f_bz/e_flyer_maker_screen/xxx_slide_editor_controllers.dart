import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
Matrix4 initializeMatrix({
  @required MutableSlide slide,
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
Future<void> onReset({
  @required MutableSlide originalSlide,
  @required ValueNotifier<MutableSlide> tempSlide,
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
Future<void> onCropSlide({
  @required BuildContext context,
  @required ValueNotifier<MutableSlide> tempSlide,
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {

  final FileModel _fileModel = await Imagers.cropImage(
    context: context,
    pickedFile: tempSlide.value.picFileModel,
    isFlyerRatio: true,
  );

  if (_fileModel != null){

    final ImageSize _imageSize = await ImageSize.superImageSize(_fileModel);
    final Color _midColor = await Colorizer.getAverageColor(_fileModel);
    final MutableSlide _updatedSlide = tempSlide.value.copyWith(
      picFileModel: _fileModel,
      imageSize: _imageSize,
      midColor: _midColor,
      matrix: matrix.value,
      filter: filter.value,
    );

    tempSlide.value = _updatedSlide;

  }

}
// --------------------
void onToggleFilter({
  @required ValueNotifier<MutableSlide> tempSlide,
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
  @required ValueNotifier<MutableSlide> tempSlide,
  @required String text,
}){

  blog('onSlideHeadlineChanged : this should put the text and update temp slide and temp flyer and shit gets nasty');

}
// -----------------------------------------------------------------------------

/// CONFIRMATION - CANCELLING

// --------------------
Future<void> onCancelSlideEdits({
  @required BuildContext context,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onCancelSlideEdits',
  );

}
// --------------------
Future<void> onConfirmSlideEdits({
  @required BuildContext context,
  @required MutableSlide originalSlide,
  @required ValueNotifier<MutableSlide> tempSlide,
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {

  final MutableSlide _slide = tempSlide.value.copyWith(
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
