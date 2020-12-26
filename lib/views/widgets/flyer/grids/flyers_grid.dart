import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/pro_flyer/pro_flyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  // final List<CoFlyer> flyersData;

  FlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    // @required this.flyersData,
});

  @override
  Widget build(BuildContext context) {
    final CoFlyersProvider pro = Provider.of<CoFlyersProvider>(context, listen: false);
    final List<CoFlyer> savedCoFlyers = pro.hatAllSavedCoFlyers;
// ----------------------------------------------------------------------------
      // int flyerIndex = 0;
// ----------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
// ----------------------------------------------------------------------------
    int gridColumnsCount = numberOfColumns;
    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    int flyersCount = savedCoFlyers.length;
    int numOfGridRows(int flyersCount){
      return
        (flyersCount/gridColumnsCount).ceil();
    }
    int _numOfRows = numOfGridRows(flyersCount);
    // double gridBottomSpacing = gridZoneWidth * 0.15;
    double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
        // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;
    // double flyerMainMargins = screenWidth - gridZoneWidth;
// ----------------------------------------------------------------------------
    return
      Container(
          width: gridZoneWidth,
          height: gridHeight,
          // padding: EdgeInsets.symmetric(horizontal: 0, vertical: flyerZoneWidth * 0.04),
          child:
          GridView(
            physics: NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(right: gridSpacing, left: gridSpacing, top: gridSpacing * 2, bottom: gridSpacing ),
            // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: gridFlyerWidth,//gridFlyerWidth,

            ),
            children: List<Widget>.generate(
              savedCoFlyers.length,
                (index){
                return
                  ChangeNotifierProvider.value(
                    value: savedCoFlyers[index],
                      child: ProFlyer(
                        flyerSizeFactor: (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
                        slidingIsOn: false,
                        tappingFlyerZone: (){
                          openFlyer(context, savedCoFlyers[index].flyer.flyerID);
                        },
                      ),
                    );
                }
            ),


            // savedCoFlyers.map(
            //       (coFlyer, i) => ChangeNotifierProvider.value(
            //         value: savedCoFlyers[coFlyerIndex],
            //         child: ProFlyer(
            //           flyerSizeFactor: (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
            //           slidingIsOn: false,
            //           // flyerID: coFlyer.flyer.flyerID,
            //         ),
            //       ),
            //   ).toList(),


          ),
    );
  }
}
