import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/xxx_slide_editor_controllers.dart';
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
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final List<ImageFilterModel> _allFilters = ImageFilterModel.bldrsImageFilters;
  // --------------------
  ValueNotifier<MutableSlide> _tempSlide;
  ValueNotifier<Matrix4> _matrix;
  ValueNotifier<ImageFilterModel> _filterModel;
  final ValueNotifier<bool> _isTransforming = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeTempSlide();
  }
  // --------------------
  void initializeTempSlide(){

    /// INITIALIZE TEMP SLIDE
    final MutableSlide _initialSlide = widget.slide.copyWith(
      filter: widget.slide?.filter ?? _allFilters[0],
      matrix: initializeMatrix(
        slide: widget.slide,
      ),
    );
    _tempSlide = ValueNotifier<MutableSlide>(_initialSlide);
    _matrix = ValueNotifier(_initialSlide.matrix);
    _filterModel = ValueNotifier(_initialSlide.filter ?? _allFilters[0]);

    _isTransforming.addListener(() async {
      if (_isTransforming.value == true){
        await Future.delayed(const Duration(seconds: 1), (){
          _isTransforming.value = false;
        });
      }
    });

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _tempSlide.dispose();
    _isTransforming.dispose();
    _matrix.dispose();
    _filterModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, _screenHeight);
    final double _controlPanelHeight = SlideEditorControlPanel.getControlPanelHeight(context, _screenHeight);
    // --------------------
    return MainLayout(
      skyType: SkyType.non,
      sectionButtonIsOn: false,
      appBarType: AppBarType.non,
      layoutWidget: Column(

        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            globalKey: globalKey,
            appBarType: AppBarType.non,
            height: _slideZoneHeight,
            tempSlide: _tempSlide,
            matrix: _matrix,
            filterModel: _filterModel,
            isTransforming: _isTransforming,
            onSlideTap: () => onToggleFilter(
              tempSlide: _tempSlide,
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
              originalSlide: widget.slide,
              tempSlide: _tempSlide,
              filter: _filterModel,
              matrix: _matrix,
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
              tempSlide: _tempSlide,
              filter: _filterModel,
              matrix: _matrix,
            ),
          ),

        ],

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
