import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyersGridBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGridBuilder({
    @required this.gridWidth,
    @required this.gridHeight,
    @required this.builder,
    @required this.itemCount,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.scrollDirection = Axis.vertical,
    this.scrollable = true,
    this.scrollController,
    this.bottomPadding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;
  final int itemCount;
  final Widget Function(BuildContext, int) builder;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final Axis scrollDirection;
  final bool scrollable;
  final ScrollController scrollController;
  final double bottomPadding;
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
    return SizedBox(
      key: const ValueKey<String>('FlyersGridBuilder'),
      width: FlyerDim.flyerGridWidth(
        context: context,
        givenGridWidth: gridWidth,
      ),
      height: FlyerDim.flyerGridHeight(
        context: context,
        givenGridHeight: gridHeight,
      ),
      child: GridView.builder(
          controller: scrollController,
          physics: scrollable == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          padding: FlyerDim.flyerGridPadding(
            context: context,
            topPaddingValue: topPadding,
            endPadding: bottomPadding,
            gridSpacingValue: FlyerDim.flyerGridGridSpacingValue(_gridSlotWidth),
            isVertical: scrollDirection == Axis.vertical,
          ),
          gridDelegate: FlyerDim.flyerGridDelegate(
            context: context,
            flyerBoxWidth: _gridSlotWidth,
            numberOfColumnsOrRows: numberOfColumnsOrRows,
            scrollDirection: scrollDirection,
          ),
          scrollDirection: scrollDirection,
          itemCount: itemCount,
          itemBuilder: builder,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
