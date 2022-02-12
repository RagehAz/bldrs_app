import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_page.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/a_review_page_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/c_collapsed_review_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/d_expanded_review_button_tree.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:flutter/material.dart';

class ReviewPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewPageTree({
    @required this.flyerBoxWidth,
    @required this.reviewButtonExpanded,
    @required this.reviewPageVerticalController,
    @required this.inFlight,
    @required this.tinyMode,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    @required this.onShowReviewOptions,
    @required this.flyerModel,
    @required this.onReviewButtonTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<bool> reviewButtonExpanded;
  final ScrollController reviewPageVerticalController;
  final bool inFlight;
  final bool tinyMode;
  final Function onEditReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  final ValueChanged<ReviewModel> onShowReviewOptions;
  final FlyerModel flyerModel;
  final Function onReviewButtonTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _cornerValue = ReviewPageStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    final BorderRadius _borders = Borderers.superBorderAll(context, _cornerValue);

    final double _pageWidth = ReviewPageStarter.expandedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    final double _pageHeight = ReviewPageStarter.expandedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    return FooterPageBox(
      width: _pageWidth,
      height: _pageHeight,
      borders: _borders,
      alignment: Alignment.topCenter,
      scrollerIsOn: false,
      child: ValueListenableBuilder(
        valueListenable: reviewButtonExpanded,
        builder: (_, bool _buttonIsExpanded, Widget child){

          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero, /// ENTA EBN WES5A
            children: <Widget>[child],
          );

        },

        child: Stack(
          children: <Widget>[

            /// EXPANDED REVIEW BUTTON TREE
            if (tinyMode == false && inFlight == false)
              ExpandedReviewPageTree(
                reviewButtonExpanded: reviewButtonExpanded,
                flyerBoxWidth: flyerBoxWidth,
                reviewPageVerticalController: reviewPageVerticalController,
                pageWidth: _pageWidth,
                pageHeight: _pageHeight,
              ),

            /// COLLAPSED REVIEW BUTTON TREE
            CollapsedReviewButtonTree(
              flyerBoxWidth: flyerBoxWidth,
              reviewButtonExpanded: reviewButtonExpanded,
              onReviewButtonTap: onReviewButtonTap,
            ),

          ],
        ),
      ),
    );

  }
}
