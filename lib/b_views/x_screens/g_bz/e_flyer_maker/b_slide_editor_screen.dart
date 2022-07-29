import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/b_slide_editor_controllers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

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
  final List<ImageFilterModel> _allFilters = ImageFilterModel.bldrsImageFilters;
  // ------------------------------------
  ValueNotifier<MutableSlide> _tempSlide; /// tamam disposed
  ValueNotifier<Matrix4> _matrix; /// tamam disposed
  ValueNotifier<ImageFilterModel> _filterModel; /// tamam disposed
  final ValueNotifier<bool> _isTransforming = ValueNotifier(false); /// tamam disposed
// ------------------------------------
  @override
  void initState() {

    _tempSlide = ValueNotifier<MutableSlide>(widget.slide);

    blog('slide filter is ${_tempSlide.value.filter.id} and initial filter is : ${_allFilters[0].id}');

    _filterModel = ValueNotifier(_tempSlide.value?.filter ?? _allFilters[0]);

    _matrix = initializeMatrix(
        slide: _tempSlide.value
    );

    _isTransforming.addListener(() async {
      if (_isTransforming.value == true){
        await Future.delayed(const Duration(seconds: 1), (){
          _isTransforming.value = false;
        });
      }
    });

    // _filterIndex = initializeFilterIndex(
    //   slide: _slide.value,
    // );

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tempSlide.dispose();
    _matrix.dispose();
    _filterModel.dispose();
    _isTransforming.dispose();
    super.dispose(); /// tamam
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
            tempSlide: _tempSlide,
            matrix: _matrix,
            filterModel: _filterModel,
            isTransforming: _isTransforming,
            onSlideTap: () => onToggleFilter(
                currentFilter: _filterModel,
            ),
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onCancel: () => onCancelSlideEdits(
              context: context,
            ),
            onReset: () => onReset(
              filter: _filterModel,
              matrix: _matrix,
              originalSlide: widget.slide,
              tempSlide: _tempSlide
            ),
            onCrop: () => onCropSlide(
              context: context,
              tempSlide: _tempSlide,
              filter: _filterModel,
              matrix: _matrix,
            ),
            onConfirm: () => onConfirmSlideEdits(
              context: context,
              originalSlide: widget.slide,
              filter: _filterModel,
              matrix: _matrix,
              tempSlide: _tempSlide,
            ),
          ),

        ],

      ),
    );
  }
}
