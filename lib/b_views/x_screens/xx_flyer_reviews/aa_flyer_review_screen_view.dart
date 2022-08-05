import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/a_slides_part/flyer_slides_shelf.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/a_submitted_reviews.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerReviewsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerReviewsScreenView({
    @required this.flyerModel,
    @required this.screenHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double screenHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    const double _slidesShelfHeight = 120;
    const double _separatorHeight = 5;
    final double _reviewsBoxHeight = screenHeight - Ratioz.stratosphere - _separatorHeight - _slidesShelfHeight;

    return Column(
      children: <Widget>[

        const Stratosphere(),

        /// SLIDES
        FlyerSlidesShelf(
          flyerModel: flyerModel,
        ),

        /// SEPARATOR
        SeparatorLine(
          width: BldrsAppBar.width(context),
          margins: const EdgeInsets.only(top: 4.5),
        ),

        /// REVIEWS
        SubmittedReviews(
          flyerModel: flyerModel,
          pageWidth: _screenWidth,
          pageHeight: _reviewsBoxHeight,
        ),

      ],
    );

  }
}
