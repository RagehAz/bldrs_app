import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/image_filter_animated_name.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_back_cover_image.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_transformer.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/static_footer.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/static_header.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    @required this.tempSlide,
    @required this.height,
    @required this.onSlideTap,
    @required this.isTransforming,
    @required this.matrix,
    @required this.filterModel,
    @required this.appBarType,
    @required this.globalKey,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<MutableSlide> tempSlide;
  final double height;
  final Function onSlideTap;
  final ValueNotifier<bool> isTransforming;
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<ImageFilterModel> filterModel;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  // --------------------
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.85;
    return _slideZoneHeight;
  }
  // --------------------
  static double getFlyerZoneWidth(BuildContext context, double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerBox.widthByHeight(context, _flyerBoxHeight);
    return _flyerBoxWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(context, _slideZoneHeight);
    final double _flyerBoxHeight = FlyerBox.height(context, _flyerBoxWidth);
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('SlideEditorSlidePart'),
      onTap: onSlideTap,
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: tempSlide,
          child: Container(),
          builder: (_, MutableSlide _slide, Widget child){

            blog('BUILDING SLIDE AHOOOO : ${_slide.picFileModel.file.path} : color : ${_slide.midColor}');

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
                  borders: FlyerBox.corners(context, _flyerBoxWidth),
                ),

                /// SLIDE
                SlideTransformer(
                  matrix: matrix,
                  filterModel: filterModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slide: _slide,
                  isTransforming: isTransforming,
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

                /// TASK : GROUP THIS IN STATELESS WIDGET
                /// HEADLINE TEXT FIELD
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
                                  titleVerse: '##Flyer Slide Headline',
                                  // key: ValueKey<String>('slide$slideIndex'),
                                  hintVerse: '##T i t l e',
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
                                    tempSlide: tempSlide,
                                    text: text,
                                  ),
                                  textWeight: VerseWeight.bold,
                                  textShadow: true,
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
                IgnorePointer(
                  child: FooterShadow(
                    flyerBoxWidth: _flyerBoxWidth,
                    tinyMode: false,
                  ),
                ),

                /// STATIC FOOTER
                IgnorePointer(
                  child: StaticFooter(
                    flyerBoxWidth: _flyerBoxWidth,
                  ),
                ),

                /// STATIC HEADER
                IgnorePointer(
                  child: StaticHeader(
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
