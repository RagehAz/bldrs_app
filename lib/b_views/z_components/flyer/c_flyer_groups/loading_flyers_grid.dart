import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class LoadingFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingFlyersGrid({
    this.width,
    this.height,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumns = 2,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final double topPadding;
  final int numberOfColumns;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double gridWidth = width ?? Scale.superScreenWidth(context);
    final double gridHeight = height ?? Scale.superScreenHeight(context);

// ----------------------------------------------------------
    final double _gridZoneWidth = FlyersGrid.getGridWidth(
      context: context,
      givenGridWidth: gridWidth,
    );
// ----------------------------------------------------------
    final double _gridZoneHeight = FlyersGrid.getGridHeight(
      context: context,
      givenGridHeight: gridHeight,
    );
// ----------------------------------------------------------
    final double _flyerBoxWidth = FlyersGrid.getGridFlyerWidth(
      numberOfColumns: numberOfColumns,
      gridZoneWidth: _gridZoneWidth,
    );
// ----------------------------------------------------------
    final double _gridSpacingValue = FlyersGrid.getGridSpacingValue(
      gridFlyerWidth: _flyerBoxWidth,
    );
// ----------------------------------------------------------
    final EdgeInsets _gridPadding = FlyersGrid.getGridPadding(
      topPaddingValue: topPadding,
      gridSpacingValue: _gridSpacingValue,
    );
// ----------------------------------------------------------
/*
    final double _minWidthFactor =  getFlyerMinWidthFactor(
      gridFlyerWidth: _flyerBoxWidth,
      gridZoneWidth: _gridZoneWidth,
    );
 */
// ----------------------------------------------------------

    return SizedBox(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      width: _gridZoneWidth,
      height: _gridZoneHeight,
      child: GridView.builder(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          padding: _gridPadding,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: _gridSpacingValue,
            mainAxisSpacing: _gridSpacingValue,
            childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
            maxCrossAxisExtent: _flyerBoxWidth,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext ctx, int index){

            return FlyerLoading(flyerBoxWidth: _flyerBoxWidth);

          }


      ),

    );

  }
}
