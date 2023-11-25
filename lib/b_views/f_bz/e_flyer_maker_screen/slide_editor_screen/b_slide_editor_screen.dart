import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/pixels/pixel_color_picker.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/animation_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/color_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/main_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/x_controllers/navigation_controls.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_editor_main_control_panel.dart';
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
  final ValueNotifier<Color?> _slideBackColor = ValueNotifier(null);
  final ValueNotifier<bool> _loadingColorPicker = ValueNotifier(false);
  PicModel? _blurBackPic;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    initializeTempSlide();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        _blurBackPic = await initializeSlideBlur(
          slide: widget.slide,
        );

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  void initializeTempSlide(){

    /// INITIALIZE ANIMATION
    initializeSlideAnimation(
      slide: widget.slide,
      mounted: mounted,
      draftSlideNotifier: _draftSlideNotifier,
      matrixNotifier: _matrixNotifier,
      matrixFromNotifier: _matrixFromNotifier,
      canResetMatrix: _canResetMatrix,
      isTransforming: _isTransforming,
    );

    /// INITIALIZE COLOR
    setNotifier(
      notifier: _slideBackColor,
      mounted: mounted,
      value: widget.slide?.backColor,
    );

  }
  // --------------------
  @override
  void dispose() {

    _draftSlideNotifier.dispose();

    _isPlayingAnimation.dispose();
    _matrixNotifier.dispose();
    _matrixFromNotifier.dispose();
    _isDoingMatrixFrom.dispose();
    _isTransforming.dispose();
    _canResetMatrix.dispose();
    _showAnimationPanel.dispose();

    _isPickingBackColor.dispose();
    _showColorPanel.dispose();
    _slideBackColor.dispose();
    _loadingColorPicker.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, _screenHeight);
    final double _controlPanelHeight = SlideEditorMainControlPanel.getControlPanelHeight(context, _screenHeight);
    final double _flyerBoxWidth = SlideEditorSlidePart.getFlyerZoneWidth(_slideZoneHeight);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth:_flyerBoxWidth,
    );
    // --------------------
    return PixelColorPicker(
      initialColor: _draftSlideNotifier.value?.midColor ?? Colorz.nothing,
      isOn: _isPickingBackColor,
      mounted: mounted,
      pickedColor: _slideBackColor,
      loading: _loadingColorPicker,
      indicatorSize: 40,
      child: MainLayout(
        canSwipeBack: false,
        appBarType: AppBarType.non,
        child: Column(
          children: <Widget>[

            /// SLIDE
            SlideEditorSlidePart(
              globalKey: globalKey,
              bzModel: widget.draftFlyerNotifier.value!.bzModel!,
              authorID: widget.draftFlyerNotifier.value!.authorID!,
              draftFlyer: widget.draftFlyerNotifier,
              appBarType: AppBarType.non,
              height: _slideZoneHeight,
              draftSlide: _draftSlideNotifier,
              matrixNotifier: _matrixNotifier,
              matrixFromNotifier: _matrixFromNotifier,
              isDoingMatrixFrom: _isDoingMatrixFrom,
              isTransforming: _isTransforming,
              mounted: mounted,
              isPlayingAnimation: _isPlayingAnimation,
              isPickingBackColor: _isPickingBackColor,
              slideBackColor: _slideBackColor,
              canResetMatrix: _canResetMatrix,
              showColorPanel: _showColorPanel,
              showAnimationPanel: _showAnimationPanel,
              loadingColorPicker: _loadingColorPicker,

              /// SLIDE TAPS
              onSlideTap: () => Keyboard.closeKeyboard(),
              onSlideDoubleTap: () => onReplayAnimation(
                isPlayingAnimation: _isPlayingAnimation,
                canResetMatrix: _canResetMatrix,
                draftNotifier: _draftSlideNotifier,
                mounted: mounted,
              ),

              /// HEADLINE
              onSlideHeadlineChanged: (String? text) => onSlideHeadlineChanged(
                draftFlyer: widget.draftFlyerNotifier,
                draftSlide: _draftSlideNotifier,
                text: text,
                mounted: mounted,
              ),

              /// ANIMATION
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
              onAnimationEnds: () => onAnimationEnds(
                mounted: mounted,
                isPlayingAnimation: _isPlayingAnimation,
              ),
              onFromTap: () => onFromTap(
                isPlayingAnimation: _isPlayingAnimation,
                isDoingMatrixFrom: _isDoingMatrixFrom,
                mounted: mounted,
                draftSlideNotifier: _draftSlideNotifier,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                matrixNotifier: _matrixNotifier,
              ),
              onToTap: () => onToTap(
                isPlayingAnimation: _isPlayingAnimation,
                isDoingMatrixFrom: _isDoingMatrixFrom,
                mounted: mounted,
                draftSlideNotifier: _draftSlideNotifier,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                matrixNotifier: _matrixNotifier,
              ),
              onPlayTap: () => onPlayTap(
                isPlayingAnimation: _isPlayingAnimation,
                mounted: mounted,
                draftSlideNotifier: _draftSlideNotifier,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                matrixNotifier: _matrixNotifier,
                isDoingMatrixFrom: _isDoingMatrixFrom,
              ),

              /// COLOR
              onBlurBackTap: () => onBlurBackTap(
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                slideBackColor: _slideBackColor,
                draftSlideNotifier: _draftSlideNotifier,
                isPickingBackColor: _isPickingBackColor,
                blurPic: _blurBackPic,
              ),
              onWhiteBackTap: () => onWhiteBackTap(
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                draftSlideNotifier: _draftSlideNotifier,
                isPickingBackColor: _isPickingBackColor,
                slideBackColor: _slideBackColor,
              ),
              onBlackBackTap: () => onBlackBackTap(
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                draftSlideNotifier: _draftSlideNotifier,
                isPickingBackColor: _isPickingBackColor,
                slideBackColor: _slideBackColor,
              ),
              onColorPickerTap: () => onColorPickerTap(
                isPickingBackColor: _isPickingBackColor,
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                draftSlideNotifier: _draftSlideNotifier,
              ),
            ),

            /// MAIN CONTROL PANEL
            SlideEditorMainControlPanel(
              height: _controlPanelHeight,
              draftSlideNotifier: _draftSlideNotifier,
              draftFlyerNotifier: widget.draftFlyerNotifier,
              showAnimationPanel: _showAnimationPanel,
              showColorPanel: _showColorPanel,

              /// NAVIGATION
              onNextSlide: (DraftSlide nextSlide) => onGoNextSlide(
                draftSlideNotifier: _draftSlideNotifier,
                matrixNotifier: _matrixNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                slideBackColor: _slideBackColor,
                isPickingBackColor: _isPickingBackColor,
                nextSlide: nextSlide,
              ),
              onPreviousSlide: (DraftSlide previousSlide) => onGoPreviousSlide(
                draftSlideNotifier: _draftSlideNotifier,
                matrixNotifier: _matrixNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                mounted: mounted,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                slideBackColor: _slideBackColor,
                isPickingBackColor: _isPickingBackColor,
                previousSlide: previousSlide,
              ),
              onFirstSlideBack: () => onExitSlideEditor(
                draftFlyerNotifier: widget.draftFlyerNotifier,
                draftSlideNotifier: _draftSlideNotifier,
                matrixNotifier: _matrixNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                slideBackColor: _slideBackColor,
                isPickingBackColor: _isPickingBackColor,
                mounted: mounted,
              ),
              onLastSlideNext: () => onExitSlideEditor(
                draftFlyerNotifier: widget.draftFlyerNotifier,
                draftSlideNotifier: _draftSlideNotifier,
                matrixNotifier: _matrixNotifier,
                matrixFromNotifier: _matrixFromNotifier,
                slideBackColor: _slideBackColor,
                isPickingBackColor: _isPickingBackColor,
                mounted: mounted,
              ),

              /// ANIMATION
              onTriggerAnimationPanel: () => onTriggerAnimationPanel(
                draftSlideNotifier: _draftSlideNotifier,
                isPlayingAnimation: _isPlayingAnimation,
                mounted: mounted,
                isDoingMatrixFrom: _isDoingMatrixFrom,
                showAnimationPanel: _showAnimationPanel,
                showColorPanel: _showColorPanel,
                isPickingBackColor: _isPickingBackColor,
                slideBackColor: _slideBackColor,
                draftFlyerNotifier: widget.draftFlyerNotifier,
              ),

              /// COLOR
              onTriggerColorPanel: () => onTriggerColorPanel(
                showColorPanel: _showColorPanel,
                showAnimationPanel: _showAnimationPanel,
                mounted: mounted,
                isPickingBackColor: _isPickingBackColor,
                draftFlyerNotifier: widget.draftFlyerNotifier,
                slideBackColor: _slideBackColor,
                draftSlideNotifier: _draftSlideNotifier,
              ),
            ),

          ],

        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
