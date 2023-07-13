import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_flyers_page/x1_bz_flyers_page_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class BzFlyersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFlyersPage({
    required this.zGridController,
    required this.scrollController,
    this.width,
    this.height,
    this.topPadding,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final double? topPadding;
  final ZGridController zGridController;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    // bzModel?.blogBz(invoker: 'BzFlyersPage');

    return FlyersGrid(
      key: const ValueKey<String>('BzFlyersPage_grid'),
      screenName: 'bzFlyersPage',
      zGridController: zGridController,
      scrollController: scrollController,
      flyersIDs: bzModel?.flyersIDs?.reversed.toList(),
      gridWidth: width ?? Scale.screenWidth(context),
      gridHeight: height ?? Scale.screenHeight(context),
      numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 2,
      bottomPadding: Ratioz.horizon,
      showAddFlyerButton: true,
      onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerBzOptionsTap(
        context: context,
        flyer: flyerModel,
      ),
      onFlyerNotFound: (String flyerID){
        blog('BzFlyersPage : flyer is not found ($flyerID)');
      },
      gridType: FlyerGridType.zoomable,
      hasResponsiveSideMargin: true,
    );

  }
// -----------------------------------------------------------------------------
}
