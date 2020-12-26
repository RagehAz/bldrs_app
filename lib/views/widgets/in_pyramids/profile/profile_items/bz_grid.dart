import 'package:flutter/material.dart';

class BzGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  // final List<FlyerData> bzLogos;

  BzGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    // @required this.bzLogos,
});

  @override
  Widget build(BuildContext context) {
      // int flyerIndex = 0;
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
//     double screenWidth = MediaQuery.of(context).size.width;

    int gridColumnsCount = numberOfColumns;

    // double bzHeight = (gridZoneWidth * Ratioz.xxflyerZoneHeight);

    double spacingRatioToGridWidth = 0.1;
    double gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridBzHeight = gridBzWidth;

    double gridSpacing = gridBzWidth * spacingRatioToGridWidth;

    int bzCount = 5;//bzLogos.length;

    int numOfGridRows(int bzCount){
      return
        (bzCount/gridColumnsCount).ceil();
    }

    int _numOfRows = numOfGridRows(bzCount);

    // double gridBottomSpacing = gridZoneWidth * 0.15;
    double gridHeight = gridBzHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
        // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;

    // double flyerMainMargins = screenWidth - gridZoneWidth;

    return
      Container(
          width: gridZoneWidth,
          height: gridHeight,
          // color: Colorz.BloodTest,
          // alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 0, vertical: flyerZoneWidth * 0.04),
          child:
          GridView(
            physics: NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.all(gridSpacing),
            // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: 1 / 1,
              maxCrossAxisExtent: gridBzWidth,//gridFlyerWidth,

            ),

            // children: bzLogos.map(
            //       (flyerData) => BzLogo(
            //         width: gridBzWidth,
            //         image: flyerData.f03bzLogo,
            //         authorIsOn: false,
            //         bzPageIsOn: false,
            //         miniMode: true,
            //       ),
            //
              // ).toList(),

          ),
    );
  }
}
