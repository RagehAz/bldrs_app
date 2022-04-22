import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/filter_selector_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_layers.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/preset_filters.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as imageLib;

class SlideEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorScreen({
    @required this.slide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final MutableSlide slide;
  /// --------------------------------------------------------------------------
  @override
  State<SlideEditorScreen> createState() => _SlideEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _SlideEditorScreenState extends State<SlideEditorScreen> {

// -----------------------------------------------------------------------------
  ValueNotifier<MutableSlide> _slide;
  ValueNotifier<Matrix4> _matrix;
  ValueNotifier<ColorFilterModel> _filterModel;
  List<ColorFilterModel> _allFilters;
  int _filterIndex;
// ------------------------------------
  @override
  void initState() {

    _allFilters = bldrsImageFilters(context);

    _slide = ValueNotifier<MutableSlide>(widget.slide.copyWith());
    _matrix = ValueNotifier(_initializeMatrix());
    _filterModel = ValueNotifier(_slide.value.filter ?? _allFilters[0]);

    _filterIndex = _initializeFilterIndex();

    super.initState();
  }
// -----------------------------------------------------------------------------
  int _initializeFilterIndex(){
    final int _index = _slide.value.filter == null ?
        0
        :
    _allFilters.indexWhere((filter) => filter.name == _slide.value.filter.name);

    return _index == -1 ? 0 : _index;
  }
// -----------------------------------------------------------------------------
  Matrix4 _initializeMatrix(){
    Matrix4 _output;
    if (_slide.value.matrix == null){
      _output = Matrix4.identity();
    }

    else {
      _output = _slide.value.matrix;
    }
    return _output;
  }
// -----------------------------------------------------------------------------
  Future<void> _onReset() async {

    // if (_slide.value.picFit == BoxFit.fitWidth){
    //   _slide.value = _slide.value.updatePicFit(BoxFit.fitHeight);
    // }
    // else {
    //   _slide.value = _slide.value.updatePicFit(BoxFit.fitWidth);
    // }

    _matrix.value = Matrix4.identity();

  }
// -----------------------------------------------------------------------------
  void _onBack(){
    goBack(context, argument: _slide.value);
  }
// -----------------------------------------------------------------------------
  Future<void> _onConfirm() async {

    // widget.slide.matrix = _matrix.value;
    // widget.slide.filter = _filterModel.value;
    final MutableSlide _slide = widget.slide.copyWith(
      matrix: _matrix.value,
      filter: _filterModel.value,
    );

    goBack(context, argument: _slide);

    blog('confirming stuff aho');

  }
// -----------------------------------------------------------------------------
  void _onToggleFilter(){

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

    _filterIndex++;
    if (_filterIndex >= _allFilters.length){
      _filterIndex = 0;
    }
    _filterModel.value = _allFilters[_filterIndex];

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, _screenHeight);
    final double _controlPanelHeight = SlideEditorControlPanel.getControlPanelHeight(context, _screenHeight);

    return MainLayout(
      skyType: SkyType.non,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarType: AppBarType.non,
      layoutWidget: Column(

        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            height: _slideZoneHeight,
            slide: _slide,
            matrix: _matrix,
            filterModel: _filterModel,
            onSlideTap: _onToggleFilter,
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onReset: _onReset,
            onConfirm: _onConfirm,
            onCancel: _onBack,
          ),


        ],

      ),
    );
  }
}
