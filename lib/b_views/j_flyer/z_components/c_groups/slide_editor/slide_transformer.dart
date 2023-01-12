import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    @required this.mounted,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<Matrix4> matrix;
  final ValueNotifier<ImageFilterModel> filterModel;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final DraftSlide slide;
  final ValueNotifier<bool> isTransforming;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('SlideTransformer : BUILDING : slide : ${slide.picModel.bytes.length} bytes');

    return MatrixGestureDetector(
      key: const ValueKey<String>('SlideTransformer'),
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){

        // blog('matrix is : $m');

        final bool _areTheSame = Trinity.checkMatrixesAreIdentical(
          matrix1: matrix.value,
          matrixReloaded: m,
        );

        if (_areTheSame == false){

          setNotifier(
              notifier: matrix,
              mounted: mounted,
              value: Trinity.generateSlideMatrix(
                  matrix: m,
                  flyerBoxWidth: flyerBoxWidth,
                  flyerBoxHeight: flyerBoxHeight
              ),
          );

          setNotifier(
              notifier: isTransforming,
              mounted: mounted,
              value: true,
          );

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
              height: FlyerDim.flyerHeightByFlyerWidth(
                flyerBoxWidth: flyerBoxWidth,
                forceMaxHeight: false,
              ),
              pic: slide.picModel.bytes,
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
