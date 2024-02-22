import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/active_phids_selector/active_phid_selector.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class BzFlyersView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzFlyersView({
    required this.zGridController,
    required this.scrollController,
    required this.activePhid,
    required this.mounted,
    required this.bzModel,
    required this.onlyShowPublished,
    this.showAddFlyerButton = false,
    this.onFlyerOptionsTap,
    this.appBarType = AppBarType.basic,
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
  final AppBarType appBarType;
  // --------------------------------------------------------------------------
  double _getTopPadding(BzModel? bzModel){

    final double _big = appBarType == AppBarType.non ? Stratosphere.smallAppBarStratosphere : Stratosphere.bigAppBarStratosphere;
    final double _small = appBarType == AppBarType.non ? Ratioz.appBarMargin : Stratosphere.smallAppBarStratosphere;

    if (ScopeModel.checkBzHasMoreThanOnePhid(bzModel) == true){
      return _big;
    }

    else {
      return _small;
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
              gridWidth: Scale.screenWidth(getMainContext()),
              gridHeight: Scale.screenHeight(getMainContext()),
              numberOfColumnsOrRows: Scale.isLandScape(getMainContext()) == true ? 4 : 2,
              bottomPadding: MirageModel.getBzMirageBottomInsetsValue(context),
              topPadding: _getTopPadding(bzModel),
              showAddFlyerButton: showAddFlyerButton,
              onFlyerOptionsTap: onFlyerOptionsTap,
              onMissingFlyerTap: (String? flyerID){
                blog('BzFlyersPage : flyer is not found ($flyerID)');
              },
              gridType: FlyerGridType.zoomable,
              hasResponsiveSideMargin: true,
            );

          }
        ),

        if (ScopeModel.checkBzHasMoreThanOnePhid(bzModel) == true)
          LiveActivePhidSelector(
            bzModel: bzModel,
            mounted: mounted,
            activePhid: activePhid,
            onlyShowPublished: onlyShowPublished,
            scrollController: scrollController,
            hasExtraHeight: true,
            appBarType: appBarType,
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
