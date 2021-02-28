import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/text_generators.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flyer.dart';

class FlyerStack extends StatelessWidget {
  final FlyerType flyersType;
  final double flyerSizeFactor;

  FlyerStack({
    @required this.flyersType,
    this.flyerSizeFactor = 0.3,
});


  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    final List<FlyerModel> _flyersOfType = _pro.getFlyersByFlyerType(flyersType);
    final List<BzModel> _bzz = _pro.getBzzOfFlyersList(_flyersOfType);

// ----------------------------------------------------------------------------
    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);
// ----------------------------------------------------------------------------
    double _titleSpacing = 5;
    double _collectionHeight = (_screenWidth * Ratioz.xxflyerZoneHeight * flyerSizeFactor) + 20 ;
// ----------------------------------------------------------------------------
    // int _x = 0;
// ----------------------------------------------------------------------------
    bool _slidingIsOn = false;
// ----------------------------------------------------------------------------
    return Container(
      width: _screenWidth,
      height: _collectionHeight + 2*_titleSpacing + (_screenHeight * Ratioz.fontSize3) + 12,
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
            width: _screenWidth,
            height: _titleSpacing,
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
            width: _screenWidth,
            height: _titleSpacing,
          ),

          // --- COLLECTION FLYER'S ZONE
          Container(
            width: _screenWidth,
            height: _collectionHeight,
            // color: Colorz.BloodTest,
            child: ListView.separated(
              itemCount: _flyersOfType.length,
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
                  value: _flyersOfType[_x],
                  child: ChangeNotifierProvider.value(
                    value: _bzz[_x],
                    child: Flyer(
                      flyerSizeFactor: flyerSizeFactor,
                      slidingIsOn: _slidingIsOn,
                      tappingFlyerZone: (){
                        openFlyer(context, _flyersOfType[_x].flyerID);
                        // _slidingIsOff = false;
                        },
                    ),
                  ),
                );

                },

            ),
          ),
        ],
      ),
    );
  }
}
