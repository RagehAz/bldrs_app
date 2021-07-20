import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_logo.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';

class BzGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<TinyBz> tinyBzz;
  final Function itemOnTap;
  final Axis scrollDirection;
  final int numberOfRows;
  final double corners;

  BzGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    @required this.tinyBzz,
    this.itemOnTap,
    this.scrollDirection,
    this.numberOfRows,
    this.corners,
});

  @override
  Widget build(BuildContext context) {

    List<TinyBz> _tinyBzz = tinyBzz == null ? <TinyBz>[] : tinyBzz;
    //
    List<Color> _boxesColors = <Color>[Colorz.White30, Colorz.White20, Colorz.White10];
    //
    int _gridColumnsCount = numberOfColumns;
    //
    const double _spacingRatioToGridWidth = 0.1;
    double _gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridBzHeight = _gridBzWidth;
    double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;
    int _bzCount = _tinyBzz == <TinyBz>[] || _tinyBzz.length == 0 ? _boxesColors.length : tinyBzz.length;
    int _numOfGridRows(int _bzCount){return (_bzCount/_gridColumnsCount).ceil();}
    int _numOfRows = numberOfRows == null ? _numOfGridRows(_bzCount) : numberOfRows;
    double _gridHeight = //_gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    (_gridBzWidth * _numOfRows) + (_gridSpacing * 2) + (_gridSpacing * (_numOfRows - 2));
    //
    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1,
      maxCrossAxisExtent: _gridBzWidth, //gridFlyerWidth,
    );
    //
    double _zoneCorners = corners == null ? (_gridBzWidth * Ratioz.bzLogoCorner) + _gridSpacing : corners;

    return
      ClipRRect(
        borderRadius: Borderers.superBorderAll(context, _zoneCorners),
        child: Container(
          width: gridZoneWidth,
          height: _gridHeight,
          color: Colorz.White10,
          child: Stack(
            children: <Widget>[

              /// --- GRID FOOTPRINTS
              if (_tinyBzz == [] || _tinyBzz.length == 0)
                GridView(
                  physics: scrollDirection == null ? NeverScrollableScrollPhysics() : null,
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: _gridSpacing, left: _gridSpacing, right: _gridSpacing, bottom: 0),
                  gridDelegate: _gridDelegate,
                  children: _boxesColors.map(
                        (color) => BzLogo(
                          width: _gridBzWidth,
                          image: color,
                          bzPageIsOn: false,
                          miniMode: true,
                          zeroCornerIsOn: false,
                          // onTap: () => itemOnTap(bz.bzID)
                        ),
                  ).toList(),
                ),
              /// --- REAL GRID
              if (_tinyBzz.length != 0)
                GridView(
                  physics: scrollDirection == null ? NeverScrollableScrollPhysics() : null,
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: _gridSpacing, left: _gridSpacing, right: _gridSpacing, bottom: 0),
                  // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                  gridDelegate: _gridDelegate,
                  children: <Widget>[

                    ..._tinyBzz.map(
                          (bz) => BzLogo(
                              width: _gridBzWidth,
                              image: bz.bzLogo,
                              bzPageIsOn: false,
                              miniMode: true,
                              zeroCornerIsOn: false,
                              onTap: () => itemOnTap(bz.bzID)
                          ),

                    ).toList(),

                  ],
                ),

            ],
          ),
        ),
      );
  }
}
