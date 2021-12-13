import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/gallery_grid.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SliverFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SliverFlyersGrid({
    @required this.flyers,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;

  /// --------------------------------------------------------------------------
  static const double spacing = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static double calculateFlyerBoxWidth(
      {BuildContext context, int flyersLength}) {
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _gridWidth = _screenWidth - (2 * spacing);
    final int _numberOfColumns = GalleryGrid.gridColumnCount(flyersLength);
    final double _flyerBoxWidth =
        (_gridWidth - ((_numberOfColumns - 1) * spacing)) / _numberOfColumns;
    return _flyerBoxWidth;
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _flyerBoxWidth = calculateFlyerBoxWidth(
      flyersLength: flyers.length,
      context: context,
    );

    final int _numberOfColumns = GalleryGrid.gridColumnCount(flyers.length);

    return SliverPadding(
      padding: const EdgeInsets.all(spacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numberOfColumns,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
        ),

        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int flyerIndex) {
            return FinalFlyer(
              flyerBoxWidth: _flyerBoxWidth,
              flyerModel: flyers[flyerIndex],
              flyerKey: Key(flyers[flyerIndex].id),
              onSwipeFlyer: (Sliders.SwipeDirection direction) {
                // print('Direction is ${direction}');
              },
            );
          },
          childCount: flyers.length,
          // addSemanticIndexes: false,
          // addRepaintBoundaries: false,
        ),
        // key: new Key(tinyFlyers[flyerIndex].flyerID),
      ),
    );
  }
}
