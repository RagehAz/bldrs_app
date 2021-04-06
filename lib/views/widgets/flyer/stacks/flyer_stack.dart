import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerStack extends StatelessWidget {
  final FlyerType flyersType;
  final double flyerSizeFactor;

  FlyerStack({
    @required this.flyersType,
    this.flyerSizeFactor = 0.3,
});


  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: true);
    final List<TinyFlyer> _tinyFlyersOfType = _pro.getTinyFlyersByFlyerType(flyersType);
    final List<TinyBz> _tinyBzz = _pro.getTinyBzzOfTinyFlyersList(_tinyFlyersOfType);

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
              verse: TextGenerator.flyerTypePluralStringer(context, flyersType),
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
              itemCount: _tinyFlyersOfType.length,
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
                // ChangeNotifierProvider.value(
                //   value: _tinyFlyersOfType[_x],
                //   child: ChangeNotifierProvider.value(
                //     value: _tinyBzz[_x],
                //     // child:
                //     // Flyer(
                //     //   flyerSizeFactor: flyerSizeFactor,
                //     //   slidingIsOn: _slidingIsOn,
                //     //   tappingFlyerZone: (){
                //     //     openFlyer(context, _tinyFlyersOfType[_x].flyerID);
                //     //     // _slidingIsOff = false;
                //     //     },
                //     // ),
                //
                //     // FlyerZone(
                //     //   flyerSizeFactor: flyerSizeFactor,
                //     //   stackWidgets: <Widget>[
                //     //
                //     //     MiniHeader(
                //     //
                //     //     )
                //     //
                //     //     SingleSlide(
                //     //         flyerZoneWidth: superFlyerZoneWidth(context, flyerSizeFactor),
                //     //
                //     //     ),
                //     //
                //     //   ],
                //     // ),
                //
                //   ),
                // )

                  TinyFlyerWidget(
                    flyerSizeFactor: flyerSizeFactor,
                    tinyFlyer: _tinyFlyersOfType[_x],
                  )
                ;

                },

            ),
          ),
        ],
      ),
    );
  }
}
