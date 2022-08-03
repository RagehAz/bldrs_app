import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/c_review_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewCreatorTextBalloonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreatorTextBalloonPart({
    @required this.isEditingReview,
    @required this.onEditReview,
    @required this.reviewBalloonWidth,
    @required this.reviewCreatorExpandedHeight,
    @required this.bubbleMarginValue,
    @required this.userModel,
    @required this.onSubmitReview,
    @required this.flyerBoxWidth,
    @required this.reviewTextController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isEditingReview;
  final Function onEditReview;
  final double reviewBalloonWidth;
  final double reviewCreatorExpandedHeight;
  final double bubbleMarginValue;
  final UserModel userModel;
  final Function onSubmitReview;
  final double flyerBoxWidth;
  final TextEditingController reviewTextController;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _reviewBalloonBorders = ReviewBubble.reviewBubbleBorders(
        context: context,
    );

    return GestureDetector(
      key: const ValueKey<String>('ReviewCreatorTextBalloonPart'),
      onTap: isEditingReview ? null : onEditReview,
      child: Container(
        width: reviewBalloonWidth,
        // margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colorz.white20,
          borderRadius: _reviewBalloonBorders,
        ),
        padding: EdgeInsets.all(bubbleMarginValue),
        alignment: Aligners.superTopAlignment(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: userModel?.name,
              centered: false,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),

            if (isEditingReview == false)
              const SuperVerse(
                verse: 'Add your review',
                margin: 5,
                weight: VerseWeight.thin,
                color: Colorz.white125,
              ),

            if (isEditingReview == true)
              SuperTextField(
                title: 'Edit Review',
                width: reviewBalloonWidth,
                textController: reviewTextController,
                maxLines: 8,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLength: 1000,
                minLines: 4,
                textSize: 3,
                margins: const EdgeInsets.all(5),
                onTap: onEditReview,
                // autofocus: false,
                onChanged: (String x){blog(x);},
              ),

            if (isEditingReview == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  // DreamBox(
                  //   height: 40,
                  //   verse: 'CANCEL',
                  //   verseScaleFactor: 0.8,
                  //   onTap: onEditReview,
                  // ),

                  DreamBox(
                    verse: 'SUBMIT',
                    height: 40,
                    color: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    verseItalic: true,
                    onTap: onSubmitReview,
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}
