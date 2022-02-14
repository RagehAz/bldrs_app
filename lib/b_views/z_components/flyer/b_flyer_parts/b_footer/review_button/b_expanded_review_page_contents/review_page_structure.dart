import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/editable_review_bubble.dart';
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

    final double _editableReviewBubbleHeight = EditableReviewBubble.height(
        pageHeight: pageHeight,
        flyerBoxWidth: flyerBoxWidth,
    );

    return Stack(
      key: const ValueKey<String>('ReviewPageContents'),
      children: <Widget>[

        /// COMMENTS AREA
        SizedBox(
          width: pageWidth,
          height: pageHeight,
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
                  pageHeight: pageHeight,
                  flyerBoxWidth: flyerBoxWidth,
                  userModel: UserModel.dummyUserModel(context),
                );

              },
            ),
          ),
        ),

        /// Editable Review Bubble
        ValueListenableBuilder<bool>(
            valueListenable: isEditingReview,
            builder: (_, bool _isEditingReview, Widget child){

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                bottom: _isEditingReview ? pageHeight - _editableReviewBubbleHeight : 0,
                // top: _isEditingReview ? null : 0,
                // height: 100,
                child: child,
              );

            },

          child: EditableReviewBubble(
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