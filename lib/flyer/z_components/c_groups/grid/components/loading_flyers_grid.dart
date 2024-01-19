import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/flyer/z_components/c_groups/grid/components/flyers_grid_builder.dart';
import 'package:bldrs/flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class LoadingFlyersGrid extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LoadingFlyersGrid({
    required this.hasResponsiveSideMargin,
    required this.numberOfColumnsOrRows,
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.topPadding = Ratioz.stratosphere,
    this.scrollDirection = Axis.vertical,
    this.scrollable = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? gridWidth;
  final double? gridHeight;
  final ScrollController? scrollController;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final Axis scrollDirection;
  final bool scrollable;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _gridWidth = gridWidth ?? MediaQuery.of(context).size.width;
    final double _gridHeight = gridHeight ?? MediaQuery.of(context).size.height;
    // --------------------
    final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: scrollDirection,
      numberOfColumnsOrRows: numberOfColumnsOrRows,
      gridHeight: _gridHeight,
      gridWidth: _gridWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
      // spacingRatio: ,
    );
    // --------------------
    return FlyersGridBuilder(
        gridWidth: _gridWidth,
        gridHeight: _gridHeight,
        scrollController: scrollController,
        scrollable: scrollable,
        topPadding: topPadding,
        numberOfColumnsOrRows: numberOfColumnsOrRows,
        scrollDirection: scrollDirection,
        hasResponsiveSideMargin: hasResponsiveSideMargin,
        itemCount: 12,
        // itemCount: FlyerDim.flyerGridNumberOfSlots(
        //   flyersCount: 12,
        //   addFlyerButtonIsOn: false,
        //   isLoadingGrid: true,
        //   numberOfColumnsOrRows: numberOfColumnsOrRows,
        // ),
        builder: (BuildContext ctx, int index){
          // ---------------------------------------------------------------
          return FlyerLoading(
            flyerBoxWidth: _gridSlotWidth,
            animate: true,
            direction: scrollDirection,
            // boxColor: Colorz.bloodTest,
            // loadingColor: Colors.grey,
          );
          // ---------------------------------------------------------------
        }

    );
    // --------------------

  }
  // -----------------------------------------------------------------------------
}
