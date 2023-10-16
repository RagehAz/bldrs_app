
import 'package:basics/animators/widgets/animate_widget_to_matrix.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_headline_text_field.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_transformer.dart';
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
    required this.appBarType,
    required this.globalKey,
    required this.mounted,
    required this.isPlayingAnimation,
    required this.onSlideDoubleTap,
    required this.bzModel,
    required this.authorID,
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
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final bool mounted;
  final BzModel bzModel;
  final String authorID;
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
                return BldrsImage(
                  width: _flyerBoxWidth,
                  height: _flyerBoxHeight,
                  pic: _slide?.backPic?.bytes,
                  // loading: false,
                  // corners: FlyerDim.flyerCorners(_flyerBoxWidth),
                );
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

                      Trinity.blogMatrix(_slide?.matrix);

                      return Stack(
                        children: <Widget>[

                          /// BACKGROUND
                          BldrsImage(
                            width: _flyerBoxWidth,
                            height: _flyerBoxHeight,
                            pic: _slide?.backPic?.bytes,
                            // loading: false,
                            // corners: FlyerDim.flyerCorners(_flyerBoxWidth),
                          ),

                          /// SLIDE ANIMATOR
                          AnimateWidgetToMatrix(
                            matrix: Trinity.renderSlideMatrix(
                              matrix: _slide?.matrix,
                              flyerBoxWidth: _flyerBoxWidth,
                              flyerBoxHeight: _flyerBoxHeight,
                            ),
                            // canAnimate: true,
                            curve: _slide?.animationCurve ?? Curves.easeIn,
                            replayOnRebuild: true,
                            onAnimationEnds: () {
                              setNotifier(
                                  notifier: isPlayingAnimation, mounted: mounted, value: false);
                              },
                            child: SuperFilteredImage(
                              width: _flyerBoxWidth,
                              height: _flyerBoxHeight,
                              pic: _slide?.medPic?.bytes,
                              boxFit: BoxFit.fitWidth,
                              loading: false,
                              // canUseFilter: false,
                            ),
                          ),

                        ],
                      );

                    }

                    /// WHILE TRANSFORMING SLIDE
                    else {
                      return SlideTransformer(
                        matrixNotifier: matrixNotifier,
                        flyerBoxWidth: _flyerBoxWidth,
                        flyerBoxHeight: _flyerBoxHeight,
                        slide: _slide,
                        isTransforming: isTransforming,
                        mounted: mounted,
                      );
                    }

                    },
                );

                },
            ),

            /// SLIDE SHADOW
            SlideShadow(
              flyerBoxWidth: _flyerBoxWidth,
            ),

            ///  PLAN : SLIDE COLOR FILTER FEATURE
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

            /// FOOTER
            Disabler(
              isDisabled: true,
              disabledOpacity: 0.2,
              child: StaticFooter(
                flyerBoxWidth: _flyerBoxWidth,
                flyerID: 'x',
                optionsButtonIsOn: false,
                showAllButtons: true,
              ),
            ),

            /// HEADER
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

          ],

        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
