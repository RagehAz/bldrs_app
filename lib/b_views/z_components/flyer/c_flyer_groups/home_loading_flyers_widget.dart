import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class HomeLoadingFlyersWidget extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HomeLoadingFlyersWidget({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyersGrid(
      gridHeight: superScreenHeight(context),
      gridWidth: superScreenWidth(context),
      flyers: FlyerModel.dummyFlyers(),
      scrollController: ScrollController(),
    );

  }
}
