import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/d_flyer_big_view.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerPreviewScreen({
    @required this.flyerModel,
    @required this.bzModel,
    this.reviewID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String reviewID;
  /// --------------------------------------------------------------------------
  static const String routeName = Routing.flyerScreen;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : reviewID is $reviewID and should auto go to reviews screen then scroll to it
    blog('reviewID is $reviewID and should auto go to reviews screen then scroll to it');

    // --------------------
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,
        body: FlyerBigView(
          key: PageStorageKey<String>(flyerModel.id),
          flyerBoxWidth: Scale.screenWidth(context),
          flyerModel: flyerModel,
          bzModel: bzModel,
          heroTag: 'FlyerPreviewScreen',
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
