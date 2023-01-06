import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/zoomable_grid.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/zoomable_grid_controller.dart';
import 'package:flutter/material.dart';

class PackedZoomedLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PackedZoomedLayout({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('PackedZoomedLayout.build()');

    return MainLayout(
      appBarType: AppBarType.basic,
      child: ZoomableGrid(
        controller: initializeBldrsZoomableGridController(
          context: context,
          columnsCount: 3,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}

ZoomableGridController initializeBldrsZoomableGridController({
  @required BuildContext context,
  @required int columnsCount,
}){



  final double _screenWidth = Scale.screenWidth(context);
  final double _screenHeight = Scale.screenHeight(context);

  final double _flyerBoxWidth = FlyerDim.flyerGridFlyerBoxWidth(
    context: context,
    scrollDirection: Axis.vertical,
    numberOfColumnsOrRows: columnsCount,
    gridWidth: _screenWidth,
    gridHeight: _screenHeight,
  );

  final ZoomableGridController _controller = ZoomableGridController()..initialize(
    topPaddingOnZoomedOut: Stratosphere.smallAppBarStratosphere,
    topPaddingOnZoomedIn: Stratosphere.smallAppBarStratosphere - 10,

    smallItemWidth: _flyerBoxWidth,
    smallItemHeight: FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth),

    columnsCount: columnsCount,
    // spacingRatio: Flyer,
  );

  return _controller;
}
