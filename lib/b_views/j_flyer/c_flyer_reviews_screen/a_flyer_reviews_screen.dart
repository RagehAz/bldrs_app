import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/reviews_space/aa_flyer_review_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class FlyerReviewsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerReviewsScreen({
    @required this.flyerModel,
    this.highlightReviewID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final String highlightReviewID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      title: const Verse(
        text: 'phid_flyer_reviews',
        translate: true,
      ),
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      child: FlyerReviewsScreenView(
        flyerModel: flyerModel,
        screenHeight: _screenHeight,
        highlightReviewID: highlightReviewID,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
