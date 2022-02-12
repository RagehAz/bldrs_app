import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/c_collapsed_review_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/review_page_structure.dart';
import 'package:flutter/material.dart';

class ExpandedReviewPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandedReviewPageTree({
    @required this.reviewButtonExpanded,
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> reviewButtonExpanded;
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _reviewBoxHeight = CollapsedReviewButtonTree.reviewBoxHeight();

    final double _infoButtonCollapsedHeight = InfoButtonStarter.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _infoButtonMarginValue = InfoButtonStarter.collapsedMarginValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _pageFooterHeight = _infoButtonCollapsedHeight + _infoButtonMarginValue;

    final double _commentsAreaHeight = pageHeight - _pageFooterHeight;

    return ValueListenableBuilder(
      key: const ValueKey<String>('REVIEW_PAGE_CONTENTS'),
      valueListenable: reviewButtonExpanded,
      builder: (_, bool buttonExpanded, Widget reviewPageStructure){

        return AnimatedOpacity(
          opacity: buttonExpanded == true ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: reviewPageStructure,
        );

      },

      /// REVIEW PAGE CONTENTS
      child: ReviewPageStructure(
        pageWidth: pageWidth,
        pageHeight: pageHeight,
        flyerBoxWidth: flyerBoxWidth,
        reviewPageVerticalController: reviewPageVerticalController,
     ),

    );
  }
}
