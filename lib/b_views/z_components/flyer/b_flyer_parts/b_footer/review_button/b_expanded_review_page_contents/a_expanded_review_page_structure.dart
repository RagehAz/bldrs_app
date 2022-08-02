import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/b_submitted_reviews.dart';
import 'package:flutter/material.dart';

class ExpandedReviewPageStructure extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandedReviewPageStructure({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    @required this.onEditReview,
    @required this.isEditingReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    @required this.flyerID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;
  final Function onEditReview;
  final ValueNotifier<bool> isEditingReview; /// p
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  final String flyerID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: const ValueKey<String>('ReviewPageContents'),
      children: <Widget>[

        /// REVIEWS AREA
        SubmittedReviews(
          pageWidth: pageWidth,
          pageHeight: pageHeight,
          reviewPageVerticalController: reviewPageVerticalController,
          flyerBoxWidth: flyerBoxWidth,
          flyerID: flyerID,
          onSubmit: onSubmitReview,
          reviewTextController: reviewTextController
        ),

        // /// REVIEW CREATOR
        // ReviewCreatorStarter(
        //   isEditingReview: isEditingReview,
        //   pageHeight: pageHeight,
        //   pageWidth: pageWidth,
        //   flyerBoxWidth: flyerBoxWidth,
        //   onEditReview: onEditReview,
        //   onSubmitReview: onSubmitReview,
        //   reviewTextController: reviewTextController,
        // ),

      ],
    );
  }
}
