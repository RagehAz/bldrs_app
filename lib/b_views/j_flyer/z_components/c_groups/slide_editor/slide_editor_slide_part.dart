import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/image_filter_animated_name.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_back_cover_image.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_transformer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_header_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_footer_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide> draftSlide;
  final double height;
  final Function onSlideTap;
  final ValueNotifier<bool> isTransforming;
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<ImageFilterModel> filterModel;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final bool mounted;
  // --------------------
  ///
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.85;
    return _slideZoneHeight;
  }
  // --------------------
  ///
  static double getFlyerZoneWidth(BuildContext context, double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerDim.flyerWidthByFlyerHeight(_flyerBoxHeight);
    return _flyerBoxWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(context, _slideZoneHeight);
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth);
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('SlideEditorSlidePart'),
      onTap: onSlideTap,
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: draftSlide,
          child: Container(),
          builder: (_, DraftSlide _slide, Widget child){

            blog('BUILDING SLIDE AHOOOO : ${_slide.picModel.bytes.length} bytes : color : ${_slide.midColor}');

            return FlyerBox(
              key: const ValueKey<String>('flyer_box_slide_editor'),
              flyerBoxWidth: _flyerBoxWidth,
              boxColor: _slide.midColor,
              stackWidgets: <Widget>[

                /// BACK GROUND COVER SLIDE
                SlideBackCoverImage(
                  filterModel: filterModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slide: _slide,
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
                SlideTransformer(
                  matrix: matrix,
                  filterModel: filterModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slide: _slide,
                  isTransforming: isTransforming,
                  mounted: mounted,
                ),

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

                /// HEADLINE TEXT FIELD : TASK : GROUP THIS IN STATELESS WIDGET
                ValueListenableBuilder(
                    valueListenable: isTransforming,
                    builder: (_, bool transforming, Widget child){

                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                        opacity: transforming == true ? 0.4 : 1,
                        child: IgnorePointer(
                          ignoring: transforming,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: _flyerBoxWidth,
                                margin: EdgeInsets.only(
                                    top: _flyerBoxWidth * 0.3,
                                    left: 5,
                                    right: 5
                                ),
                                alignment: Alignment.topCenter,
                                child: SuperTextField(
                                  appBarType: appBarType,
                                  globalKey: globalKey,
                                  titleVerse: const Verse(
                                    text: 'phid_flyer_slide_headline',
                                    translate: true,
                                  ),
                                  // key: ValueKey<String>('slide$slideIndex'),
                                  hintVerse: const Verse(
                                    text: 'phid_t_i_t_l_e',
                                    translate: true,
                                    pseudo: 'T i t l e',
                                  ),
                                  width: _flyerBoxWidth,
                                  // height: flyerBoxWidth * 0.15,
                                  fieldColor: Colorz.black80,
                                  maxLines: 4,
                                  maxLength: 55,
                                  // counterIsOn: true,
                                  textSize: SlideHeadline.headlineSize,
                                  textSizeFactor: _flyerBoxWidth * SlideHeadline.headlineScaleFactor,
                                  centered: true,
                                  // autoValidate: true,
                                  onChanged: (String text) => onSlideHeadlineChanged(
                                    draftSlide: draftSlide,
                                    text: text,
                                    mounted: mounted,
                                  ),
                                  textWeight: VerseWeight.bold,
                                  textShadow: true,
                                  initialValue: draftSlide.value.headline,
                                  // autofocus: false,
                                  // fieldIsFormField: true,
                                  // onSubmitted: null,
                                  // keyboardTextInputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    }
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
            );
          },
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
