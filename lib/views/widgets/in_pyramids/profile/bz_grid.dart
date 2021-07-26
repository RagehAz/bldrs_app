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
    this.numberOfRows = 1,
    this.corners,
});

  @override
  Widget build(BuildContext context) {

    List<TinyBz> _tinyBzz = tinyBzz == null ? <TinyBz>[] : tinyBzz;

    List<Color> _boxesColors = <Color>[Colorz.White30, Colorz.White20, Colorz.White10];

    const double _spacingRatioToGridWidth = 0.1;
    double _logoWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridSpacing = _logoWidth * _spacingRatioToGridWidth;
    // int _bzCount = _tinyBzz == <TinyBz>[] || _tinyBzz.length == 0 ? _boxesColors.length : tinyBzz.length;
    // int _getNumberOfRowsByCount(int _bzCount){return (_bzCount/numberOfColumns).ceil();}
    // int _numOfRows = numberOfRows == null ? _getNumberOfRowsByCount(_bzCount) : numberOfRows;
    double _logoHeight = _logoWidth;
    double _gridZoneHeight = _gridSpacing + (numberOfRows * (_logoHeight + _gridSpacing));


    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1,
      maxCrossAxisExtent: _logoWidth,
    );
    //
    double _zoneCorners = corners == null ? (_logoWidth * Ratioz.bzLogoCorner) + _gridSpacing : corners;

    return
      ClipRRect(
        borderRadius: Borderers.superBorderAll(context, _zoneCorners),
        child: Container(
          width: gridZoneWidth,
          height: _gridZoneHeight,
          color: Colorz.White10,
          padding: EdgeInsets.only(bottom: _gridSpacing),
          child: Stack(
            children: <Widget>[

              /// --- GRID FOOTPRINTS
              if (_tinyBzz == [] || _tinyBzz.length == 0)
                GridView(
                  physics: scrollDirection == null ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: false,
                  padding: EdgeInsets.only(top: _gridSpacing, left: _gridSpacing, right: _gridSpacing, bottom: 0),
                  gridDelegate: _gridDelegate,
                  children: _boxesColors.map(
                        (color) => BzLogo(
                          width: _logoWidth,
                          image: color,
                          bzPageIsOn: false,
                          microMode: true,
                          zeroCornerIsOn: false,
                          // onTap: () => itemOnTap(bz.bzID)
                        ),
                  ).toList(),
                ),
              /// --- REAL GRID
              if (_tinyBzz.length != 0)
                GridView(
                  physics: scrollDirection == null ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: false,
                  padding: EdgeInsets.only(top: _gridSpacing, left: _gridSpacing, right: _gridSpacing, bottom: 0),
                  // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                  gridDelegate: _gridDelegate,
                  children: <Widget>[

                    ..._tinyBzz.map(
                          (bz) => BzLogo(
                              width: _logoWidth,
                              image: bz.bzLogo,
                              bzPageIsOn: false,
                              microMode: true,
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

