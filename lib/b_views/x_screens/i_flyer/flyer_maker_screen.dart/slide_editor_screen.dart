import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/slide_editor_controller.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
  ValueNotifier<MutableSlide> _slide; /// tamam disposed
  ValueNotifier<Matrix4> _matrix; /// tamam disposed
  ValueNotifier<ImageFilterModel> _filterModel; /// tamam disposed
// ------------------------------------
  @override
  void initState() {

    _slide = ValueNotifier<MutableSlide>(widget.slide.copyWith());

    blog('slide filter is ${_slide.value.filter.id} and initial filter is : ${_allFilters[0].id}');

    _filterModel = ValueNotifier(_slide.value.filter ?? _allFilters[0]);

    _matrix = initializeMatrix(
        slide: _slide.value
    );

    // _filterIndex = initializeFilterIndex(
    //   slide: _slide.value,
    // );

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _slide.dispose();
    _matrix.dispose();
    _filterModel.dispose();
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
            slide: _slide,
            matrix: _matrix,
            filterModel: _filterModel,
            onSlideTap: () => onToggleFilter(
                currentFilter: _filterModel,
            ),
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            onReset: () => onReset(
                filter: _filterModel,
                matrix: _matrix
            ),
            onConfirm: () => onConfirmSlideEdits(
                context: context,
                originalSlide: widget.slide,
                filter: _filterModel,
                matrix: _matrix,
            ),
            onCancel: () => onCancelSlideEdits(
              context: context,
            ),
          ),


        ],

      ),
    );
  }
}
