import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/review_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/review_page_horizontal_separator.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewPageStructure extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewPageStructure({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerBoxWidth,
    @required this.reviewPageVerticalController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final ScrollController reviewPageVerticalController;
  /// --------------------------------------------------------------------------
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

    const double _reviewBoxHeight = 100;
    final double _commentsAreaHeight = pageHeight - _pageFooterHeight;// - _reviewBoxHeight;

    const double _separatorLineHeight = 0.5;

    return Column(
      key: const ValueKey<String>('ReviewPageContents'),
      children: <Widget>[

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //
        //     collapsedReviewButtonContent,
        //     Container(
        //
        //     ),
        //
        //     SizedBox(
        //       width: _reviewBoxWidth,
        //       height: _reviewBoxHeight,
        //       child: Align(
        //         alignment: Aligners.superCenterAlignment(context),
        //         child: Container(
        //           width: _reviewBoxWidth - _margin,
        //           height: _reviewBoxHeight - _margin,
        //           decoration: BoxDecoration(
        //             color: Colorz.blue255,
        //             borderRadius: superBorderAll(context, 10),
        //           ),
        //
        //         ),
        //       ),
        //     ),
        //
        //   ],
        // ),

        /// REVIEW CREATOR
        // ReviewBubble(
        //   pageWidth : pageWidth,
        //   flyerBoxWidth: flyerBoxWidth,
        //   userModel: UserModel.dummyUserModel(context),
        // ),

        /// COMMENTS AREA
        SizedBox(
          width: pageWidth,
          height: _commentsAreaHeight,
          child: Column(
            children: <Widget>[

              ReviewPageHorizontalSeparator(
                pageWidth: pageWidth,
                separatorLineHeight: _separatorLineHeight,
              ),

              SizedBox(
                width: pageWidth,
                height: _commentsAreaHeight - (2 * _separatorLineHeight),
                child: Scroller(
                  controller: reviewPageVerticalController,
                  child: ListView.builder(
                    controller: reviewPageVerticalController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: ReviewBubble.bubbleMarginValue(),
                      bottom: Ratioz.horizon,
                    ),
                    itemCount: 10,
                    itemBuilder: (_, int index){

                      return ReviewBubble(
                        pageWidth : pageWidth,
                        flyerBoxWidth: flyerBoxWidth,
                        userModel: UserModel.dummyUserModel(context),
                      );

                    },
                  ),
                ),
              ),

              ReviewPageHorizontalSeparator(
                pageWidth: pageWidth,
                separatorLineHeight: _separatorLineHeight,
              ),

            ],
          ),
          // child: ,
        ),

        /// COMMENTS FOOTER AREA
        Container(
          width: pageWidth,
          height: _pageFooterHeight,
          color: Colorz.red125,
        ),

      ],
    );
  }
}