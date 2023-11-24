import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/neo.dart';
import 'package:flutter/material.dart';

class SlideTransformer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideTransformer({
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slide,
    required this.isTransforming,
    required this.mounted,
    required this.isMatrixFrom,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final DraftSlide? slide;
  final ValueNotifier<bool> isTransforming;
  final bool mounted;
  final bool isMatrixFrom;
  /// --------------------------------------------------------------------------
  static Matrix4 getInitialMatrix({
    required DraftSlide slide,
    required bool isMatrixFrom,
    required double flyerBoxWidth,
    required double flyerBoxHeight,
  }){
    Matrix4? _output;

    if (isMatrixFrom == true){
      // Trinity.blogMatrix(matrix: slide.matrixFrom, roundDigits: 5, invoker: 'FROM : BEFORE',);
      _output = Trinity.renderSlideMatrix(
        matrix: slide.matrixFrom,
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: flyerBoxHeight,
      )!;
      // Trinity.blogMatrix(matrix: _output, roundDigits: 5, invoker: 'FROM : AFTER',);

    }
    else {
      // Trinity.blogMatrix(matrix: slide.matrixFrom, roundDigits: 5, invoker: 'TO : BEFORE',);
      _output = Trinity.renderSlideMatrix(
        matrix: slide.matrix,
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: flyerBoxHeight,
      )!;
      // Trinity.blogMatrix(matrix: _output, roundDigits: 5, invoker: 'TO : AFTER',);
    }

    return _output;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MrAnderson(
      /// this key allows differentiating between the two slide, never delete this
      key: ValueKey<String>('SlideTransformer_$isMatrixFrom'),
      initialMatrix: getInitialMatrix(
        slide: slide!,
        flyerBoxWidth: flyerBoxWidth,
        flyerBoxHeight: flyerBoxHeight,
        isMatrixFrom: isMatrixFrom,
      ),
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){

        final bool _areTheSame = Trinity.checkMatrixesAreIdentical(
          matrix1: isMatrixFrom == true ? matrixFromNotifier.value : matrixNotifier.value,
          matrixReloaded: m,
        );

        if (_areTheSame == false){

          final Matrix4 _slideMatrix = Trinity.generateSlideMatrix(
              matrix: m,
              flyerBoxWidth: flyerBoxWidth,
              flyerBoxHeight: flyerBoxHeight
          )!;

          setNotifier(
            notifier: isMatrixFrom == true ? matrixFromNotifier : matrixNotifier,
            mounted: mounted,
            value: _slideMatrix,
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
        valueListenable: isMatrixFrom == true ? matrixFromNotifier : matrixNotifier,
        builder: (_, Matrix4? _matrix, Widget? childA){

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
            // alignment: Alignment.center,
            child: childA,
          );

        },

        child: Image.memory(
          slide!.medPic!.bytes!,
          key: const ValueKey<String>('SuperImage_slide_draft'),
          width: flyerBoxWidth,
          height: FlyerDim.flyerHeightByFlyerWidth(
            flyerBoxWidth: flyerBoxWidth,
          ),
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
