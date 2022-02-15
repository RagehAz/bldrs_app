import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/e_review_creator_tree.dart';
import 'package:flutter/material.dart';

class ReviewCreatorStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreatorStarter({
    @required this.isEditingReview,
    @required this.pageHeight,
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isEditingReview;
  final double pageHeight;
  final double pageWidth;
  final double flyerBoxWidth;
  final Function onEditReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _editableReviewBubbleHeight = ReviewCreatorTree.expandedHeight(
      pageHeight: pageHeight,
      flyerBoxWidth: flyerBoxWidth,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: isEditingReview,
      builder: (_, bool _isEditingReview, Widget child){
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: _isEditingReview ? pageHeight - _editableReviewBubbleHeight : 0,
          child: child,
        );
        },

      child: ReviewCreatorTree(
        pageWidth : pageWidth,
        pageHeight: pageHeight,
        flyerBoxWidth: flyerBoxWidth,
        isEditingReview: isEditingReview,
        onEditReview: onEditReview,
        onSubmitReview: onSubmitReview,
        reviewTextController: reviewTextController,
      ),

    );
  }
}
