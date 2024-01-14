import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/reviews_space/aa_flyer_review_screen_view.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class FlyerReviewsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerReviewsScreen({
    required this.flyerModel,
    this.highlightReviewID,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerModel? flyerModel;
  final String? highlightReviewID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.screenHeight(context);

    return MainLayout(
      canSwipeBack: true,
      title: const Verse(
        id: 'phid_flyer_reviews',
        translate: true,
      ),
      appBarType: AppBarType.basic,
      skyType: SkyType.grey,
      child: FlyerReviewsScreenView(
        flyerModel: flyerModel,
        screenHeight: _screenHeight,
        highlightReviewID: highlightReviewID,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
