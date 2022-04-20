import 'dart:ui';

import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/preset_filters.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_builder.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
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


    return Container(
      width: _screenWidth,
      height: _slideZoneHeight,
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: slide,
        child: Container(),
        builder: (_, MutableSlide _slide, Widget child){

          return FlyerBox(
            flyerBoxWidth: _flyerBoxWidth,
            boxColor: _slide.midColor,
            stackWidgets: <Widget>[

              /// IMAGE
              MatrixGestureDetector(
                onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){
                  matrix.value = m;
                },
                shouldRotate: true,
                shouldScale: true,
                shouldTranslate: true,
                clipChild: true,
                focalPointAlignment: Alignment.center,
                child: ValueListenableBuilder(
                  valueListenable: blendMode,
                  builder: (_, BlendMode mode, Widget child){

                    blog('blend mode is : $mode');

                    return Stack(
                      children: <Widget>[

                        ValueListenableBuilder(
                          valueListenable: matrix,
                          builder: (_, Matrix4 _matrix, Widget childA){

                            blog('rebuilding tranforming image');

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
                              );

                            },
                          ),
                        ),

                        // SizedBox(
                        //   width: _flyerBoxWidth,
                        //   height: _flyerBoxHeight,
                        //   child: PageView.builder(
                        //       itemCount: _colors.length,
                        //       onPageChanged: onSwipe,
                        //       itemBuilder: (_, index){
                        //
                        //         return Container(
                        //           width: _flyerBoxWidth,
                        //           height: _flyerBoxHeight,
                        //           decoration: BoxDecoration(
                        //               // color: Colorz.white10,
                        //
                        //               borderRadius: FlyerBox.corners(context, _flyerBoxWidth)
                        //           ),
                        //         );
                        //
                        //       }
                        //   ),
                        // ),


                        ValueListenableBuilder(
                            valueListenable: filterIndex,
                            builder: (_, int index, Widget child){

                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: SuperVerse(
                                  verse: 'filter ${_colors[index]}\n${mode.toString()}',
                                  maxLines: 3,
                                ),
                              );

                            }
                        ),



                      ],
                    );

                  },
                ),
              ),


              /// HEADLINE
              SlideHeadline(
                flyerBoxWidth: _flyerBoxWidth,
                verse: _slide.headline.text,
              ),

            ],
          );

        },
      ),
    );
  }
}
