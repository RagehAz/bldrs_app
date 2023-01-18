import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/zoomable_flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/zoomable_layout/zoomable_grid_controller.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

ZoomableGridController initializeBldrsZoomableGridController({
  @required BuildContext context,
  @required int columnsCount,
  double gridWidth,
  double gridHeight,
}){

  final double _screenWidth = gridWidth ?? UiProvider.proGetScreenDimensions(context: context,
      listen: false).width;
  final double _screenHeight = gridHeight ?? UiProvider.proGetScreenDimensions(context: context,
      listen: false).height;
  // const double _spacingRatio = 0.0;

  final double _gridFlyerWidth = FlyerDim.flyerGridFlyerBoxWidth(
    context: context,
    scrollDirection: Axis.vertical,
    numberOfColumnsOrRows: columnsCount,
    gridWidth: _screenWidth,
    gridHeight: _screenHeight,
    // spacingRatio: _spacingRatio,
  );

  /// ZOOMED FLYER ALIGNMENT : IF YOU WANT TO CENTER
  // final double _zoomedInFlyerHeight = BldrsAppBar.width(context) * FlyerDim.xFlyerBoxHeightRatioToWidth;
  // final double _topPaddingOnZoomIn = (_screenHeight - _zoomedInFlyerHeight) / 2;
  /// IF YOU WANT TO ALIGN TO TOP
  const double _topPaddingOnZoomIn = 10;

  final ZoomableGridController _controller = ZoomableGridController()..initialize(
    topPaddingOnZoomedOut: Stratosphere.smallAppBarStratosphere,
    topPaddingOnZoomedIn: _topPaddingOnZoomIn, //Stratosphere.smallAppBarStratosphere - 10,

    smallItemWidth: _gridFlyerWidth,
    smallItemHeight: _gridFlyerWidth * FlyerDim.flyerHeightRatioToWidth(
      forceMaxRatio: false,
    ),

    columnsCount: columnsCount,
    // spacingRatio: _spacingRatio,
    gridHeight: _screenHeight,
    gridWidth: _screenWidth,

  );

  return _controller;
}

class FlyersZoomedLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersZoomedLayout({
    this.columnsCount = 2,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int columnsCount;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
    final List<String> _flyersIDs = [..._user.savedFlyers.all];

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      listenToHideLayout: true,
      child: ZoomableFlyersGrid(
        flyersIDs: _flyersIDs,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
        columnCount: columnsCount,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}