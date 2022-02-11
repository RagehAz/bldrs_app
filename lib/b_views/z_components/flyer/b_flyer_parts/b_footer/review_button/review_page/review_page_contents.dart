import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_page/review_bubble.dart';
import 'package:flutter/material.dart';

class ReviewPageContents extends StatelessWidget {

  const ReviewPageContents({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    Key key
  }) : super(key: key);

  final double pageWidth;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;

  @override
  Widget build(BuildContext context) {

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

    const double _reviewBoxHeight = 100;

    return Column(
      key: const ValueKey<String>('ReviewPageContents'),
      children: <Widget>[

        /// COMMENTS AREA
        SizedBox(
          width: pageWidth,
          height: _commentsAreaHeight - _reviewBoxHeight,
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
    );
  }
}
