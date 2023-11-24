import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class SlideEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorScreen({
    required this.slide,
    required this.draftFlyerNotifier,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftSlide? slide;
  final ValueNotifier<DraftFlyer?> draftFlyerNotifier;
  /// --------------------------------------------------------------------------
  @override
  State<SlideEditorScreen> createState() => _SlideEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _SlideEditorScreenState extends State<SlideEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final ValueNotifier<DraftSlide?> _draftSlideNotifier = ValueNotifier(null);
  // --------------------
  /// ANIMATION
  final ValueNotifier<bool> _isPlayingAnimation = ValueNotifier(false);
  final ValueNotifier<Matrix4?> _matrixNotifier = ValueNotifier(null);
  final ValueNotifier<Matrix4?> _matrixFromNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _isDoingMatrixFrom = ValueNotifier(false);
  final ValueNotifier<bool> _isTransforming = ValueNotifier(false);
  final ValueNotifier<bool> _canResetMatrix = ValueNotifier(false);
  final ValueNotifier<bool> _showAnimationPanel = ValueNotifier(false);
  // --------------------
  /// COLOR
  final ValueNotifier<bool> _isPickingBackColor = ValueNotifier(false);
  final ValueNotifier<bool> _showColorPanel = ValueNotifier(false);
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
      matrix: widget.slide?.matrix ?? Matrix4.identity(),
      matrixFrom: widget.slide?.matrixFrom ?? Matrix4.identity(),
    );

    /// SET DRAFT
    setNotifier(
        notifier: _draftSlideNotifier,
        mounted: mounted,
        value: _initialSlide,
    );

    /// SET MATRIX
    setNotifier(
      notifier: _matrixNotifier,
      mounted: mounted,
      value: _initialSlide?.matrix,
    );

    /// SET MATRIX FROM
    setNotifier(
      notifier: _matrixFromNotifier,
      mounted: mounted,
      value: _initialSlide?.matrixFrom,
    );

    final bool _initialMatrixIsIdentity = Trinity.checkMatrixesAreIdentical(
      matrix1: _draftSlideNotifier.value?.matrix,
      matrixReloaded: Matrix4.identity(),
    );

    final bool _initialMatrixFromIsIdentity = Trinity.checkMatrixesAreIdentical(
      matrix1: _draftSlideNotifier.value?.matrixFrom,
      matrixReloaded: Matrix4.identity(),
    );

    /// SET CAN RESET
    setNotifier(
      notifier: _canResetMatrix,
      mounted: mounted,
      value: _initialMatrixIsIdentity == false || _initialMatrixFromIsIdentity == false,
    );

    /// LISTEN TO TRANSFORMING
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

  }
  // --------------------
  @override
  void dispose() {
    _draftSlideNotifier.dispose();
    _isTransforming.dispose();
    _matrixNotifier.dispose();
    _matrixFromNotifier.dispose();
    _isDoingMatrixFrom.dispose();
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
    final double _flyerBoxWidth = SlideEditorSlidePart.getFlyerZoneWidth(_slideZoneHeight);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth:_flyerBoxWidth,
    );
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      appBarType: AppBarType.non,
      child: Column(
        children: <Widget>[

          /// SLIDE
          SlideEditorSlidePart(
            globalKey: globalKey,
            bzModel: widget.draftFlyerNotifier.value!.bzModel!,
            authorID: widget.draftFlyerNotifier.value!.authorID!,
            appBarType: AppBarType.non,
            height: _slideZoneHeight,
            draftSlide: _draftSlideNotifier,
            draftFlyer: widget.draftFlyerNotifier,
            matrixNotifier: _matrixNotifier,
            matrixFromNotifier: _matrixFromNotifier,
            isDoingMatrixFrom: _isDoingMatrixFrom,
            isTransforming: _isTransforming,
            mounted: mounted,
            onSlideTap: () async {
              await Keyboard.closeKeyboard();
            },
            isPlayingAnimation: _isPlayingAnimation,
            isPickingBackColor: _isPickingBackColor,
            onSlideDoubleTap: () => onReplayAnimation(
              isPlayingAnimation: _isPlayingAnimation,
              canResetMatrix: _canResetMatrix,
              draftNotifier: _draftSlideNotifier,
              mounted: mounted,
            ),
            onTriggerSlideIsAnimated: () => onTriggerSlideIsAnimated(
              draftNotifier: _draftSlideNotifier,
              isPlayingAnimation: _isPlayingAnimation,
              isDoingMatrixFrom: _isDoingMatrixFrom,
              canResetMatrix: _canResetMatrix,
              mounted: mounted,
            ),
            onResetMatrix: () => onResetMatrix(
              originalDraft: widget.slide,
              draftSlideNotifier: _draftSlideNotifier,
              canResetMatrix: _canResetMatrix,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              mounted: mounted,
              draftFlyerNotifier: widget.draftFlyerNotifier,
              flyerBoxHeight: _flyerBoxHeight,
              flyerBoxWidth: _flyerBoxWidth,
            ),
            canResetMatrix: _canResetMatrix,
            showColorPanel: _showColorPanel,
            showAnimationPanel: _showAnimationPanel,
          ),

          /// CONTROL PANEL
          SlideEditorControlPanel(
            height: _controlPanelHeight,
            draftSlideNotifier: _draftSlideNotifier,
            draftFlyerNotifier: widget.draftFlyerNotifier,
            onNextSlide: (DraftSlide nextSlide) => onGoNextSlide(
              draftSlideNotifier: _draftSlideNotifier,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              mounted: mounted,
              draftFlyerNotifier: widget.draftFlyerNotifier,
              nextSlide: nextSlide,
            ),
            onPreviousSlide: (DraftSlide previousSlide) => onGoPreviousSlide(
              draftSlideNotifier: _draftSlideNotifier,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              mounted: mounted,
              draftFlyerNotifier: widget.draftFlyerNotifier,
              previousSlide: previousSlide,
            ),
            onFirstSlideBack: () => onExitSlideEditor(
              draftFlyerNotifier: widget.draftFlyerNotifier,
              draftSlideNotifier: _draftSlideNotifier,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              mounted: mounted,
            ),
            onLastSlideNext: () => onExitSlideEditor(
              draftFlyerNotifier: widget.draftFlyerNotifier,
              draftSlideNotifier: _draftSlideNotifier,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              mounted: mounted,
            ),
            showAnimationPanel: _showAnimationPanel,
            showColorPanel: _showColorPanel,
            onTriggerAnimationPanel: (){

              /// SWITCH OFF COLOR PANEL
              setNotifier(
                  notifier: _showColorPanel,
                  mounted: mounted,
                  value: false,
              );

              /// TRIGGER ANIMATION PANEL
              setNotifier(
                notifier: _showAnimationPanel,
                mounted: mounted,
                value: !_showAnimationPanel.value,
              );

            },
            onTriggerColorPanel: (){

              /// SWITCH OFF ANIMATION PANEL
              setNotifier(
                  notifier: _showAnimationPanel,
                  mounted: mounted,
                  value: false,
              );

              /// TRIGGER COLOR PANEL
              setNotifier(
                  notifier: _showColorPanel,
                  mounted: mounted,
                  value: !_showColorPanel.value,
              );

            },
          ),

        ],

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
