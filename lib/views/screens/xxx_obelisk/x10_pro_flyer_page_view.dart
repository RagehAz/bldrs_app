import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/pro_flyer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProFlyersPageView extends StatelessWidget {

  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play(Soundz.NextFlyer,);
  // }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<CoFlyersProvider>(context, listen: false); // this is the FlyersProvider data wormHole
    final flyers = pro.hatAllCoFlyers;
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
                  key: Key(flyers[i].flyer.flyerID),
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ProFlyer(
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