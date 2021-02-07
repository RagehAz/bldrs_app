import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:flutter/material.dart';

class BzGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<BzModel> bzz;
  final Function itemOnTap;

  BzGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    @required this.bzz,
    this.itemOnTap,
});

  @override
  Widget build(BuildContext context) {
      // int flyerIndex = 0;
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
//     double screenWidth = MediaQuery.of(context).size.width;

    List<Color> _boxesColors = [Colorz.White30, Colorz.WhiteGlass, Colorz.WhiteAir];


    int _gridColumnsCount = numberOfColumns;

    // double bzHeight = (gridZoneWidth * Ratioz.xxflyerZoneHeight);

    double _spacingRatioToGridWidth = 0.1;
    double _gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridBzHeight = _gridBzWidth;

    double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;

    int _bzCount = bzz.length == 0 ? _boxesColors.length : bzz.length;

    int _numOfGridRows(int _bzCount){
      return
        (_bzCount/_gridColumnsCount).ceil();
    }

    int _numOfRows = _numOfGridRows(_bzCount);

    // double gridBottomSpacing = gridZoneWidth * 0.15;
    double gridHeight = _gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
        // (_numOfGridRows(flyersCount) * (gridFlyerHeight + _gridSpacing)) + _gridSpacing + gridBottomSpacing;

    // double flyerMainMargins = screenWidth - gridZoneWidth;


    return
      Container(
          width: gridZoneWidth,
          height: gridHeight,
          // color: Colorz.BloodTest,
          // alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 0, vertical: flyerZoneWidth * 0.04),
          child: Stack(
            children: <Widget>[

              // --- GRID FOOTPRINTS
              bzz.length != 0 ? Container() :
              GridView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(_gridSpacing),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: _gridSpacing,
                  mainAxisSpacing: _gridSpacing,
                  childAspectRatio: 1 / 1,
                  maxCrossAxisExtent: _gridBzWidth,//gridFlyerWidth,
                ),

                children: _boxesColors.map(
                      (color) => BzLogo(
                      width: _gridBzWidth,
                      image: color,
                      bzPageIsOn: false,
                      miniMode: true,
                      flyerShowsAuthor: false,
                      // onTap: () => itemOnTap(bz.bzID)
                  ),

                ).toList(),

              ),

              // --- REAL GRID
              GridView(
                physics: NeverScrollableScrollPhysics(),
                addAutomaticKeepAlives: true,
                padding: EdgeInsets.all(_gridSpacing),
                // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: _gridSpacing,
                  mainAxisSpacing: _gridSpacing,
                  childAspectRatio: 1 / 1,
                  maxCrossAxisExtent: _gridBzWidth,//gridFlyerWidth,

                ),

                children: bzz.map(
                      (bz) => BzLogo(
                      width: _gridBzWidth,
                      image: bz.bzLogo,
                      bzPageIsOn: false,
                      miniMode: true,
                      flyerShowsAuthor: false,
                      onTap: () => itemOnTap(bz.bzID)
                  ),

                ).toList(),

              ),

            ],
          ),
    );
  }
}
