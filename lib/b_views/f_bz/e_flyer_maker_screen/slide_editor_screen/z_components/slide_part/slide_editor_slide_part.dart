import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/animation_progress_bar.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_animator_panel.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_color_panel.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/footprints/footer_footprint.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/footprints/header_footprint.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/footprints/top_button_footprint.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_editor_headline_text_field.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    required this.draftSlide,
    required this.draftFlyer,
    required this.height,
    required this.onSlideTap,
    required this.isTransforming,
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.isDoingMatrixFrom,
    required this.appBarType,
    required this.globalKey,
    required this.mounted,
    required this.isPlayingAnimation,
    required this.onSlideDoubleTap,
    required this.bzModel,
    required this.authorID,
    required this.isPickingBackColor,
    required this.onTriggerSlideIsAnimated,
    required this.onResetMatrix,
    required this.canResetMatrix,
    required this.showColorPanel,
    required this.showAnimationPanel,
    required this.onAnimationEnds,
    required this.onFromTap,
    required this.onToTap,
    required this.onPlayTap,
    required this.onSlideHeadlineChanged,
    required this.onColorPickerTap,
    required this.onWhiteBackTap,
    required this.onBlackBackTap,
    required this.onBlurBackTap,
    required this.slideBackColor,
    required this.loadingColorPicker,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide?> draftSlide;
  final ValueNotifier<DraftFlyer?> draftFlyer;
  final double height;
  final Function? onSlideTap;
  final Function? onSlideDoubleTap;
  final ValueNotifier<bool> isPlayingAnimation;
  final ValueNotifier<bool> isTransforming;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final ValueNotifier<bool> isDoingMatrixFrom;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final bool mounted;
  final BzModel bzModel;
  final String authorID;
  final ValueNotifier<bool> isPickingBackColor;
  final Function onTriggerSlideIsAnimated;
  final Function onResetMatrix;
  final ValueNotifier<bool> canResetMatrix;
  final ValueNotifier<bool> showAnimationPanel;
  final ValueNotifier<bool> showColorPanel;
  final Function onAnimationEnds;
  final Function onFromTap;
  final Function onToTap;
  final Function onPlayTap;
  final Function(String? text) onSlideHeadlineChanged;
  final Function onColorPickerTap;
  final Function onWhiteBackTap;
  final Function onBlackBackTap;
  final Function onBlurBackTap;
  final ValueNotifier<Color?> slideBackColor;
  final ValueNotifier<bool> loadingColorPicker;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.85;
    return _slideZoneHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFlyerZoneWidth(double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: _flyerBoxHeight,
    );
    return _flyerBoxWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(_slideZoneHeight);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth:_flyerBoxWidth,
    );
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('SlideEditorSlidePart'),
      onTap: () => onSlideTap?.call(),
      onDoubleTap: () => onSlideDoubleTap?.call(),
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
            valueListenable: draftSlide,
            builder: (_, DraftSlide? _slide, Widget? child) {

              return FlyerBox(
                  key: const ValueKey<String>('flyer_box_slide_editor'),
                  flyerBoxWidth: _flyerBoxWidth,
                  boxColor: draftSlide.value?.midColor,
                  borderColor: Colorz.white20,
                  stackWidgets: <Widget>[

                    /// BLUR BACKGROUND
                    if (_slide?.backColor == null)
                      BldrsImage(
                        width: _flyerBoxWidth,
                        height: _flyerBoxHeight,
                        pic: _slide?.backPic?.bytes,
                        // loading: false,
                        // corners: FlyerDim.flyerCorners(_flyerBoxWidth),
                      ),

                    /// COLOR BACKGROUND
                    ValueListenableBuilder(
                        valueListenable: slideBackColor,
                        builder: (_, Color? color, Widget? child) {
                          return Container(
                            width: _flyerBoxWidth,
                            height: _flyerBoxHeight,
                            color: color,
                          );
                        }),

                    /// SLIDE
                    SlideTree(
                      mounted: mounted,
                      flyerBoxWidth: _flyerBoxWidth,
                      flyerBoxHeight: _flyerBoxHeight,
                      slide: _slide,
                      isTransforming: isTransforming,
                      matrixFromNotifier: matrixFromNotifier,
                      matrixNotifier: matrixNotifier,
                      isDoingMatrixFrom: isDoingMatrixFrom,
                      isPlayingAnimation: isPlayingAnimation,
                      onAnimationEnds: onAnimationEnds,
                      isPickingColor: isPickingBackColor,
                    ),

                    /// SLIDE SHADOW
                    SlideShadow(
                      flyerBoxWidth: _flyerBoxWidth,
                    ),

                    /// HEADLINE TEXT FIELD
                    EditorSlideHeadlineTextField(
                      isTransforming: isTransforming,
                      appBarType: appBarType,
                      globalKey: globalKey,
                      draftSlide: draftSlide,
                      flyerBoxWidth: _flyerBoxWidth,
                      onSlideHeadlineChanged: onSlideHeadlineChanged,
                    ),

                    /// BOTTOM SHADOW
                    FooterShadow(
                      flyerBoxWidth: _flyerBoxWidth,
                    ),

                    /// TOP BUTTON FOOTPRINT
                    TopButtonFootprint(
                      flyerBoxWidth: _flyerBoxWidth,
                    ),

                    /// FOOTER FOOTPRINT
                    FooterFootprint(
                      flyerBoxWidth: _flyerBoxWidth,
                      showAnimationPanel: showAnimationPanel,
                      showColorPanel: showColorPanel,
                    ),

                    /// HEADER FOOTPRINT
                    HeaderFootprint(
                      flyerBoxWidth: _flyerBoxWidth,
                      bzModel: bzModel,
                      authorID: authorID,
                    ),

                    /// ANIMATION PANEL
                    SlideAnimatorPanel(
                      flyerBoxWidth: _flyerBoxWidth,
                      isDoingMatrixFrom: isDoingMatrixFrom,
                      isPlayingAnimation: isPlayingAnimation,
                      matrixFromNotifier: matrixFromNotifier,
                      matrixNotifier: matrixNotifier,
                      draftSlideNotifier: draftSlide,
                      onResetMatrix: onResetMatrix,
                      canResetMatrix: canResetMatrix,
                      onTriggerSlideIsAnimated: onTriggerSlideIsAnimated,
                      onFromTap: onFromTap,
                      onToTap: onToTap,
                      onPlayTap: onPlayTap,
                      showAnimationPanel: showAnimationPanel,
                    ),

                    /// ANIMATION PROGRESS BAR
                    SlideAnimationProgressBar(
                      flyerBoxWidth: _flyerBoxWidth,
                      isPlayingAnimation: isPlayingAnimation,
                      draftSlide: _slide,
                    ),

                    /// COLOR PANEL
                    SlideColorPanel(
                      flyerBoxWidth: _flyerBoxWidth,
                      draftSlideNotifier: draftSlide,
                      onBlackBackTap: onBlackBackTap,
                      onWhiteBackTap: onWhiteBackTap,
                      onColorPickerTap: onColorPickerTap,
                      onBlurBackTap: onBlurBackTap,
                      isPickingBackColor: isPickingBackColor,
                      showColorPanel: showColorPanel,
                      slideBackColor: slideBackColor,
                      loadingColorPicker: loadingColorPicker,
                    ),

                  ],
                );
            }
            ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
