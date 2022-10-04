import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/a_slides_part/flyer_slides_shelf.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/a_submitted_reviews.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
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
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double screenHeight;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _slidesShelfHeight = 120;
    const double _separatorHeight = SeparatorLine.getTotalHeight;
    final double _reviewsBoxHeight = screenHeight - Ratioz.stratosphere - _separatorHeight - _slidesShelfHeight;
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
            width: BldrsAppBar.width(context),
          ),
        ),

        /// REVIEWS
        SubmittedReviews(
          appBarType: appBarType,
          flyerModel: flyerModel,
          pageWidth: _screenWidth,
          pageHeight: _reviewsBoxHeight,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
