import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/e_expanded_review_page_structure.dart';
import 'package:flutter/material.dart';

class ExpandedReviewPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandedReviewPageTree({
    @required this.reviewButtonExpanded,
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    @required this.isEditingReview,
    @required this.onEditReview,
    @required this.reviewTextController,
    @required this.onSubmitReview,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> reviewButtonExpanded;
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;
  final ValueNotifier<bool> isEditingReview;
  final Function onEditReview;
  final TextEditingController reviewTextController;
  final Function onSubmitReview;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('REVIEW_PAGE_CONTENTS'),
      valueListenable: reviewButtonExpanded,
      builder: (_, bool buttonExpanded, Widget expandedReviewPageStructure){

        return AnimatedOpacity(
          opacity: buttonExpanded == true ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: expandedReviewPageStructure,
        );

      },

      /// EXPANDED REVIEW PAGE STRUCTURE
      child: ExpandedReviewPageStructure(
        pageWidth: pageWidth,
        pageHeight: pageHeight,
        flyerBoxWidth: flyerBoxWidth,
        reviewPageVerticalController: reviewPageVerticalController,
        onEditReview: onEditReview,
        isEditingReview: isEditingReview,
        reviewTextController: reviewTextController,
        onSubmitReview: onSubmitReview,
     ),

    );
  }
}
