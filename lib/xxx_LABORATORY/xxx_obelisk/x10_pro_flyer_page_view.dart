import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/flyer/flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersPageView extends StatelessWidget {

  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play(Soundz.NextFlyer,);
  // }

  @override
  Widget build(BuildContext context) {
    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    final List<TinyFlyer> _tinyFlyers = pro.getAllTinyFlyers;
    final List<TinyBz> bzz = pro.getTinyBzzOfTinyFlyersList(_tinyFlyers);

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: PageView.builder(
        // itemExtent: ((screenWidth) * Ratioz.xxflyerZoneHeight ) + 20,
        // padding: Stratosphere.stratosphereInsets,
        dragStartBehavior: DragStartBehavior.down,
        onPageChanged: (int){
          // playSound(Soundz.NextFlyer);
        },
        allowImplicitScrolling: true,
        itemCount: _tinyFlyers.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, i) =>

            // ChangeNotifierProvider.value(
            //     value: _tinyFlyers[i],
            //     // or we can use other syntax like :-
            //     // ChangeNotifierProvider(
            //     //     create: (c) => flyers[i],
            //     child: ChangeNotifierProvider.value(
            //       value: bzz[i],
            //       child: Padding(
            //         key: Key(_tinyFlyers[i].flyerID),
            //         padding: const EdgeInsets.only(bottom: 0),
            //         child:
            //
            //         Flyer(
            //           flyerSizeFactor: 1,
            //           // currentSlideIndex: 0,
            //           slidingIsOn: true,
            //           tappingFlyerZone: (){},
            //           // flyerID: flyers[i].flyer.flyerID,
            //         ),
            //       ),
            //     )
            // ),


        flyerModelBuilder(
          context: context,
          tinyFlyer: _tinyFlyers[i],
          flyerSizeFactor: 0.8,
          builder: (ctx, flyerModel){
            return AFlyer(
              flyer: flyerModel,
              flyerSizeFactor: 0.8,
            );
          }
        ),

      ),

    );

  }
}