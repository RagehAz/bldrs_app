import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
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
        controller: initializeBldrsZoomableGridController(context),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}

ZoomableGridController initializeBldrsZoomableGridController(BuildContext context){

  final double _zoomedFlyerWidth = BldrsAppBar.width(context);

  final ZoomableGridController _controller = ZoomableGridController()..initialize(
    topPaddingOnZoomedOut: Stratosphere.smallAppBarStratosphere,
    topPaddingOnZoomedIn: Stratosphere.smallAppBarStratosphere - 10,

    bigItemWidth: _zoomedFlyerWidth,
    bigItemHeight: FlyerDim.flyerHeightByFlyerWidth(context, _zoomedFlyerWidth),

    // spacingRatio: Flyer,
  );

  return _controller;
}
