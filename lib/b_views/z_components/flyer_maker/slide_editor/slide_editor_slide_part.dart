import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
    @required this.isFlipped,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<MutableSlide> slide;
  final double height;
  final TransformationController transformationController;
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<bool> isFlipped;
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
                  valueListenable: matrix,
                  builder: (_, Matrix4 _matrix, Widget childA){

                    return ValueListenableBuilder(
                      valueListenable: isFlipped,
                      builder: (_, bool _isFlipped, Widget childB){

                        final double _flipValue = _isFlipped ? 0 : math.pi;

                        return Transform(
                          transform: _matrix..rotateY(_flipValue),
                          child: childA,
                        );

                      },
                    );


                  },

                  child: SuperImage(
                    width: _flyerBoxWidth,
                    height: FlyerBox.height(context, _flyerBoxWidth),
                    pic: _slide.picFile,
                    fit: _slide.picFit,
                  ),

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
