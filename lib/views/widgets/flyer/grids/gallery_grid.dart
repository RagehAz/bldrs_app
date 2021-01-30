import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flyer.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  final List<FlyerModel> galleryFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  // final Function tappingMiniFlyer;

  GalleryGrid({
    @required this.gridZoneWidth,
    this.galleryFlyers,
    @required this.flyersVisibilities,
    @required this.bzID,
    // @required this.tappingMiniFlyer,
});

  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<FlyersProvider>(context);
    final List<FlyerModel> _gridFlyers = galleryFlyers == null ? [] : galleryFlyers;//pro.getAllFlyers;
    // -------------------------------------------------------------------------
    double _screenWidth = superScreenWidth(context);
    // -------------------------------------------------------------------------
    int _gridColumnsCount = _gridFlyers.length > 12 ? 5 : _gridFlyers.length > 6 ? 4 : 3;
    // -------------------------------------------------------------------------
    double _spacingRatioToGridWidth = 0.15;
    double _gridFlyerWidth = gridZoneWidth / (_gridColumnsCount + (_gridColumnsCount * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _gridFlyerHeight = _gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double _gridSpacing = _gridFlyerWidth * _spacingRatioToGridWidth;
    int _flyersCount = _gridFlyers.length;
    // -------------------------------------------------------------------------
    int _numOfGridRows(int _flyersCount){
      return
        (_flyersCount/_gridColumnsCount).ceil();
    }
    // -------------------------------------------------------------------------
    int _numOfRows = _numOfGridRows(_flyersCount);
    // -------------------------------------------------------------------------
    double _gridHeight = _gridFlyerHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    // -------------------------------------------------------------------------
    return
      Container(
          width: gridZoneWidth,
          height: _gridHeight,
          child:
          GridView(
            physics: NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.only(right: _gridSpacing, left: _gridSpacing, top: _gridSpacing * 2, bottom: _gridSpacing ),
            // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: _gridSpacing,
              mainAxisSpacing: _gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: _gridFlyerWidth,//_gridFlyerWidth,
            ),

            children: List<Widget>.generate(_gridFlyers.length,
                    (index) =>
                        Opacity(
                      opacity: flyersVisibilities[index] == true ? 1 : 0.1,
                      child: ChangeNotifierProvider.value(
                        value: _gridFlyers[index],
                        child: Flyer(
                          flyerSizeFactor: (((gridZoneWidth - (_gridSpacing*(_gridColumnsCount+1)))/_gridColumnsCount))/_screenWidth,
                          slidingIsOn: false,
                          // flyerID: _gridFlyers[index].flyer.flyerID,
                          tappingFlyerZone:
                          flyersVisibilities[index] == true ?
                              () => openFlyer(context, _gridFlyers[index].flyerID)
                              :
                              (){}
                        ),
                      ),
                    )

            )

          ),
    );
  }
}