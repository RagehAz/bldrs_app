import 'package:basics/animators/widgets/animate_widget_to_matrix.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_color_panel.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/template_flyer/d_footer_template.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_animator_panel.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_editor_headline_text_field.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_transformer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
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
        child: FlyerBox(
          key: const ValueKey<String>('flyer_box_slide_editor'),
          flyerBoxWidth: _flyerBoxWidth,
          boxColor: draftSlide.value?.midColor,
          stackWidgets: <Widget>[

            /// BACKGROUND
            ValueListenableBuilder(
              valueListenable: draftSlide,
              builder: (_, DraftSlide? _slide, Widget? child) {

                /// BLUR BACK
                if (_slide?.backColor == null){
                  return BldrsImage(
                    width: _flyerBoxWidth,
                    height: _flyerBoxHeight,
                    pic: _slide?.backPic?.bytes,
                    // loading: false,
                    // corners: FlyerDim.flyerCorners(_flyerBoxWidth),
                  );
                }

                /// COLOR BACK
                else {
                  return Container(
                    width: _flyerBoxWidth,
                    height: _flyerBoxHeight,
                    color: _slide!.backColor,
                  );
                }

              }
            ),

            /// SLIDE
            ValueListenableBuilder(
              valueListenable: draftSlide,
              builder: (_, DraftSlide? _slide, Widget? child) {

                return ValueListenableBuilder(
                  valueListenable: isPlayingAnimation,
                  builder: (_, bool isPlaying, Widget? animationPlayer) {

                    /// WHILE PLAYING ANIMATION
                    if (isPlaying == true) {
                      return animationPlayer!;
                    }

                    /// WHILE TRANSFORMING SLIDE
                    else {
                      return ValueListenableBuilder(
                          valueListenable: isDoingMatrixFrom,
                          builder: (_, bool isMatrixFrom, Widget? child){

                              return SlideTransformer(
                                matrixFromNotifier: matrixFromNotifier,
                                matrixNotifier: matrixNotifier,
                                flyerBoxWidth: _flyerBoxWidth,
                                flyerBoxHeight: _flyerBoxHeight,
                                slide: _slide,
                                isTransforming: isTransforming,
                                mounted: mounted,
                                isMatrixFrom: isMatrixFrom,
                              );

                          }
                      );
                    }

                    },
                  /// SLIDE ANIMATOR
                  child: AnimateWidgetToMatrix(
                    matrix: Trinity.renderSlideMatrix(
                      matrix: _slide?.matrix,
                      flyerBoxWidth: _flyerBoxWidth,
                      flyerBoxHeight: _flyerBoxHeight,
                    ),
                    matrixFrom: Trinity.renderSlideMatrix(
                      matrix: _slide?.matrixFrom,
                      flyerBoxWidth: _flyerBoxWidth,
                      flyerBoxHeight: _flyerBoxHeight,
                    ),
                    // canAnimate: true,
                    curve: _slide?.animationCurve ?? Curves.easeIn,
                    replayOnRebuild: true,
                    repeat: false,
                    onAnimationEnds: () async {
                      await Future<void>.delayed(const Duration(milliseconds: 300));
                      setNotifier(
                        notifier: isPlayingAnimation,
                        mounted: mounted,
                        value: false,
                      );
                      },
                    child: Image.memory(
                      _slide!.medPic!.bytes!,
                      key: const ValueKey<String>('SuperImage_slide_draft'),
                      width: _flyerBoxWidth,
                      height: _flyerBoxHeight,
                    ),
                  ),
                );

                },
            ),

            /// SLIDE SHADOW
            SlideShadow(
              flyerBoxWidth: _flyerBoxWidth,
            ),

            ///  DEPRECATED : SLIDE COLOR FILTER FEATURE
            // / FILTER NAME
            // IgnorePointer(
            //   child: ImageFilterAnimatedName(
            //     flyerBoxWidth: _flyerBoxWidth,
            //     filterModel: filterModel,
            //   ),
            // ),

            /// HEADLINE TEXT FIELD
            EditorSlideHeadlineTextField(
              isTransforming: isTransforming,
              appBarType: appBarType,
              globalKey: globalKey,
              draftSlide: draftSlide,
              draftFlyer: draftFlyer,
              flyerBoxWidth: _flyerBoxWidth,
              mounted: mounted,
            ),

            /// BOTTOM SHADOW
            FooterShadow(
              flyerBoxWidth: _flyerBoxWidth,
            ),

            /// TOP BUTTON FOOTPRINT
            SuperPositioned(
              enAlignment: Alignment.bottomLeft,
              verticalOffset: FlyerDim.footerBoxHeight(
                flyerBoxWidth: _flyerBoxWidth,
                infoButtonExpanded: false,
                showTopButton: false,
              ),
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              child: Disabler(
                isDisabled: true,
                child: TopButtonLabelStructure(
                  flyerBoxWidth: _flyerBoxWidth,
                  width: FlyerDim.gtaButtonWidth(flyerBoxWidth: _flyerBoxWidth),
                  color: Colorz.black50,
                  child: const SizedBox(),
                ),
              ),
            ),

            /// FOOTER FOOTPRINT
            ValueListenableBuilder(
              valueListenable: draftSlide,
              builder: (_, DraftSlide? _slide, Widget? child) {

                /// NO ANIMATION
                if (_slide?.animationCurve == null){
                  return child!;
                }

                /// HAS ANIMATION
                else {
                  return const SizedBox();
                }

              },
              child:  Disabler(
                  isDisabled: true,
                  child: FooterTemplate(
                    flyerBoxWidth: _flyerBoxWidth,
                    buttonColor: Colorz.black50,
                  ),
                ),
            ),

            /// HEADER FOOTPRINT
            Disabler(
              isDisabled: true,
              disabledOpacity: 0.2,
              child: StaticHeader(
                flyerBoxWidth: _flyerBoxWidth,
                bzModel: bzModel,
                authorID: authorID,
                flyerShowsAuthor: true,
                showHeaderLabels: true,
              ),
            ),

            /// ANIMATION PANEL
            ValueListenableBuilder(
              valueListenable: showAnimationPanel,
              builder: (_, bool showPanel, Widget? child) {

                /// NO ANIMATION
                if (showPanel == true){
                  return child!;
                }

                /// HAS ANIMATION
                else {
                  return const SizedBox();
                }

              },
              child: SlideAnimatorPanel(
                flyerBoxWidth: _flyerBoxWidth,
                isDoingMatrixFrom: isDoingMatrixFrom,
                isPlayingAnimation: isPlayingAnimation,
                mounted: mounted,
                matrixFromNotifier: matrixFromNotifier,
                matrixNotifier: matrixNotifier,
                draftSlideNotifier: draftSlide,
                draftFlyerNotifier: draftFlyer,
                onResetMatrix: onResetMatrix,
                canResetMatrix: canResetMatrix,
                onTriggerSlideIsAnimated: onTriggerSlideIsAnimated,
              ),
            ),

            /// COLOR PANEL
            ValueListenableBuilder(
              valueListenable: showColorPanel,
              builder: (_, bool showPanel, Widget? child) {

                /// NO ANIMATION
                if (showPanel == true){
                  return child!;
                }

                /// HAS ANIMATION
                else {
                  return const SizedBox();
                }

                },
              child: SlideColorPanel(
                flyerBoxWidth: _flyerBoxWidth,
                mounted: mounted,
                matrixFromNotifier: matrixFromNotifier,
                matrixNotifier: matrixNotifier,
                draftSlideNotifier: draftSlide,
                onResetMatrix: onResetMatrix,
                canResetMatrix: canResetMatrix,
                onTriggerSlideIsAnimated: onTriggerSlideIsAnimated,
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
