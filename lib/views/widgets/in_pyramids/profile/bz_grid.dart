import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:flutter/material.dart';

class BzGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<TinyBz> tinyBzz;
  final Function itemOnTap;
  final Axis scrollDirection;
  final int numberOfRows;

  BzGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    @required this.tinyBzz,
    this.itemOnTap,
    this.scrollDirection,
    this.numberOfRows,
});

  @override
  Widget build(BuildContext context) {

    List<Color> _boxesColors = [Colorz.White30, Colorz.WhiteGlass, Colorz.WhiteAir];

    int _gridColumnsCount = numberOfColumns;

    double _spacingRatioToGridWidth = 0.1;
    double _gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridBzHeight = _gridBzWidth;
    double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;
    int _bzCount = tinyBzz.length == 0 ? _boxesColors.length : tinyBzz.length;
    int _numOfGridRows(int _bzCount){return (_bzCount/_gridColumnsCount).ceil();}
    int _numOfRows = numberOfRows == null ? _numOfGridRows(_bzCount) : numberOfRows;
    double _gridHeight = _gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1,
      maxCrossAxisExtent: _gridBzWidth,//gridFlyerWidth,
    );

    double zoneCorners = (_gridBzWidth * Ratioz.bzLogoCorner) + _gridSpacing;

    return
      ClipRRect(
        borderRadius: superBorderAll(context, zoneCorners),
        child: Container(
          width: gridZoneWidth,
          height: _gridHeight,
          color: Colorz.WhiteAir,
          child: Stack(
            children: <Widget>[

                // --- GRID FOOTPRINTS
              if (tinyBzz.length == 0)
                GridView(
                  physics: scrollDirection == null ? NeverScrollableScrollPhysics() : null,
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(_gridSpacing),
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

                // --- REAL GRID
                GridView(
                  physics: scrollDirection == null ? NeverScrollableScrollPhysics() : null,
                  scrollDirection: scrollDirection == null ? Axis.vertical : scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(_gridSpacing),
                  // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                  gridDelegate: _gridDelegate,
                  children: tinyBzz.map(
                        (bz) => BzLogo(
                            width: _gridBzWidth,
                            image: bz.bzLogo,
                            bzPageIsOn: false,
                            miniMode: true,
                            zeroCornerIsOn: false,
                            onTap: () => itemOnTap(bz.bzID)
                        ),

                  ).toList(),

                ),

              ],
            ),
    ),
      );
  }
}
