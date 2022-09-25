import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerScreen({
    this.flyerModel,
    this.initialSlideIndex,
    this.flyerID,
    this.isSponsored,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final int initialSlideIndex;
  final String flyerID;
  final bool isSponsored;
  /// --------------------------------------------------------------------------
  static const String routeName = Routing.flyerScreen;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,
        body: Flyer(
          key: PageStorageKey<String>(flyerModel.id),
          flyerBoxWidth: Scale.superScreenWidth(context),
          flyerModel: flyerModel,
          screenName: 'FlyerScreen',
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
