import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:space_time/space_time.dart';
import 'package:scale/scale.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class SlideEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorScreen({
    @required this.slide,
    @required this.draftFlyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftSlide slide;
  final ValueNotifier<DraftFlyer> draftFlyer;
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
  final ValueNotifier<DraftSlide> _draftNotifier = ValueNotifier(null);
  final ValueNotifier<Matrix4> _matrix = ValueNotifier(null);
  final ValueNotifier<ImageFilterModel> _filterModel = ValueNotifier(null);
  final ValueNotifier<bool> _isTransforming = ValueNotifier(false);
  final ValueNotifier<bool> _canResetMatrix = ValueNotifier(false);
  final ValueNotifier<bool> _isPlayingAnimation = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    initializeTempSlide();
  }
  // --------------------
  void initializeTempSlide(){

    /// INITIALIZE TEMP SLIDE
    final DraftSlide _initialSlide = widget.slide.copyWith(
      filter: widget.slide?.filter ?? _allFilters[0],
      matrix: initializeMatrix(slide: widget.slide),
    );

    /// SET DRAFT
    setNotifier(
        notifier: _draftNotifier,
        mounted: mounted,
        value: _initialSlide,
    );

    /// SET MATRIX
    setNotifier(
      notifier: _matrix,
      mounted: mounted,
      value: _initialSlide.matrix,
    );

    /// SET FILTER
    setNotifier(
      notifier: _filterModel,
      mounted: mounted,
      value: _initialSlide.filter ?? _allFilters[0],
    );

    final bool _initialMatrixIsIdentity = Trinity.checkMatrixesAreIdentical(
      matrix1: _draftNotifier.value.matrix,
      matrixReloaded: Matrix4.identity(),
    );

    /// SET CAN RESET
    setNotifier(
      notifier: _canResetMatrix,
      mounted: mounted,
      value: !_initialMatrixIsIdentity,
    );

    /// LISTEN TO MATRIX
    _isTransforming.addListener(() async {
      if (_isTransforming.value  == true){

        if (_canResetMatrix.value == false){
          setNotifier(
            notifier: _canResetMatrix,
            mounted: mounted,
            value: true,
          );
        }

        await Future.delayed(const Duration(seconds: 1), (){

          setNotifier(
              notifier: _isTransforming,
              mounted: mounted,
              value: false,
          );

        });
      }
    });

    _matrix.addListener(() {

      setNotifier(
          notifier: _draftNotifier,
          mounted: mounted,
          value: _draftNotifier.value.copyWith(
            matrix: _matrix.value,
          ),
      );

    });

  }
  // --------------------
  @override
  void dispose() {
    _draftNotifier.dispose();
    _isTransforming.dispose();
    _matrix.dispose();
    _filterModel.dispose();
    _canResetMatrix.dispose();
    _isPlayingAnimation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, _screenHeight);
    final double _controlPanelHeight = SlideEditorControlPanel.getControlPanelHeight(context, _screenHeight);
    // --------------------
    return MainLayout(
      skyType: SkyType.non,
      appBarType: AppBarType.non,
      child: Column(

        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            globalKey: globalKey,
            appBarType: AppBarType.non,
            height: _slideZoneHeight,
            draftSlide: _draftNotifier,
            matrix: _matrix,
            filterModel: _filterModel,
            isTransforming: _isTransforming,
            mounted: mounted,
            onSlideTap: (){
              blog('slide is tapped ahowann');
            },
            isPlayingAnimation: _isPlayingAnimation,
            onSlideDoubleTap: () => onReplayAnimation(
              isPlayingAnimation: _isPlayingAnimation,
              canResetMatrix: _canResetMatrix,
              draftNotifier: _draftNotifier,
              mounted: mounted,
            ),
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            canResetMatrix: _canResetMatrix,
            draftNotifier: _draftNotifier,
            onTriggerAnimation: () => onTriggerAnimation(
              draftNotifier: _draftNotifier,
              isPlayingAnimation: _isPlayingAnimation,
              canResetMatrix: _canResetMatrix,
              mounted: mounted,
            ),
            onCancel: () => onCancelSlideEdits(
              context: context,
            ),
            onResetMatrix: () => onResetMatrix(
              context: context,
              originalDraft: widget.slide,
              draftNotifier: _draftNotifier,
              canResetMatrix: _canResetMatrix,
              matrix: _matrix,
              mounted: mounted,
            ),
            onToggleFilter: () => onToggleFilter(
              draftNotifier: _draftNotifier,
              currentFilter: _filterModel,
              mounted: mounted,
            ),
            onCrop: () => onCropSlide(
              context: context,
              draftNotifier: _draftNotifier,
              filterNotifier: _filterModel,
              matrixNotifier: _matrix,
              bzID: widget.draftFlyer.value.bzID,
              mounted: mounted,
            ),
            onConfirm: () => onConfirmSlideEdits(
              context: context,
              draftNotifier: _draftNotifier,
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
