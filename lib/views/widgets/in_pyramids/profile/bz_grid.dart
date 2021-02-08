import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
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

    List<Color> _boxesColors = [Colorz.White30, Colorz.WhiteGlass, Colorz.WhiteAir];

    int _gridColumnsCount = numberOfColumns;

    double _spacingRatioToGridWidth = 0.1;
    double _gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridBzHeight = _gridBzWidth;
    double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;
    int _bzCount = bzz.length == 0 ? _boxesColors.length : bzz.length;
    int _numOfGridRows(int _bzCount){return (_bzCount/_gridColumnsCount).ceil();}
    int _numOfRows = _numOfGridRows(_bzCount);
    double gridHeight = _gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1,
      maxCrossAxisExtent: _gridBzWidth,//gridFlyerWidth,
    );

    return
      Container(
          width: gridZoneWidth,
          height: gridHeight,
          child: Stack(
            children: <Widget>[

              // --- GRID FOOTPRINTS
              bzz.length != 0 ? Container() :
              GridView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(_gridSpacing),
                gridDelegate: _gridDelegate,
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
                gridDelegate: _gridDelegate,
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
