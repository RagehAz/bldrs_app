import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_grid_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class LoadingFlyersGrid extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LoadingFlyersGrid({
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.scrollDirection = Axis.vertical,
    this.scrollable = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final Axis scrollDirection;
  final bool scrollable;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: scrollDirection,
      numberOfColumnsOrRows: numberOfColumnsOrRows,
      gridHeight: gridHeight,
      gridWidth: gridWidth,
    );
    // --------------------
    return FlyersGridBuilder(
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        scrollController: scrollController,
        scrollable: scrollable,
        topPadding: topPadding,
        numberOfColumnsOrRows: numberOfColumnsOrRows,
        scrollDirection: scrollDirection,
        itemCount: FlyerDim.flyerGridNumberOfSlots(
          flyersCount: 6,
          addFlyerButtonIsOn: false,
          isLoadingGrid: true,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
        ),
        builder: (BuildContext ctx, int index){
          // ---------------------------------------------------------------
          return FlyerLoading(
            flyerBoxWidth: _gridSlotWidth,
            animate: true,
            direction: scrollDirection,
            // boxColor: Colors.white,
            // loadingColor: Colors.grey,
          );
          // ---------------------------------------------------------------
        }

    );
    // --------------------

  }
  // -----------------------------------------------------------------------------
}