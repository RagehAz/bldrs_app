import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/reviews_space/aaa_submitted_reviews.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/slides_shelf/aaa_flyer_slides_shelf.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class FlyerReviewsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerReviewsScreenView({
    @required this.flyerModel,
    @required this.screenHeight,
    @required this.highlightReviewID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double screenHeight;
  final String highlightReviewID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _slidesShelfHeight = 120;
    const double _separatorHeight = SeparatorLine.standardThickness + 4.5;
    // --------------------
    final double _reviewsBoxHeight =
              screenHeight
            - Stratosphere.getStratosphereValue(context: context, appBarType: AppBarType.basic)
            - _separatorHeight
            - _slidesShelfHeight;
    // --------------------
    final double _pageWidth = Bubble.bubbleWidth(context: context);
    // --------------------
    return Column(
      children: <Widget>[

        const Stratosphere(),

        /// SLIDES
        FlyerSlidesShelf(
          flyerModel: flyerModel,
        ),

        /// SEPARATOR
        Padding(
          padding: const EdgeInsets.only(top: 4.5),
          child: SeparatorLine(
            width: _pageWidth,
          ),
        ),

        /// REVIEWS
        SubmittedReviews(
          flyerModel: flyerModel,
          pageWidth: _pageWidth,
          pageHeight: _reviewsBoxHeight,
          highlightReviewID: highlightReviewID,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
