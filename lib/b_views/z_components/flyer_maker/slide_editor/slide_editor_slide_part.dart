import 'dart:ui';

import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/artworks/blur_layer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/preset_filters.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/b_views/z_components/animators/fade_widget_out.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'dart:math' as math;


class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    @required this.slide,
    @required this.height,
    @required this.transformationController,
    @required this.matrix,
    @required this.onSwipe,
    @required this.filterIndex,
    @required this.blendMode,
    @required this.filterModel,
    @required this.opacity,
    @required this.onSlideTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<MutableSlide> slide;
  final double height;
  final TransformationController transformationController;
  final ValueNotifier<Matrix4> matrix;
  final ValueChanged<int> onSwipe;
  final ValueNotifier<int> filterIndex;
  final ValueNotifier<BlendMode> blendMode;
  final ValueNotifier<ColorFilterModel> filterModel;
  final ValueNotifier<double> opacity;
  final Function onSlideTap;
  /// --------------------------------------------------------------------------
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.75;
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

    final List<Color> _colors = <Color>[
      Colorz.bloodTest,
      Colorz.white10,
      Colorz.black20,
    ];

    final Widget _spacer = FooterButtonSpacer(
        flyerBoxWidth: _flyerBoxWidth,
        tinyMode: false
    );

    return GestureDetector(
      onTap: onSlideTap,
      child: Container(
        width: _screenWidth,
        height: _slideZoneHeight,
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: slide,
          child: Container(),
          builder: (_, MutableSlide _slide, Widget child){

            return FlyerBox(
              key: const ValueKey<String>('flyer_box_slide_editor'),
              flyerBoxWidth: _flyerBoxWidth,
              boxColor: _slide.midColor,
              stackWidgets: <Widget>[

                ValueListenableBuilder(
                    valueListenable: filterModel,
                    builder: (_, ColorFilterModel _filterModel, Widget child){

                      return SuperFilteredImage(
                        filterModel: _filterModel,
                        imageFile: _slide.picFile,
                        width: _flyerBoxWidth,
                        height: _flyerBoxHeight,
                      );
                    }
                    ),

                BlurLayer(
                  key: const ValueKey<String>('blur_layer'),
                  width: _flyerBoxWidth,
                  height: _flyerBoxHeight,
                  blurIsOn: true,
                  blur: 20,
                  borders: FlyerBox.corners(context, _flyerBoxWidth),
                ),

                /// IMAGE
                MatrixGestureDetector(
                  onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){

                    blog(m.storage);

                    matrix.value = m;
                  },
                  shouldRotate: true,
                  shouldScale: true,
                  shouldTranslate: true,
                  clipChild: true,
                  focalPointAlignment: Alignment.center,
                  child: ValueListenableBuilder(
                    valueListenable: matrix,
                    builder: (_, Matrix4 _matrix, Widget childA){

                      blog('rebuilding transforming image');

                      return Transform(
                        transform: _matrix,
                        child: childA,
                      );

                    },

                    child: ValueListenableBuilder(
                      valueListenable: filterModel,
                      builder: (_, ColorFilterModel _filterModel, Widget child){

                        blog('changing filterModel to ${_filterModel.name}');

                        return SuperFilteredImage(
                          filterModel: _filterModel,
                          width: _flyerBoxWidth,
                          height: FlyerBox.height(context, _flyerBoxWidth),
                          imageFile: _slide.picFile,
                          boxFit: _slide.picFit,
                          opacity: opacity,
                        );

                      },
                    ),
                  ),
                ),

                SlideShadow(
                  key: const ValueKey<String>('SingleSlideShadow'),
                  flyerBoxWidth: _flyerBoxWidth,
                ),

                /// FILTER NAME
                ValueListenableBuilder(
                    valueListenable: filterModel,
                    builder: (_, ColorFilterModel _filterModel, Widget child){

                      return FadeWidgetOut(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: FooterBox.collapsedHeight(
                                    context: context,
                                    flyerBoxWidth: _flyerBoxWidth,
                                    tinyMode: false,
                                )
                            ),
                            child: SuperVerse(
                              verse: _filterModel.name,
                              maxLines: 3,
                              weight: VerseWeight.thin,
                              italic: true,
                              size: 4,
                              scaleFactor: _flyerBoxWidth * 0.005,
                            ),
                          ),
                        ),
                      );

                    }
                ),

                /// HEADLINE
                SlideHeadline(
                  flyerBoxWidth: _flyerBoxWidth,
                  verse: _slide.headline.text,
                ),

                /// BOTTOM SHADOW
                FooterShadow(
                  key: const ValueKey<String>('FooterShadow'),
                  flyerBoxWidth: _flyerBoxWidth,
                  tinyMode: false,
                ),

                /// STATIC FOOTER
                Opacity(
                  opacity: 0.5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: _flyerBoxWidth,
                      height: FooterBox.collapsedHeight(
                        context: context,
                        flyerBoxWidth: _flyerBoxWidth,
                        tinyMode: false,
                      ),
                      child: Row(
                        children: <Widget>[

                          /// INFO BUTTON
                          Container(
                            // key: const ValueKey<String>('InfoButtonStarter_animated_container'),
                            width: InfoButtonStarter.getWidth(
                              context: context,
                              flyerBoxWidth: _flyerBoxWidth,
                              tinyMode: false,
                              isExpanded: false,
                              infoButtonType: InfoButtonType.info,
                            ),
                            height: InfoButtonStarter.getHeight(
                              context: context,
                              flyerBoxWidth: _flyerBoxWidth,
                              tinyMode: false,
                              isExpanded: false,
                            ),
                            decoration: BoxDecoration(
                              // color: _color,
                              color: Colorz.black255,
                              borderRadius: InfoButtonStarter.getBorders(
                                  context: context,
                                  flyerBoxWidth: _flyerBoxWidth,
                                  tinyMode: false,
                                  isExpanded: false
                              ),
                            ),
                            margin: InfoButtonStarter.getMargin(
                              context: context,
                              flyerBoxWidth: _flyerBoxWidth,
                              tinyMode: false,
                              isExpanded: false,
                            ),
                            alignment: Alignment.center,
                            child: const SizedBox(),
                          ),

                          const Expander(),

                            _spacer,

                          /// SHARE
                            FooterButton(
                              flyerBoxWidth: _flyerBoxWidth,
                              icon: null, // Iconz.share,
                              verse: '', // superPhrase(context, 'phid_send'),
                              isOn: false,
                              tinyMode: false,
                              onTap: (){},
                            ),

                            _spacer,

                          /// COMMENT
                            FooterButton(
                              flyerBoxWidth: _flyerBoxWidth,
                              icon: null, // Iconz.utPlanning,
                              verse: '', // superPhrase(context, 'phid_comment'),
                              isOn: false,
                              tinyMode: false,
                              onTap: (){},
                            ),

                            _spacer,

                          /// SAVE BUTTON
                          FooterButton(
                            flyerBoxWidth: _flyerBoxWidth,
                            icon: null, // Iconz.save,
                            verse: '', // superPhrase(context, 'phid_save'),
                            isOn: false,
                            tinyMode: false,
                            onTap: (){},
                          ),

                          _spacer,


                        ],
                      ),
                    ),
                  ),
                ),

                /// STATIC HEADER
                Opacity(
                  opacity: 0.5,
                  child: HeaderBox(
                    key: const ValueKey<String>('SlideEditorSlidePart_HeaderBox'),
                    tinyMode: false,
                    onHeaderTap: null,
                    headerBorders: FlyerBox.superHeaderCorners(
                      context: context,
                      flyerBoxWidth: _flyerBoxWidth,
                      bzPageIsOn: false,
                    ),
                    flyerBoxWidth: _flyerBoxWidth,
                    headerColor: Colorz.black255,
                    headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: _flyerBoxWidth),
                    children: const <Widget>[],
                  ),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}

