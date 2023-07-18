import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:basics/super_image/super_image.dart';

class SlideTransformer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideTransformer({
    required this.matrixNotifier,
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slide,
    required this.isTransforming,
    required this.mounted,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<Matrix4?> matrixNotifier;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final DraftSlide? slide;
  final ValueNotifier<bool> isTransforming;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('SlideTransformer : BUILDING : slide : ${slide.picModel.bytes.length} bytes');

    return MatrixGestureDetector(
      key: const ValueKey<String>('SlideTransformer'),
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){

        // blog('matrix is : $m');

        final bool _areTheSame = Trinity.checkMatrixesAreIdentical(
          matrix1: matrixNotifier.value,
          matrixReloaded: m,
        );

        if (_areTheSame == false){

          setNotifier(
              notifier: matrixNotifier,
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
        valueListenable: matrixNotifier,
        builder: (_, Matrix4? _matrix, Widget? childA){

          // blog('rebuilding transforming image');

          return Transform(
            transform: Trinity.renderSlideMatrix(
              matrix: _matrix,
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight,
            )!,
            // alignment: Alignment.center,
            // origin: Offset(0,0),
            filterQuality: FilterQuality.low,
            transformHitTests: false,
            child: childA,
          );

        },

        child: SuperFilteredImage(
          width: flyerBoxWidth,
          height: FlyerDim.flyerHeightByFlyerWidth(
            flyerBoxWidth: flyerBoxWidth,
          ),
          pic: slide?.picModel?.bytes,
          boxFit: slide?.picFit ?? BoxFit.cover,
          loading: false,
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
