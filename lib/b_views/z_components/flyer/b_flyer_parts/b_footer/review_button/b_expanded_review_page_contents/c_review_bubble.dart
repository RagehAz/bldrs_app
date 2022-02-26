import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/b_review_page_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/x_review_user_image_balloon_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/x_submitted_review_text_balloon_part.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.userModel,
    @required this.reviewText,
    @required this.reviewTimeStamp,
    this.specialReview = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  final UserModel userModel;
  final String reviewText;
  final DateTime reviewTimeStamp;
  final bool specialReview;
  /// --------------------------------------------------------------------------
  static double bubbleMarginValue(){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static double reviewBubbleCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _expandedPageCornerValue = ReviewPageStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _reviewPageMargin = bubbleMarginValue();
    final double _reviewBubbleCornerValue = _expandedPageCornerValue - _reviewPageMargin;
    return _reviewBubbleCornerValue;
  }
// -----------------------------------------------------------------------------
  static BorderRadius reviewBubbleBorders({
    @required BuildContext context,
    @required double flyerBoxWidth,
}){
    final double _reviewBubbleCornerValue = reviewBubbleCornerValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    return Borderers.superBorderAll(context, _reviewBubbleCornerValue);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _imageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _reviewBoxWidth = pageWidth - _imageBoxWidth;

    final double _bubbleMargin = bubbleMarginValue();

    return Container(
      key: const ValueKey<String>('review_bubble_key'),
      width: pageWidth,
      margin: EdgeInsets.only(bottom: _bubbleMargin),
      // height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// USER IMAGE BALLOON PART
          ReviewUserImageBalloonPart(
            imageBoxWidth: _imageBoxWidth,
            bubbleMargin: _bubbleMargin,
            userModel: userModel,
          ),

          /// REVIEW BALLOON PART
          SubmittedReviewTextBalloonPart(
            userModel: userModel,
            bubbleMargin: _bubbleMargin,
            flyerBoxWidth: flyerBoxWidth,
            reviewBoxWidth: _reviewBoxWidth,
            reviewText: reviewText,
            reviewTimeStamp: reviewTimeStamp,
            specialReview: specialReview,
          ),

        ],
      ),
    );
  }
}
