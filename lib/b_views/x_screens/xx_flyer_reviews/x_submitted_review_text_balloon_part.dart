import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/c_review_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SubmittedReviewTextBalloonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviewTextBalloonPart({
    @required this.reviewBoxWidth,
    @required this.bubbleMargin,
    @required this.userModel,
    @required this.flyerBoxWidth,
    @required this.reviewText,
    @required this.reviewTimeStamp,
    this.specialReview = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double reviewBoxWidth;
  final double bubbleMargin;
  final UserModel userModel;
  final double flyerBoxWidth;
  final String reviewText;
  final DateTime reviewTimeStamp;
  final bool specialReview;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: reviewBoxWidth - bubbleMargin,
      decoration: BoxDecoration(
        color: Colorz.white20,
        borderRadius: ReviewBubble.reviewBubbleBorders(
          context: context,
        ),
      ),
      padding: EdgeInsets.all(bubbleMargin),
      alignment: Aligners.superTopAlignment(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// USER NAME
          SuperVerse(
            verse: userModel?.name,
          ),

          /// REVIEW TIME
          SuperVerse(
            verse: Timers.calculateSuperTimeDifferenceString(
              from: reviewTimeStamp,
              to: DateTime.now(),
            ),
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.white200,
            scaleFactor: 0.9,
          ),

          /// REVIEW TEXT
          SuperVerse(
            verse: reviewText,
            maxLines: 100,
            centered: false,
            weight: specialReview ? VerseWeight.bold : VerseWeight.thin,
            scaleFactor: 1.1,
            italic: specialReview,
            color: specialReview ? Colorz.yellow255 : Colorz.white255,
          ),

        ],
      ),
    );
  }
}
