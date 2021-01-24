import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pro_flyer.dart';

class FlyerStack extends StatelessWidget {
  final FlyerType flyersType;
  final double flyerSizeFactor;

  FlyerStack({
    @required this.flyersType,
    this.flyerSizeFactor = 0.3,
});

  int bobo = 0;

  void indexBlackHole (int blackHoled){
    blackHoled = bobo;
  }


  @override
  Widget build(BuildContext context) {
    final CoFlyersProvider pro = Provider.of<CoFlyersProvider>(context, listen: false);
    final List<CoFlyer> flyersOfType = pro.hatCoFlyersByFlyerType(flyersType);
// ----------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);
// ----------------------------------------------------------------------------
    double titleSpacing = 5;
    double collectionHeight = (screenWidth * Ratioz.xxflyerZoneHeight * flyerSizeFactor) + 20 ;
// ----------------------------------------------------------------------------
    // int _x = 0;
// ----------------------------------------------------------------------------
    bool _slidingIsOn = false;
// ----------------------------------------------------------------------------
    return Container(
      width: screenWidth,
      height: collectionHeight + 2*titleSpacing + (screenHeight * Ratioz.fontSize3) + 12,
      decoration: BoxDecoration(
      // color: Colorz.Nothing,
        border: Border.symmetric(
            vertical: BorderSide(width: 0.5, color: Colorz.BabyBlueAir, ),
        )
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // ---  ABOVE TITLE SPACING
          SizedBox(
            width: screenWidth,
            height: titleSpacing,
          ),

          // --- COLLECTION TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SuperVerse(
              verse: flyerTypePluralStringer(context, flyersType),
              size: 2,
              weight: VerseWeight.bold,
              centered: false,
              shadow: true,
              italic: true,
            ),
          ),

          // --- BENEATH TITLE SPACING
          SizedBox(
            width: screenWidth,
            height: titleSpacing,
          ),

          // --- COLLECTION FLYER'S ZONE
          Container(
            width: screenWidth,
            height: collectionHeight,
            // color: Colorz.BloodTest,
            child: ListView.separated(
              itemCount: flyersOfType.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              addAutomaticKeepAlives: true,
              // cacheExtent: screenHeight*5,
              // dragStartBehavior: DragStartBehavior.start,
              separatorBuilder: (context, _y) => SizedBox(height: 300,width: 10,),
              // key: const PageStorageKey<String>('flyers'),
              // cacheExtent: screenHeight*5,
              itemBuilder: (context,_x) {
                return
                // --- works
                ChangeNotifierProvider.value(
                  value: flyersOfType[_x],
                  child: ProFlyer(
                    flyerSizeFactor: flyerSizeFactor,
                    slidingIsOn: _slidingIsOn,
                    tappingFlyerZone: (){
                      openFlyer(context, flyersOfType[_x].flyer.flyerID);
                      // _slidingIsOff = false;
                      },
                  ),
                );

                // --- hero test
                // Hero(
                //   tag: flyersOfType[_x].flyer.flyerID,
                //   child: Material(
                //     type: MaterialType.transparency,
                //     child: ChangeNotifierProvider.value(
                //       value: flyersOfType[_x],
                //       child: ProFlyer(
                //         flyerSizeFactor: flyerSizeFactor,
                //         // flyerID: flyersOfType[_x].flyer.flyerID,
                //         slidingIsOn: _slidingIsOn,
                //         tappingFlyerZone: (){
                //           openFlyerOldWay(context, flyersOfType[_x].flyer.flyerID);
                //           // _slidingIsOff = false;
                //         },
                //       ),
                //     ),
                //   ),
                // );
                },

            ),
          ),
        ],
      ),
    );
  }
}
