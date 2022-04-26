import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
ValueNotifier<Matrix4> initializeMatrix({
  @required MutableSlide slide,
}){
  Matrix4 _output;
  if (slide.matrix == null){
    _output = Matrix4.identity();
  }

  else {
    _output = slide.matrix;
  }
  return ValueNotifier(_output);
}
// -----------------------------------------------------------------------------
Future<void> onReset({
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {

  filter.value = ImageFilterModel.noFilter();
  matrix.value = Matrix4.identity();

}
// -----------------------------------------------------------------------------
Future<void> onConfirmSlideEdits({
  @required BuildContext context,
  @required MutableSlide originalSlide,
  @required ValueNotifier<ImageFilterModel> filter,
  @required ValueNotifier<Matrix4> matrix,
}) async {

  final MutableSlide _slide = originalSlide.copyWith(
    matrix: matrix.value,
    filter: filter.value,
  );

  Nav.goBack(context, argument: _slide);

}
// -----------------------------------------------------------------------------
void onCancelSlideEdits({
  @required BuildContext context,
}){

  Nav.goBack(context);

}
// -----------------------------------------------------------------------------
void onToggleFilter({
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

  final List<ImageFilterModel> _bldrsFilters = ImageFilterModel.bldrsImageFilters;
  int _filterIndex = _bldrsFilters.indexWhere((fil) => fil.id == currentFilter.value.id);

  _filterIndex++;
  if (_filterIndex >= _bldrsFilters.length){
    _filterIndex = 0;
  }

  currentFilter.value = _bldrsFilters[_filterIndex];

}
// -----------------------------------------------------------------------------
