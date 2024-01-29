import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/g_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class ReviewBubbleBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleBox({
    required this.width,
    required this.isSpecialReview,
    this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final Widget? child;
  final bool isSpecialReview;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double clearWidth({
    required double balloonWidth,
  }){
    return balloonWidth - (ReviewBox.spacer * 2);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color getBubbleColor({
    required bool isSpecialReview,
  }){
    return isSpecialReview ? Colorz.yellow20 : Colorz.white20;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _spacing = ReviewBox.spacer;

    return Container(
      width: width,
      constraints: const BoxConstraints(
        minHeight: ReviewBox.userBalloonSize,
      ),
      decoration: BoxDecoration(
        color: getBubbleColor(
          isSpecialReview: isSpecialReview,
        ),
        borderRadius: ReviewBox.textBubbleCorners,
      ),
      padding: const EdgeInsets.all(_spacing),
      alignment: BldrsAligners.superTopAlignment(context),
      child: child,
    );

  }
  // -----------------------------------------------------------------------------
}
