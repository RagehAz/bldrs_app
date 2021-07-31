import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:flutter/material.dart';

class SliverFlyersGrid extends StatelessWidget {
  final List<FlyerModel> flyersData;

  SliverFlyersGrid({@required this.flyersData});

  @override
  Widget build(BuildContext context) {
      int flyerIndex = 0;
// -----------------------------------------------------------------------------
    double screenWidth = MediaQuery.of(context).size.width * 0.5;
    const double gridSpacing = 10;

    return SliverPadding(
      padding: const EdgeInsets.all(gridSpacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: screenWidth,
          mainAxisSpacing: gridSpacing,
          crossAxisSpacing: gridSpacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,

        ),

        delegate: SliverChildBuilderDelegate(
              (context, flyerIndex) {
                return FinalFlyer(
                  flyerZoneWidth: ((screenWidth - gridSpacing * 1.5) / 2),
                  goesToEditor: false,
                  flyerModel: flyersData[flyerIndex],

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
