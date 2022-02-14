import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/review_creator/review_creator.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/submitted_reviews.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;
  final Function onEditReview;
  final ValueNotifier<bool> isEditingReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _editableReviewBubbleHeight = ReviewCreator.expandedHeight(
        pageHeight: pageHeight,
        flyerBoxWidth: flyerBoxWidth,
    );

    return Stack(
      key: const ValueKey<String>('ReviewPageContents'),
      children: <Widget>[

        /// REVIEWS AREA
        SubmittedReviews(
          pageWidth: pageWidth,
          pageHeight: pageHeight,
          reviewPageVerticalController: reviewPageVerticalController,
          flyerBoxWidth: flyerBoxWidth,
        ),

        /// REVIEW CREATOR
        ValueListenableBuilder<bool>(
            valueListenable: isEditingReview,
            builder: (_, bool _isEditingReview, Widget child){
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                bottom: _isEditingReview ? pageHeight - _editableReviewBubbleHeight : 0,
                child: child,
              );
            },

          child: ReviewCreator(
            pageWidth : pageWidth,
            pageHeight: pageHeight,
            flyerBoxWidth: flyerBoxWidth,
            isEditingReview: isEditingReview,
            onEditReview: onEditReview,
            onSubmitReview: onSubmitReview,
            reviewTextController: reviewTextController,
          ),

        ),

      ],
    );
  }
}