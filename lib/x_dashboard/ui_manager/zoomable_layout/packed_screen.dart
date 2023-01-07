import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid_controller.dart';
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

    final ZoomableGridController _controller = initializeBldrsZoomableGridController(
      context: context,
      columnsCount: 3,
    );

    return MainLayout(
      appBarType: AppBarType.basic,
      child: ZoomableGrid(
        controller: _controller,
        bigItem: FlyerBox(
          flyerBoxWidth: _controller.getBigItemWidth(context),
          boxColor: Colorz.green80,
          stackWidgets: const [
            Loading(loading: true),
          ],
        ),
        bigItemFootprint: FlyerBox(
          flyerBoxWidth: _controller.getBigItemWidth(context),
          boxColor: Colorz.black255,
        ),

        itemCount: 14,
        builder: (int index){

          return GestureDetector(
            onTap: () => _controller.zoomIn(
                context: context,
                itemIndex: index,
                mounted: true,
            ),
            child: FlyerBox(
              flyerBoxWidth: _controller.smallItemWidth,
              boxColor: Colorz.blue125.withAlpha(Numeric.createRandomIndex(listLength: 1000)),
              stackWidgets: [

                SuperVerse(
                  verse: Verse.plain(index.toString()),
                  margin: 20,
                  labelColor: Colorz.black255,
                ),

              ],

            ),
          );

        },
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
  // const double _spacingRatio = 0.0;

  final double _flyerBoxWidth = FlyerDim.flyerGridFlyerBoxWidth(
    context: context,
    scrollDirection: Axis.vertical,
    numberOfColumnsOrRows: columnsCount,
    gridWidth: _screenWidth,
    gridHeight: _screenHeight,
    // spacingRatio: _spacingRatio,
  );

  final ZoomableGridController _controller = ZoomableGridController()..initialize(
    topPaddingOnZoomedOut: Stratosphere.smallAppBarStratosphere,
    topPaddingOnZoomedIn: Stratosphere.smallAppBarStratosphere - 10,

    smallItemWidth: _flyerBoxWidth,
    smallItemHeight: FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth),

    columnsCount: columnsCount,
    // spacingRatio: _spacingRatio,
    gridHeight: _screenHeight,
    gridWidth: _screenWidth,

  );

  return _controller;
}
