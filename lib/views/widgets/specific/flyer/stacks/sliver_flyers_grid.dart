import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/gallery_grid.dart';
import 'package:flutter/material.dart';

class SliverFlyersGrid extends StatelessWidget {
  final List<TinyFlyer> tinyFlyers;

  SliverFlyersGrid({
    @required this.tinyFlyers,
  });
// -----------------------------------------------------------------------------
  static const double spacing = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static double calculateFlyerBoxWidth({BuildContext context, int flyersLength}){
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _gridWidth = _screenWidth - (2 * spacing);
    final int _numberOfColumns = GalleryGrid.gridColumnCount(flyersLength);
    final double _flyerBoxWidth = (_gridWidth - ((_numberOfColumns - 1) * spacing)) / _numberOfColumns;
    return _flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = calculateFlyerBoxWidth(
      flyersLength: tinyFlyers.length,
      context: context,
    );

    final int _numberOfColumns = GalleryGrid.gridColumnCount(tinyFlyers.length);

    return SliverPadding(
      padding: EdgeInsets.all(spacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numberOfColumns,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 1  / Ratioz.xxflyerZoneHeight,
        ),

        delegate: SliverChildBuilderDelegate(
              (context, flyerIndex) {

                return

                  FinalFlyer(
                    flyerBoxWidth: _flyerBoxWidth,
                    goesToEditor: false,
                    tinyFlyer: tinyFlyers[flyerIndex],
                    flyerKey: Key(tinyFlyers[flyerIndex].flyerID),
                  );
                },
          childCount: tinyFlyers.length,
          addAutomaticKeepAlives: true,
          // addSemanticIndexes: false,
          // addRepaintBoundaries: false,
        ),
        // key: new Key(tinyFlyers[flyerIndex].flyerID),


      ),
    );
  }
}