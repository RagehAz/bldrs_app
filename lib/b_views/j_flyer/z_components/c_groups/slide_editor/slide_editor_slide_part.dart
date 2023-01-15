import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/a_slide_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/template_flyer/b_header_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/template_flyer/d_footer_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/image_filter_animated_name.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_back_cover_image.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_headline_text_field.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_transformer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    @required this.draftSlide,
    @required this.height,
    @required this.onSlideTap,
    @required this.isTransforming,
    @required this.matrix,
    @required this.filterModel,
    @required this.appBarType,
    @required this.globalKey,
    @required this.mounted,
    @required this.isPlayingAnimation,
    @required this.onSlideDoubleTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide> draftSlide;
  final double height;
  final Function onSlideTap;
  final Function onSlideDoubleTap;
  final ValueNotifier<bool> isPlayingAnimation;
  final ValueNotifier<bool> isTransforming;
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<ImageFilterModel> filterModel;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final bool mounted;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.85;
    return _slideZoneHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFlyerZoneWidth(BuildContext context, double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: _flyerBoxHeight,
      forceMaxHeight: false,
    );
    return _flyerBoxWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(context, _slideZoneHeight);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth:_flyerBoxWidth,
      forceMaxHeight: false,
    );
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('SlideEditorSlidePart'),
      onTap: onSlideTap,
      onDoubleTap: onSlideDoubleTap,
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.topCenter,
        child: FlyerBox(
          key: const ValueKey<String>('flyer_box_slide_editor'),
          flyerBoxWidth: _flyerBoxWidth,
          boxColor: draftSlide.value.midColor,
          stackWidgets: <Widget>[

            /// BACK GROUND COVER SLIDE
            ValueListenableBuilder(
              valueListenable: draftSlide,
              builder: (_, DraftSlide _slide, Widget child) {
                return SlideBackCoverImage(
                  filterModel: filterModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slide: _slide,
                );
              },
            ),

            /// BLUR LAYER
            BlurLayer(
              width: _flyerBoxWidth,
              height: _flyerBoxHeight,
              blurIsOn: true,
              blur: 20,
              borders: FlyerDim.flyerCorners(context, _flyerBoxWidth),
            ),

            /// SLIDE
            ValueListenableBuilder(
              valueListenable: draftSlide,
              builder: (_, DraftSlide _slide, Widget child) {
                return SlideTransformer(
                  matrix: matrix,
                  filterModel: filterModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slide: _slide,
                  isTransforming: isTransforming,
                  mounted: mounted,
                );
              },
            ),

            /// SLIDE ANIMATION PREVIEW
            ValueListenableBuilder(
                valueListenable: isPlayingAnimation,
                builder: (_, bool isPlaying, Widget child) {
                  if (isPlaying == true) {
                    return ValueListenableBuilder(
                      valueListenable: draftSlide,
                      builder: (_, DraftSlide draft, Widget child) {
                        Trinity.blogMatrix(draft?.matrix);

                        return SlideBox(
                          flyerBoxWidth: _flyerBoxWidth,
                          flyerBoxHeight: _flyerBoxHeight,
                          slideMidColor: Colorz.nothing,
                          shadowIsOn: false,
                          tinyMode: false,
                          stackChildren: [
                            /// BLUR LAYER
                            // BlurLayer(
                            //   width: _flyerBoxWidth,
                            //   height: _flyerBoxHeight,
                            //   blurIsOn: true,
                            //   blur: 40,
                            //   borders: FlyerDim.flyerCorners(context, _flyerBoxWidth),
                            // ),

                            AnimateWidgetToMatrix(
                              matrix: Trinity.renderSlideMatrix(
                                matrix: draft?.matrix,
                                flyerBoxWidth: _flyerBoxWidth,
                                flyerBoxHeight: _flyerBoxHeight,
                              ),
                              canAnimate: true,
                              curve: draft.animationCurve,
                              replayOnRebuild: true,
                              onAnimationEnds: () {
                                setNotifier(
                                    notifier: isPlayingAnimation, mounted: mounted, value: false);
                              },
                              child: SuperFilteredImage(
                                width: _flyerBoxWidth,
                                height: _flyerBoxHeight,
                                pic: draft?.picModel?.bytes,
                                filterModel: ImageFilterModel.getFilterByID(draft?.filter?.id),
                                boxFit: draft?.picFit,
                                canUseFilter: true,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),

            /// SLIDE SHADOW
            IgnorePointer(
              child: SlideShadow(
                flyerBoxWidth: _flyerBoxWidth,
              ),
            ),

            /// FILTER NAME
            IgnorePointer(
              child: ImageFilterAnimatedName(
                flyerBoxWidth: _flyerBoxWidth,
                filterModel: filterModel,
              ),
            ),

            /// HEADLINE TEXT FIELD
            EditorSlideHeadlineTextField(
              isTransforming: isTransforming,
              appBarType: appBarType,
              globalKey: globalKey,
              draftSlide: draftSlide,
              flyerBoxWidth: _flyerBoxWidth,
              mounted: mounted,
            ),

            /// BOTTOM SHADOW
            FooterShadow(
              flyerBoxWidth: _flyerBoxWidth,
            ),

            /// STATIC FOOTER
            IgnorePointer(
              child: FooterTemplate(
                flyerBoxWidth: _flyerBoxWidth,
              ),
            ),

            /// STATIC HEADER
            IgnorePointer(
              child: HeaderTemplate(
                flyerBoxWidth: _flyerBoxWidth,
                opacity: 0.5,
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
