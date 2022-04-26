import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/x_review_creator_text_balloon_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/x_review_user_image_balloon_part.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewCreatorTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreatorTree({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.pageHeight,
    @required this.isEditingReview,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  final double pageHeight;
  final ValueNotifier<bool> isEditingReview; /// p
  final Function onEditReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  /// --------------------------------------------------------------------------
  static double bubbleMarginValue(){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static double expandedHeight({
    @required double pageHeight,
    @required double flyerBoxWidth,
}){
    final double _editableReviewBubbleHeight = pageHeight - (flyerBoxWidth * 0.7);
    return _editableReviewBubbleHeight;
}
// -----------------------------------------------------------------------------
  static double collapsedHeight(){
    return 100;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;

    final double _imageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _reviewBoxWidth = pageWidth - _imageBoxWidth;

    final double _bubbleMarginValue = bubbleMarginValue();

    final double _reviewCreatorExpandedHeight = expandedHeight(
      flyerBoxWidth: flyerBoxWidth,
      pageHeight: pageHeight,
    );

    final double _reviewCreatorCollapsedHeight = collapsedHeight();

    final double _reviewBalloonWidth = _reviewBoxWidth - _bubbleMarginValue;

    return ValueListenableBuilder<bool>(
      key: const ValueKey<String>('Review_Creator'),
        valueListenable: isEditingReview,
        builder: (_, bool _isEditingReview, Widget reviewUserImageBalloonPart){

          return AnimatedContainer(
            key: const ValueKey<String>('review_bubble_key'),
            width: pageWidth,
            height: _isEditingReview ? _reviewCreatorExpandedHeight : _reviewCreatorCollapsedHeight,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            // margin: EdgeInsets.only(bottom: _bubbleMarginValue, top: _bubbleMarginValue),
            color: _isEditingReview ? Colorz.blackSemi255 : Colorz.black255,
            padding: EdgeInsets.only(bottom: _bubbleMarginValue, top: _bubbleMarginValue),
            child: Row(

              children: <Widget>[

                /// REVIEW USER IMAGE BALLOON PART
                reviewUserImageBalloonPart,

                /// REVIEW TEXT BALLOON PART
                ReviewCreatorTextBalloonPart(
                  reviewCreatorExpandedHeight: _reviewCreatorExpandedHeight,
                  bubbleMarginValue: _bubbleMarginValue,
                  userModel: _myUserModel,
                  reviewTextController: reviewTextController,
                  onEditReview: onEditReview,
                  isEditingReview: _isEditingReview,
                  flyerBoxWidth: flyerBoxWidth,
                  onSubmitReview: onSubmitReview,
                  reviewBalloonWidth: _reviewBalloonWidth,
                ),

              ],
            ),
          );

        },
      child: ReviewUserImageBalloonPart(
        userModel: _myUserModel,
        bubbleMargin: _bubbleMarginValue,
        imageBoxWidth: _imageBoxWidth,
      ),
    );
  }
}
