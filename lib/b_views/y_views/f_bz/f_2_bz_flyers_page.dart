import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/my_bz_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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

    final List<FlyerModel> _bzFlyers = BzzProvider.proGetActiveBzFlyers(
      context: context,
      listen: true,
    );

    if (_bzFlyers != null){
      return FlyersGrid(
        key: const ValueKey<String>('BzFlyersPage_grid'),
        flyers: _bzFlyers,
        gridWidth: width ?? Scale.superScreenWidth(context),
        gridHeight: height ?? Scale.superScreenHeight(context),
        scrollController: null,
        // numberOfColumns: 2,
        // topPadding: Stratosphere.smallAppBarStratosphere,
        authorMode: true,
        onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerOptionsTap(
          context: context,
          flyer: flyerModel,
          bzModel: bzModel,
        ),
      );
    }

    else {
      return const SizedBox();
    }

  }
}
