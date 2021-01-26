import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pro_flyer.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  // final List<CoFlyer> galleryFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  // final Function tappingMiniFlyer;

  GalleryGrid({
    @required this.gridZoneWidth,
    // @required this.galleryFlyers,
    @required this.flyersVisibilities,
    @required this.bzID,
    // @required this.tappingMiniFlyer,
});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<FlyersProvider>(context);
    final List<FlyerModel> galleryFlyers = pro.getAllFlyers;
    // -------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
    // -------------------------------------------------------------------------
    int gridColumnsCount = galleryFlyers.length > 12 ? 5 : galleryFlyers.length > 6 ? 4 : 3;
    // -------------------------------------------------------------------------
    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = gridZoneWidth / (gridColumnsCount + (gridColumnsCount * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    int flyersCount = galleryFlyers.length;
    // -------------------------------------------------------------------------
    int numOfGridRows(int flyersCount){
      return
        (flyersCount/gridColumnsCount).ceil();
    }
    // -------------------------------------------------------------------------
    int _numOfRows = numOfGridRows(flyersCount);
    // -------------------------------------------------------------------------
    double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    // -------------------------------------------------------------------------
    return
      Container(
          width: gridZoneWidth,
          height: gridHeight,
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

            children: List<Widget>.generate(galleryFlyers.length,
                    (index) =>
                        Opacity(
                      opacity: flyersVisibilities[index] == true ? 1 : 0.1,
                      child: ChangeNotifierProvider.value(
                        value: galleryFlyers[index],
                        child: ProFlyer(
                          flyerSizeFactor: (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
                          slidingIsOn: false,
                          // flyerID: galleryFlyers[index].flyer.flyerID,
                          tappingFlyerZone:
                          flyersVisibilities[index] == true ?
                              () => openFlyer(context, galleryFlyers[index].flyerID)
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