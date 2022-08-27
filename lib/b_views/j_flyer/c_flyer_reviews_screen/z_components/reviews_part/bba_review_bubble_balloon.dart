import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/b_review_bubble.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewBubbleBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleBox({
    @required this.width,
    this.child,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final Widget child;
  /// --------------------------------------------------------------------------
  static double clearWidth({
  @required double balloonWidth,
}){
    return balloonWidth - (ReviewBubble.spacer * 2);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _spacing = ReviewBubble.spacer;

    return Container(
      width: width,
      constraints: const BoxConstraints(
        minHeight: ReviewBubble.userBalloonSize,
      ),
      decoration: BoxDecoration(
        color: Colorz.white20,
        borderRadius: ReviewBubble.textBubbleCorners(
          context: context,
        ),
      ),
      padding: const EdgeInsets.all(_spacing),
      alignment: Aligners.superTopAlignment(context),
      child: child,
    );
  }

}
