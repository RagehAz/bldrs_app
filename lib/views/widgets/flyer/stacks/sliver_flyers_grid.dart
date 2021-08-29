import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/stacks/gallery_grid.dart';
import 'package:flutter/material.dart';

class SliverFlyersGrid extends StatelessWidget {
  final List<TinyFlyer> tinyFlyers;

  SliverFlyersGrid({
    @required this.tinyFlyers,
  });
// -----------------------------------------------------------------------------
  static const double spacing = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static double calculateFlyerZoneWidth({BuildContext context, int flyersLength}){
    double _screenWidth = Scale.superScreenWidth(context);
    double _gridWidth = _screenWidth - (2 * spacing);
    int _numberOfColumns = GalleryGrid.gridColumnCount(flyersLength);
    double _flyerZoneWidth = (_gridWidth - ((_numberOfColumns - 1) * spacing)) / _numberOfColumns;
    return _flyerZoneWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = calculateFlyerZoneWidth(
      flyersLength: tinyFlyers.length,
      context: context,
    );

    int _numberOfColumns = GalleryGrid.gridColumnCount(tinyFlyers.length);

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
                    flyerZoneWidth: _flyerZoneWidth,
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
