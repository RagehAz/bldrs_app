import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/b_views/f_bz/z_components/active_phid_selector.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/auto_scrolling_bar.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class BzFlyersPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzFlyersPage({
    required this.zGridController,
    required this.scrollController,
    required this.activePhid,
    required this.mounted,
    required this.bzModel,
    required this.onlyShowPublished,
    this.showAddFlyerButton = false,
    this.onFlyerOptionsTap,
    super.key
  });
  // --------------------------------
  final ZGridController zGridController;
  final ScrollController scrollController;
  final ValueNotifier<String?> activePhid;
  final bool mounted;
  final BzModel? bzModel;
  final bool showAddFlyerButton;
  final Function(FlyerModel flyer)? onFlyerOptionsTap;
  final bool onlyShowPublished;
  // --------------------------------------------------------------------------
  double _getTopPadding(BzModel? bzModel){

    if (ScopeModel.checkBzHasMoreThanOnePhid(bzModel) == true){
      return Stratosphere.bigAppBarStratosphere;
    }

    else {
      return Stratosphere.smallAppBarStratosphere;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        ValueListenableBuilder(
          valueListenable: activePhid,
          builder: (_, String? _activePhid, Widget? child) {

            return FlyersGrid(
              key: const ValueKey<String>('BzFlyersPage_grid'),
              screenName: 'bzFlyersPage',
              zGridController: zGridController,
              scrollController: scrollController,
              flyersIDs: ScopeModel.getBzFlyersIDs(
                bzModel: bzModel,
                activePhid: _activePhid,
                onlyShowPublished: false,
              ),
              gridWidth: Scale.screenWidth(context),
              gridHeight: Scale.screenHeight(context),
              numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 2,
              bottomPadding: Ratioz.horizon,
              topPadding: _getTopPadding(bzModel),
              showAddFlyerButton: showAddFlyerButton,
              onFlyerOptionsTap: onFlyerOptionsTap,
              onFlyerNotFound: (String flyerID){
                blog('BzFlyersPage : flyer is not found ($flyerID)');
              },
              gridType: FlyerGridType.zoomable,
              hasResponsiveSideMargin: true,
            );

          }
        ),

        if (ScopeModel.checkBzHasMoreThanOnePhid(bzModel) == true)
        AutoScrollingBar(
          scrollController: scrollController,
          child: ActivePhidSelector(
            bzModel: bzModel,
            mounted: mounted,
            activePhid: activePhid,
            onlyShowPublished: onlyShowPublished,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
