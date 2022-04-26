import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/artworks/blur_layer.dart';
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
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    @required this.slide,
    @required this.height,
    @required this.matrix,
    @required this.filterModel,
    @required this.onSlideTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<MutableSlide> slide;
  final double height;
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<ImageFilterModel> filterModel;
  final Function onSlideTap;
  /// --------------------------------------------------------------------------
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.85;
    return _slideZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double getFlyerZoneWidth(BuildContext context, double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerBox.widthByHeight(context, _flyerBoxHeight);
    return _flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(context, _slideZoneHeight);
    final double _flyerBoxHeight = FlyerBox.height(context, _flyerBoxWidth);

    return GestureDetector(
      key: const ValueKey<String>('SlideEditorSlidePart'),
      onTap: onSlideTap,
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: slide,
          child: Container(),
          builder: (_, MutableSlide _slide, Widget child){

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
                    slide: _slide
                ),

                /// SLIDE SHADOW
                SlideShadow(
                  flyerBoxWidth: _flyerBoxWidth,
                ),

                /// FILTER NAME
                ImageFilterAnimatedName(
                  flyerBoxWidth: _flyerBoxWidth,
                  filterModel: filterModel,
                ),

                // /// HEADLINE
                // SlideHeadline(
                //   flyerBoxWidth: _flyerBoxWidth,
                //   verse: _slide.headline.text,
                // ),

                SuperTextField(
                  // key: ValueKey<String>('slide$slideIndex'),
                  hintText: 'T i t l e',
                  width: _flyerBoxWidth,
                  // height: flyerBoxWidth * 0.15,
                  fieldColor: Colorz.black80,
                  margin: EdgeInsets.only(
                      top: _flyerBoxWidth * 0.3,
                      left: 5,
                      right: 5
                  ),
                  maxLines: 4,
                  maxLength: 55,
                  // counterIsOn: true,
                  inputSize: SlideHeadline.headlineSize,
                  textSizeFactor: _flyerBoxWidth * SlideHeadline.headlineScaleFactor,
                  centered: true,
                  textController: _slide.headline,
                  onChanged: (String val){},
                  inputWeight: VerseWeight.bold,
                  inputShadow: true,
                  // autofocus: false,
                  // fieldIsFormField: true,
                  // onSubmitted: null,
                  keyboardTextInputAction: TextInputAction.done,
                ),


                /// BOTTOM SHADOW
                FooterShadow(
                  flyerBoxWidth: _flyerBoxWidth,
                  tinyMode: false,
                ),

                /// STATIC FOOTER
                StaticFooter(
                  flyerBoxWidth: _flyerBoxWidth,
                ),

                /// STATIC HEADER
                StaticHeader(
                  flyerBoxWidth: _flyerBoxWidth,
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
