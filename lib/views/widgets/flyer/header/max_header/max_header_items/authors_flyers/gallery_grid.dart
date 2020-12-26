import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/pro_flyer/pro_flyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryGrid extends StatelessWidget {

  final double gridZoneWidth;
  // final List<CoFlyer> galleryCoFlyers;
  final List<bool> flyersVisibilities;
  final String bzID;
  // final Function tappingMiniFlyer;

  GalleryGrid({
    @required this.gridZoneWidth,
    // @required this.galleryCoFlyers,
    @required this.flyersVisibilities,
    @required this.bzID,
    // @required this.tappingMiniFlyer,
});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<CoFlyersProvider>(context);
    final List<CoFlyer> galleryCoFlyers = pro.hatCoFlyersByBzID(bzID);
    // -------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
    // -------------------------------------------------------------------------
    int gridColumnsCount = galleryCoFlyers.length > 12 ? 5 : galleryCoFlyers.length > 6 ? 4 : 3;
    // -------------------------------------------------------------------------
    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = gridZoneWidth / (gridColumnsCount + (gridColumnsCount * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    int flyersCount = galleryCoFlyers.length;
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

            children: List<Widget>.generate(galleryCoFlyers.length,
                    (index) =>
                        Opacity(
                      opacity: flyersVisibilities[index] == true ? 1 : 0.1,
                      child: ChangeNotifierProvider.value(
                        value: galleryCoFlyers[index],
                        child: ProFlyer(
                          flyerSizeFactor: (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
                          slidingIsOn: false,
                          // flyerID: galleryCoFlyers[index].flyer.flyerID,
                          tappingFlyerZone:
                          flyersVisibilities[index] == true ?
                              () => openFlyer(context, galleryCoFlyers[index].flyer.flyerID)
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