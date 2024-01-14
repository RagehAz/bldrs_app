import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FlyersGridBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGridBuilder({
    required this.gridWidth,
    required this.gridHeight,
    required this.builder,
    required this.itemCount,
    required this.hasResponsiveSideMargin,
    required this.numberOfColumnsOrRows,
    this.topPadding = Ratioz.stratosphere,
    this.scrollDirection = Axis.vertical,
    this.scrollable = true,
    this.scrollController,
    this.bottomPadding,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;
  final int itemCount;
  final Widget Function(BuildContext, int) builder;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final Axis scrollDirection;
  final bool scrollable;
  final ScrollController? scrollController;
  final double? bottomPadding;
  final bool hasResponsiveSideMargin;
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
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _gridWidth = FlyerDim.flyerGridWidth(
      context: context,
      givenGridWidth: gridWidth,
    );

    final double _gridHeight = FlyerDim.flyerGridHeight(
      context: context,
      givenGridHeight: gridHeight,
    );
    // --------------------
    return SizedBox(
      key: const ValueKey<String>('FlyersGridBuilder'),
      width: _gridWidth,
      height: _gridHeight,
      child: ScrollConfiguration(
        behavior: const AppScrollBehavior(),
        child: GridView.builder(
            controller: scrollController,
            physics: scrollable == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            padding: FlyerDim.flyerGridPadding(
              gridWidth: _gridWidth,
              gridHeight: _gridHeight,
              context: context,
              topPaddingValue: topPadding,
              endPadding: bottomPadding,
              gridSpacingValue: FlyerDim.flyerGridGridSpacingValue(_gridSlotWidth),
              isVertical: scrollDirection == Axis.vertical,
              hasResponsiveSideMargin: hasResponsiveSideMargin,
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
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
