import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flyer.dart';

class FlyersGrid extends StatefulWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  // final List<CoFlyer> flyersData;

  FlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    // @required this.flyersData,
});

  @override
  _FlyersGridState createState() => _FlyersGridState();
}

class _FlyersGridState extends State<FlyersGrid> {

  void rebuildGrid(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final user = Provider.of<UserModel>(context);
    // List<dynamic> savedFlyersIDs = [ 'f037'];
    final List<FlyerModel> savedFlyers = pro.getSavedFlyers;
    final List<BzModel> bzz = pro.getBzzOfFlyersList(savedFlyers);
// ----------------------------------------------------------------------------
      // int flyerIndex = 0;
// ----------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
// ----------------------------------------------------------------------------
    int gridColumnsCount = widget.numberOfColumns;
    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = widget.gridZoneWidth / (widget.numberOfColumns + (widget.numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    int flyersCount = savedFlyers.length;
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
          width: widget.gridZoneWidth,
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
              savedFlyers.length,
                (index){
                return
                  ChangeNotifierProvider.value(
                    value: savedFlyers[index],
                      child: ChangeNotifierProvider.value(
                        value: bzz[index],
                        child: Flyer(
                          flyerSizeFactor: (((widget.gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
                          slidingIsOn: false,
                          rebuildFlyerGrid: rebuildGrid,
                          tappingFlyerZone: (){
                            openFlyer(context, savedFlyers[index].flyerID);
                          },
                          flyerIsInGalleryNow: true,
                        ),
                      ),
                    );
                }
            ),


            // savedFlyers.map(
            //       (coFlyer, i) => ChangeNotifierProvider.value(
            //         value: savedFlyers[coFlyerIndex],
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
