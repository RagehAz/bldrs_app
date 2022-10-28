import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x1_bz_flyers_page_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class BzFlyersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFlyersPage({
    this.width,
    this.height,
    this.topPadding,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final double topPadding;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return FlyersGrid(
      key: const ValueKey<String>('BzFlyersPage_grid'),
      heroPath: 'bzFlyersPage',
      flyersIDs: bzModel.flyersIDs?.reversed?.toList(),
      gridWidth: width ?? Scale.superScreenWidth(context),
      gridHeight: height ?? Scale.superScreenHeight(context),
      authorMode: true,
      onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerBzOptionsTap(
        context: context,
        flyer: flyerModel,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
