import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/views/widgets/flyer/pro_flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
// Flyer in Full screen mode
// side slidings : changes flyer pages, until end of flyer then gets next flyer of same Business
// story taps : same as slide slidings
// up & down slidings : gets next flyer in the collection
// if in gallery : collection flyer index = gallery flyer index,, vertical sliding exits the flyer either up or down
// pinch in : always exist flyer
// pinch out : zooms in flyer slide, while preserving header & footer
// === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

class FlyerScreen extends StatelessWidget {
  static const routeName = Routez.FlyerScreen;
  final String flyerID;

  FlyerScreen({
    this.flyerID,
});

  @override
  Widget build(BuildContext context) {
    final String flyerIDDD = ModalRoute.of(context).settings.arguments as String;
    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    final FlyerModel flyer = pro.getFlyerByFlyerID(flyerIDDD);


    // temporary condition
    String fID = flyerID == null ? 'f035' : flyerID;

    return MainLayout(
      // appBarIsOn: false,
      // pyramids: false,
      // ragehIsOn: true,
      // tappingRageh: (){print()},
      layoutWidget: Center(
        child:

        ChangeNotifierProvider.value(
          value: flyer,
          child: ProFlyer(
            flyerSizeFactor: 1,// golden factor 0.97,
            // flyerID: fID,
            currentSlideIndex: 0,
            slidingIsOn: true,
            tappingFlyerZone: (){},
          ),
        ),

      ),
    );
  }
}
