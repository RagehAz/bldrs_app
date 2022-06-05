import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/b_review_page_starter.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:flutter/material.dart';

class ConvertibleReviewPagePreStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConvertibleReviewPagePreStarter({
    @required this.infoButtonExpanded,
    @required this.canShowConvertibleReviewButton,
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onReviewButtonTap,
    @required this.reviewButtonExpanded,
    @required this.reviewPageVerticalController,
    @required this.inFlight,
    @required this.onEditReview,
    @required this.isEditingReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    @required this.onShowReviewOptions,
    this.centeredInFooter = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> infoButtonExpanded; /// p
  final ValueNotifier<bool> canShowConvertibleReviewButton; /// p
  final double flyerBoxWidth;
  final bool tinyMode;
  final Function onReviewButtonTap;
  final ValueNotifier<bool> reviewButtonExpanded; /// p
  final ScrollController reviewPageVerticalController;
  final bool inFlight;
  final Function onEditReview;
  final ValueNotifier<bool> isEditingReview; /// p
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  final ValueChanged<ReviewModel> onShowReviewOptions;
  final bool centeredInFooter;
  /// --------------------------------------------------------------------------
  /*
  static double _offsetFixToCenter({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
}){
    final double _buttonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
    );

    final double _spacing = FooterButton.buttonMargin(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
    );

    return _buttonSize + _spacing;
  }
   */
// -----------------------------------------------------------------------------
  static double _getPositionFromRight({
    @required BuildContext context,
  }){
    return appIsLeftToRight(context) ? 0 : null;
  }
// -----------------------------------------------------------------------------
  static double _getPositionFromLeft({
    @required BuildContext context,
  }){

    return appIsLeftToRight(context) ? null : 0;
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    /// WHEN INFO BUTTON EXPANDS, THE CONVERTIBLE REVIEW BUTTON SHOULD HIDE
    return ValueListenableBuilder(
      key: const ValueKey<String>('ConvertibleReviewPagePreStarter'),
      valueListenable: infoButtonExpanded,
      builder: (_, bool infoButtonExpanded, Widget reviewPageStarter){

        if (infoButtonExpanded == false){
          return ValueListenableBuilder(
              valueListenable: canShowConvertibleReviewButton,
              builder: (_, bool canShowConvertibleInfoButton, Widget childB){

                final double _positionFromRight = _getPositionFromRight(
                    context: context,
                );

                final double _positionFromLeft = _getPositionFromLeft(
                    context: context,
                );

                if (canShowConvertibleInfoButton == true){
                  return Positioned(
                    right: _positionFromRight,
                    left: _positionFromLeft,
                    bottom: 0,
                    child: reviewPageStarter,
                  );
                }

                else {
                  return const SizedBox();
                }

              }
          );

        }

        else {
          return const SizedBox();
        }
      },

      child: ReviewPageStarter(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
        onReviewButtonTap: onReviewButtonTap,
        reviewButtonExpanded: reviewButtonExpanded,
        reviewPageVerticalController: reviewPageVerticalController,
        inFlight: inFlight,
        onEditReview: onEditReview,
        isEditingReview: isEditingReview,
        onSubmitReview: onSubmitReview,
        reviewTextController: reviewTextController,
        onShowReviewOptions: (ReviewModel reviewModel) => onShowReviewOptions(reviewModel),
      ),
    );
  }
}
