import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_button_structure/c_collapsed_review_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_page/review_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ExpandedReviewButtonTree extends StatelessWidget {

  const ExpandedReviewButtonTree({
    @required this.reviewButtonExpanded,
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> reviewButtonExpanded;
  final double pageWidth;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;

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

    final double _commentsAreaHeight = pageWidth - _pageFooterHeight;

    return ValueListenableBuilder(
      key: const ValueKey<String>('REVIEW_PAGE_CONTENTS'),
      valueListenable: reviewButtonExpanded,
      builder: (_, bool buttonExpanded, Widget reviewPageContents){

        return AnimatedOpacity(
          opacity: buttonExpanded == true ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: reviewPageContents,
        );

      },

      /// REVIEW PAGE CONTENTS
      child: Column(
        children: <Widget>[

          /// COMMENTS AREA
          Container(
            width: pageWidth,
            height: _commentsAreaHeight - _reviewBoxHeight,
            color: Colorz.bloodTest,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              controller: reviewPageVerticalController,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, int index){

                return ReviewBubble(
                  pageWidth : pageWidth,
                  flyerBoxWidth: flyerBoxWidth,
                );

              },
            ),
            // child: ,
          ),

          /// COMMENTS FOOTER AREA
          SizedBox(
            width: pageWidth,
            height: _pageFooterHeight,
            // color: Colorz.yellow125,
          ),

        ],
      ),

    );
  }
}
