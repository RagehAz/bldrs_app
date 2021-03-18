import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:flutter/material.dart';
import '../flyer.dart';

class SliverFlyersGrid extends StatelessWidget {
  final List<FlyerModel> flyersData;

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
                return Flyer(
                  flyerSizeFactor: ((screenWidth - gridSpacing * 1.5) / 2) / screenWidth,
                  // flyerID: flyersData[flyerIndex].flyer.flyerID,
                );
                },
          childCount: flyersData.length,
          addAutomaticKeepAlives: true,
          // addSemanticIndexes: false,
          // addRepaintBoundaries: false,
        ),
           key: new Key(flyersData[flyerIndex].flyerID),


      ),
    );
  }
}
