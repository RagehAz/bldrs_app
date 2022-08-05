import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/x_review_user_image_balloon_part.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/x_submitted_review_text_balloon_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.reviewModel,
    this.specialReview = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  final ReviewModel reviewModel;
  final bool specialReview;
  /// --------------------------------------------------------------------------
  static double bubbleMarginValue(){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static BorderRadius reviewBubbleBorders({
    @required BuildContext context,
}){
    return Borderers.superBorderAll(context, Ratioz.appBarCorner);
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
      child: FutureBuilder(
        future: UserProtocols.fetchUser(
            context: context,
            userID: reviewModel?.userID,
        ),
        builder: (_, AsyncSnapshot<UserModel> snap){

          final UserModel _userModel = snap.data;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// USER IMAGE BALLOON PART
                ReviewUserImageBalloonPart(
                  imageBoxWidth: _imageBoxWidth,
                  bubbleMargin: _bubbleMargin,
                  userModel: _userModel,
                ),

                /// REVIEW BALLOON PART
                SubmittedReviewTextBalloonPart(
                  userModel: _userModel,
                  bubbleMargin: _bubbleMargin,
                  flyerBoxWidth: flyerBoxWidth,
                  reviewBoxWidth: _reviewBoxWidth,
                  reviewText: reviewModel?.text,
                  reviewTimeStamp: reviewModel?.time,
                  specialReview: specialReview,
                ),

              ],
            );

        },
      ),
    );
  }
}
