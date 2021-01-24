import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_flyer.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import '../pro_flyer.dart';

class SliverFlyersGrid extends StatelessWidget {
  final List<CoFlyer> flyersData;

  SliverFlyersGrid({@required this.flyersData});

  @override
  Widget build(BuildContext context) {
      int flyerIndex = 0;
// -------------------------------------------------------------------------
    double screenWidth = MediaQuery.of(context).size.width * 0.5;
    double gridSpacing = 10;

    return SliverPadding(
      padding: EdgeInsets.all(gridSpacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: screenWidth,
          mainAxisSpacing: gridSpacing,
          crossAxisSpacing: gridSpacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,

        ),

        delegate: SliverChildBuilderDelegate(
              (context, flyerIndex) {
                return ProFlyer(
                  flyerSizeFactor: ((screenWidth - gridSpacing * 1.5) / 2) / screenWidth,
                  // flyerID: flyersData[flyerIndex].flyer.flyerID,
                );
                },
          childCount: flyersData.length,
          addAutomaticKeepAlives: true,
          // addSemanticIndexes: false,
          // addRepaintBoundaries: false,
        ),
           key: new Key(flyersData[flyerIndex].flyer.flyerID),


      ),
    );
  }
}
