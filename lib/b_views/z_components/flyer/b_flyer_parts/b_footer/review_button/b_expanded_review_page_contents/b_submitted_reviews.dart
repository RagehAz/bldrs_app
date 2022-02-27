import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/c_review_bubble.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timerz;
import 'package:flutter/material.dart';

class SubmittedReviews extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviews({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.reviewPageVerticalController,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final ScrollController reviewPageVerticalController;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: pageWidth,
      height: pageHeight,
      child: ListView.builder(
        controller: reviewPageVerticalController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: ReviewBubble.bubbleMarginValue(),
          bottom: 140,
        ),
        itemCount: 10,
        itemBuilder: (_, int index){

          return ReviewBubble(
            pageWidth : pageWidth,
            flyerBoxWidth: flyerBoxWidth,
            userModel: UserModel.dummyUserModel(context),
            reviewText: 'Wallahy ya fandem elly fih el kheir y2addemo rabbena, mesh keda walla eh ?',
            reviewTimeStamp: Timerz.createDate(year: 1987, month: 6, day: 10),
          );

        },
      ),
    );

  }
}
