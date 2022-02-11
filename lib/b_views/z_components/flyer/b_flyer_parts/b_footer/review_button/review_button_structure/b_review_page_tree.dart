import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_page.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_button_structure/a_review_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_button_structure/c_collapsed_review_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_button_structure/d_expanded_review_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/review_page/review_bubble.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _cornerValue = ReviewButtonStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    final BorderRadius _borders = Borderers.superBorderAll(context, _cornerValue);

    final double _pageWidth = ReviewButtonStarter.expandedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    final double _pageHeight = ReviewButtonStarter.expandedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    // return FooterPageBox(
    //   width: _pageWidth,
    //   height: _pageHeight,
    //   borders: _borders,
    //   child: ValueListenableBuilder(
    //     valueListenable: reviewButtonExpanded,
    //     builder: (_, bool _buttonIsExpanded, Widget child){
    //
    //       return ListView(
    //         shrinkWrap: true,
    //         physics: const NeverScrollableScrollPhysics(),
    //         padding: EdgeInsets.zero, /// ENTA EBN WES5A
    //         children: <Widget>[
    //
    //           child
    //
    //         ],
    //
    //       );
    //
    //     },
    //
    //     child: Column(
    //       children: <Widget>[
    //
    //         /// COLLAPSED REVIEW BUTTON TREE
    //         CollapsedReviewButtonTree(
    //           flyerBoxWidth: flyerBoxWidth,
    //           reviewButtonExpanded: reviewButtonExpanded,
    //         ),
    //
    //         /// EXPANDED REVIEW BUTTON TREE
    //         if (tinyMode == false && inFlight == false)
    //           ExpandedReviewButtonTree(
    //             reviewButtonExpanded: reviewButtonExpanded,
    //             flyerBoxWidth: flyerBoxWidth,
    //             reviewPageVerticalController: reviewPageVerticalController,
    //             pageWidth: _pageWidth,
    //           ),
    //
    //       ],
    //     ),
    //   ),
    // );

    return ListView(
      key: const ValueKey<String>('ReviewPageTree'),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ClipRRect(
          borderRadius: _borders,
          child: Container(
            width: _pageWidth,
            height: _pageHeight,
            alignment: Alignment.topCenter,
            child: Scroller(
              child: ValueListenableBuilder(
                valueListenable: reviewButtonExpanded,
                builder: (_, bool _buttonIsExpanded, Widget child){

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero, /// ENTA EBN WES5A
                    children: <Widget>[

                      child

                    ],

                  );

                },

                child: Column(
                  children: <Widget>[

                    /// COLLAPSED REVIEW BUTTON TREE
                    CollapsedReviewButtonTree(
                      flyerBoxWidth: flyerBoxWidth,
                      reviewButtonExpanded: reviewButtonExpanded,
                    ),

                    /// EXPANDED REVIEW BUTTON TREE
                    if (tinyMode == false && inFlight == false)
                      ExpandedReviewButtonTree(
                        reviewButtonExpanded: reviewButtonExpanded,
                        flyerBoxWidth: flyerBoxWidth,
                        reviewPageVerticalController: reviewPageVerticalController,
                        pageWidth: _pageWidth,
                      ),

                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

