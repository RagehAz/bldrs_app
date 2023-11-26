import 'package:basics/animators/widgets/matrix_animator.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_transformer.dart';
import 'package:flutter/material.dart';

class SlideTree extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideTree({
    required this.isPlayingAnimation,
    required this.isDoingMatrixFrom,
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.slide,
    required this.isTransforming,
    required this.onAnimationEnds,
    required this.mounted,
    required this.isPickingColor,
    super.key
  });
  // --------------------
  final ValueNotifier<bool> isPlayingAnimation;
  final ValueNotifier<bool> isDoingMatrixFrom;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final DraftSlide? slide;
  final ValueNotifier<bool> isTransforming;
  final Function onAnimationEnds;
  final bool mounted;
  final ValueNotifier<bool> isPickingColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: isPlayingAnimation,
      builder: (_, bool isPlaying, Widget? animationPlayer) {

        /// WHILE PLAYING ANIMATION
        if (isPlaying == true) {
          return animationPlayer!;
        }

        /// WHILE TRANSFORMING SLIDE
        else {
          return SlideTransformer(
            matrixFromNotifier: matrixFromNotifier,
            matrixNotifier: matrixNotifier,
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: flyerBoxHeight,
            slide: slide,
            isTransforming: isTransforming,
            mounted: mounted,
            isDoingMatrixFrom: isDoingMatrixFrom,
            isPickingColor: isPickingColor,
          );
        }
        },

      /// SLIDE ANIMATOR
      child: MatrixAnimator(
        matrix: Trinity.renderSlideMatrix(
          matrix: slide?.matrix,
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: flyerBoxHeight,
        ),
        matrixFrom: Trinity.renderSlideMatrix(
          matrix: slide?.matrixFrom,
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: flyerBoxHeight,
        ),
        // canAnimate: true,
        curve: slide?.animationCurve ?? Curves.easeIn,
        replayOnRebuild: true,
        repeat: false,
        onAnimationEnds: onAnimationEnds,
        child: slide?.medPic?.bytes == null ? Container() : Image.memory(
          slide!.medPic!.bytes!,
          key: const ValueKey<String>('SuperImage_slide_draft'),
          width: flyerBoxWidth,
          height: flyerBoxHeight,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
