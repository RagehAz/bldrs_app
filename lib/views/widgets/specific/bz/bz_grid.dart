import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:flutter/material.dart';

class BzGrid extends StatelessWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<BzModel> bzzModels;
  final ValueChanged<String> itemOnTap;
  final Axis scrollDirection;
  final int numberOfRows;
  final double corners;

  const BzGrid({
    @required this.gridZoneWidth,
    @required this.bzzModels,
    @required this.scrollDirection,
    this.numberOfColumns = 3,
    this.itemOnTap,
    this.numberOfRows = 1,
    this.corners,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<BzModel> _bzz = bzzModels == null ? <BzModel>[] : bzzModels;

    const List<Color> _boxesColors = <Color>[Colorz.white30, Colorz.white20, Colorz.white10];

    const double _spacingRatioToGridWidth = 0.1;
    final double _logoWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    final double _gridSpacing = _logoWidth * _spacingRatioToGridWidth;
    // int _bzCount = _bzz == <TinyBz>[] || _bzz.length == 0 ? _boxesColors.length : tinyBzz.length;
    // int _getNumberOfRowsByCount(int _bzCount){return (_bzCount/numberOfColumns).ceil();}
    // int _numOfRows = numberOfRows == null ? _getNumberOfRowsByCount(_bzCount) : numberOfRows;
    final double _logoHeight = _logoWidth;
    final double _gridZoneHeight = _gridSpacing + (numberOfRows * (_logoHeight * 1.25 + _gridSpacing));

    final double _verticalAspectRatio = _logoWidth / ((_logoWidth * 1.25) + (_gridSpacing));

    final SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: scrollDirection == Axis.vertical ?  _verticalAspectRatio : 1/_verticalAspectRatio,
      maxCrossAxisExtent: scrollDirection == Axis.vertical ? _logoWidth : _logoWidth * 1.25,
    );

    final double _zoneCorners = corners == null ? (_logoWidth * Ratioz.bzLogoCorner) + _gridSpacing : corners;

    final EdgeInsets _gridPadding = EdgeInsets.only(top: _gridSpacing, left: _gridSpacing, right: _gridSpacing, bottom: 0);

    final Axis _scrollDirection = scrollDirection == null ? Axis.vertical : scrollDirection;
    final ScrollPhysics _physics = scrollDirection == null ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics();

    return
      ClipRRect(
        borderRadius: Borderers.superBorderAll(context, _zoneCorners),
        child: Container(
          width: gridZoneWidth,
          height: _gridZoneHeight,
          color: Colorz.white10,
          padding: EdgeInsets.only(bottom: _gridSpacing),
          child: Stack(
            children: <Widget>[

              /// --- GRID FOOTPRINTS
              if (_bzz.length == 0)
                GridView(
                  physics: _physics,
                  scrollDirection: _scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: false,
                  padding: _gridPadding,
                  gridDelegate: _gridDelegate,
                  children: _boxesColors.map(
                        (Color color) => Container(
                          width: _logoWidth,
                          height: _logoWidth * 1.25,
                          // color: Colorz.Yellow50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              /// LOGO
                              Container(
                                width: _logoWidth,
                                height: _logoWidth,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: Borderers.superBorderAll(context, BzLogo.cornersValue(_logoWidth))
                                ),
                              ),

                              /// BZ NAME FOOTPRINT
                              Container(
                                width: _logoWidth,
                                height: _logoWidth * 0.25,
                                child: SuperVerse(
                                  verse: '...',
                                  color: color,
                                  weight: VerseWeight.black,
                                  size: 0,
                                ),
                              ),

                            ],
                          ),
                        ),
                  ).toList(),
                ),

              /// --- REAL GRID
              if (_bzz.length != 0)
                GridView(
                  physics: _physics,
                  scrollDirection: _scrollDirection,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: false,
                  padding: _gridPadding,
                  // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                  gridDelegate: _gridDelegate,
                  children: <Widget>[

                    ..._bzz.map(
                          (BzModel bz) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              /// BZ LOGO
                              BzLogo(
                                  width: _logoWidth,
                                  image: bz.logo,
                                  bzPageIsOn: false,
                                  tinyMode: true,
                                  zeroCornerIsOn: false,
                                  onTap: () => itemOnTap(bz.id),
                              ),

                              /// BZ NAME
                              Container(
                                width: _logoWidth,
                                height: _logoWidth * 0.25,
                                // color: Colorz.BloodTest,
                                child: SuperVerse(
                                  verse: bz.name,
                                  scaleFactor: _logoWidth / 120,
                                ),
                              ),

                            ],
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

