import 'package:bldrs/providers/flyers_provider.dart';
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
    final pro = Provider.of<FlyersProvider>(context, listen: false); // this is the FlyersProvider data wormHole
    final flyers = pro.getAllFlyers;
    // final someFlyer = flyersData.hatCoFlyerByID('f008');

    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return MainLayout(
      layoutWidget: PageView.builder(
        // itemExtent: ((screenWidth) * Ratioz.xxflyerZoneHeight ) + 20,
        // padding: Stratosphere.stratosphereInsets,
        dragStartBehavior: DragStartBehavior.down,
        onPageChanged: (int){
          // playSound(Soundz.NextFlyer);
        },
        allowImplicitScrolling: true,
        itemCount: flyers.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, i) =>

            ChangeNotifierProvider.value(
                value: flyers[i],
                // or we can use other syntax like :-
                // ChangeNotifierProvider(
                //     create: (c) => flyers[i],
                child: Padding(
                  key: Key(flyers[i].flyerID),
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Flyer(
                    flyerSizeFactor: 1,
                    // currentSlideIndex: 0,
                    slidingIsOn: true,
                    tappingFlyerZone: (){},
                    // flyerID: flyers[i].flyer.flyerID,
                  ),
                )
            ),
      ),

    );

  }
}