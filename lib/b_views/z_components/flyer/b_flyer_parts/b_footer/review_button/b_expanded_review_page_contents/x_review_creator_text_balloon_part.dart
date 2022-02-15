import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/b_review_page_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
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
  /// --------------------------------------------------------------------------
  static double reviewBubbleCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required double bubbleMarginValue,
  }){

    final double _expandedPageCornerValue = ReviewPageStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _reviewBubbleCornerValue = _expandedPageCornerValue - bubbleMarginValue;
    return _reviewBubbleCornerValue;
  }
// -----------------------------------------------------------------------------
  static BorderRadius reviewBubbleBorders({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required double bubbleMarginValue,
  }){
    final double _reviewBubbleCornerValue = reviewBubbleCornerValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      bubbleMarginValue: bubbleMarginValue,
    );
    return Borderers.superBorderAll(context, _reviewBubbleCornerValue);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _reviewBalloonBorders = reviewBubbleBorders(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      bubbleMarginValue: bubbleMarginValue,
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
        alignment: superTopAlignment(context),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            SuperVerse(
              verse: userModel.name,
              centered: false,
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
                width: reviewBalloonWidth,
                textController: reviewTextController,
                maxLines: 4,
                keyboardTextInputType: TextInputType.multiline,
                counterIsOn: false,
                maxLength: 1000,
                minLines: 4,
                inputSize: 3,
                margin: const EdgeInsets.all(5),
                onTap: onEditReview,
                // autofocus: false,
                onChanged: (String x){blog(x);},
              ),

            if (isEditingReview == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  DreamBox(
                    height: 40,
                    verse: 'CANCEL',
                    verseScaleFactor: 0.8,
                    onTap: onEditReview,
                  ),

                  DreamBox(
                    verse: 'SUBMIT',
                    height: 40,
                    color: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    verseScaleFactor: 0.8,
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
