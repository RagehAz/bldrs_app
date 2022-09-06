import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class SlideTransformer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideTransformer({
    @required this.matrix,
    @required this.filterModel,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.slide,
    @required this.isTransforming,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<Matrix4> matrix; /// p
  final ValueNotifier<ImageFilterModel> filterModel; /// p
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final MutableSlide slide;
  final ValueNotifier<bool> isTransforming;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('SlideTransformer : BUILDING : slide : ${slide.picFileModel.file.path}');

    return MatrixGestureDetector(
      key: const ValueKey<String>('SlideTransformer'),
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){

        // blog('matrix is : $m');

        final bool _areTheSame = Trinity.checkMatrixesAreIdentical(
          matrix1: matrix.value,
          matrixReloaded: m,
        );

        if (_areTheSame == false){

          matrix.value = Trinity.generateSlideMatrix(
              matrix: m,
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight
          );

          isTransforming.value = true;
        }

      },

      // shouldRotate: true,
      // shouldScale: true,
      // shouldTranslate: true,
      // focalPointAlignment: Alignment.center,
      clipChild: false,
      child: ValueListenableBuilder(
        valueListenable: matrix,
        builder: (_, Matrix4 _matrix, Widget childA){

          // blog('rebuilding transforming image');

          return Transform(
            transform: Trinity.renderSlideMatrix(
              matrix: _matrix,
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight,
            ),
            // alignment: Alignment.center,
            // origin: Offset(0,0),
            filterQuality: FilterQuality.high,
            transformHitTests: false,
            child: childA,
          );

        },

        child: ValueListenableBuilder(
          valueListenable: filterModel,
          builder: (_, ImageFilterModel _filterModel, Widget child){

            // blog('changing filterModel to ${_filterModel.id}');

            return SuperFilteredImage(
              width: flyerBoxWidth,
              height: FlyerBox.height(context, flyerBoxWidth),
              imageFile: slide.picFileModel.file,
              filterModel: _filterModel,
              boxFit: slide.picFit,
            );

          },
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
