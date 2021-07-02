import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerStack extends StatelessWidget {
  final FlyerType flyersType;
  final double flyerSizeFactor;
  final String title;
  final List<TinyFlyer> tinyFlyers;

  FlyerStack({
    this.flyersType,
    this.flyerSizeFactor = 0.3,
    this.title,
    this.tinyFlyers,
});

  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: true);
    final List<TinyFlyer> _tinyFlyers = tinyFlyers == null ? _pro.getTinyFlyersByFlyerType(flyersType) : tinyFlyers;
    // final List<TinyBz> _tinyBzz = _pro.getTinyBzzOfTinyFlyersList(_tinyFlyers);

// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    double _titleSpacing = 5;
    double _collectionHeight = (_screenWidth * Ratioz.xxflyerZoneHeight * flyerSizeFactor) + 20 ;
// -----------------------------------------------------------------------------
    // int _x = 0;
// -----------------------------------------------------------------------------
//     bool _slidingIsOn = false;
// -----------------------------------------------------------------------------
    return

      _tinyFlyers.length == 0 ? Container() :
      Container(
        width: _screenWidth,
        // height: _collectionHeight + 2*_titleSpacing + (_screenHeight * Ratioz.fontSize3) + 12,
        decoration: BoxDecoration(
          // color: Colorz.BlackLingerie,
          //   border: Border.symmetric(
          //       vertical: BorderSide(width: 0.5, color: Colorz.BabyBlueAir, ),
          //   )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            // ---  ABOVE TITLE SPACING
            if (title != null)
              SizedBox(
                width: _screenWidth,
                height: _titleSpacing,
              ),
            // --- COLLECTION TITLE
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SuperVerse(
                  verse: title,
                  size: 2,
                  weight: VerseWeight.bold,
                  centered: false,
                  shadow: true,
                  italic: true,
                  maxLines: 3,
                ),
              ),
            // --- BENEATH TITLE SPACING
            if (title != null)
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
                itemCount: _tinyFlyers.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                addAutomaticKeepAlives: true,
                // cacheExtent: screenHeight*5,
                // dragStartBehavior: DragStartBehavior.start,
                separatorBuilder: (context, _y) => SizedBox(height: 300,width: 10,),
                // key: const PageStorageKey<String>('flyers'),
                // cacheExtent: screenHeight*5,
                itemBuilder: (context,_x) {

                  print('_tinyFlyers[_x].flyerID = ${_tinyFlyers[_x].flyerID}');

                  return

                    // --- works
                    // ChangeNotifierProvider.value(
                    //   value: _tinyFlyers[_x],
                    //   child: ChangeNotifierProvider.value(
                    //     value: _tinyBzz[_x],
                    //     // child:
                    //     // Flyer(
                    //     //   flyerSizeFactor: flyerSizeFactor,
                    //     //   slidingIsOn: _slidingIsOn,
                    //     //   tappingFlyerZone: (){
                    //     //     openFlyer(context, _tinyFlyers[_x].flyerID);
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
                      tinyFlyer: _tinyFlyers[_x],
                      onTap: (tinyFlyer) => Nav().openFlyer(context, tinyFlyer.flyerID),
                    );

                  },

              ),
            ),
          ],
        ),
      );
  }
}
