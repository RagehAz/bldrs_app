import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class SlideEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorScreen({
    required this.slide,
    required this.draftFlyer,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftSlide? slide;
  final ValueNotifier<DraftFlyer?> draftFlyer;
  /// --------------------------------------------------------------------------
  @override
  State<SlideEditorScreen> createState() => _SlideEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _SlideEditorScreenState extends State<SlideEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final ValueNotifier<DraftSlide?> _draftSlide = ValueNotifier(null);
  final ValueNotifier<Matrix4?> _matrix = ValueNotifier(null);
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
    final DraftSlide? _initialSlide = widget.slide?.copyWith(
      matrix: initializeMatrix(slide: widget.slide),
    );

    /// SET DRAFT
    setNotifier(
        notifier: _draftSlide,
        mounted: mounted,
        value: _initialSlide,
    );

    /// SET MATRIX
    setNotifier(
      notifier: _matrix,
      mounted: mounted,
      value: _initialSlide?.matrix,
    );

    final bool _initialMatrixIsIdentity = Trinity.checkMatrixesAreIdentical(
      matrix1: _draftSlide.value?.matrix,
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

    // _matrix.addListener(() {
    //
    //   setNotifier(
    //       notifier: _draftSlide,
    //       mounted: mounted,
    //       value: _draftSlide.value?.copyWith(
    //         matrix: _matrix.value,
    //       ),
    //   );
    //
    // });

  }
  // --------------------
  @override
  void dispose() {
    _draftSlide.dispose();
    _isTransforming.dispose();
    _matrix.dispose();
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
      appBarType: AppBarType.non,
      child: Column(

        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            globalKey: globalKey,
            bzModel: widget.draftFlyer.value!.bzModel!,
            authorID: widget.draftFlyer.value!.authorID!,
            appBarType: AppBarType.non,
            height: _slideZoneHeight,
            draftSlide: _draftSlide,
            draftFlyer: widget.draftFlyer,
            matrixNotifier: _matrix,
            isTransforming: _isTransforming,
            mounted: mounted,
            onSlideTap: () async {
              await Keyboard.closeKeyboard();
            },
            isPlayingAnimation: _isPlayingAnimation,
            onSlideDoubleTap: () => onReplayAnimation(
              isPlayingAnimation: _isPlayingAnimation,
              canResetMatrix: _canResetMatrix,
              draftNotifier: _draftSlide,
              mounted: mounted,
            ),
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            canResetMatrix: _canResetMatrix,
            draftNotifier: _draftSlide,
            onTriggerAnimation: () => onTriggerAnimation(
              draftNotifier: _draftSlide,
              isPlayingAnimation: _isPlayingAnimation,
              canResetMatrix: _canResetMatrix,
              mounted: mounted,
            ),
            onCancel: () => onCancelSlideEdits(
              context: context,
            ),
            onResetMatrix: () => onResetMatrix(
              originalDraft: widget.slide,
              draftNotifier: _draftSlide,
              canResetMatrix: _canResetMatrix,
              matrix: _matrix,
              mounted: mounted,
            ),
            onCrop: () => onCropSlide(
              draftNotifier: _draftSlide,
              matrixNotifier: _matrix,
              bzID: widget.draftFlyer.value?.bzID,
              mounted: mounted,
            ),
            onConfirm: () => onConfirmSlideEdits(
              context: context,
              draftNotifier: _draftSlide,
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
