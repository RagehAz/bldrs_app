import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:bldrs/views/widgets/pro_flyer/pro_flyer.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';

class IDscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // print the shit
    dynamic _stuffToPrint = (){
      print('-------');
    };

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            NightSky(),
            Pyramids(
              whichPyramid: Iconz.PyramidsYellow,
            ),
            ProFlyer(
              flyerSizeFactor: 0.95,
              // flyerID: getFlyerByFlyerID('f034')?.flyerID,
            ),

            Rageh(
              tappingRageh: _stuffToPrint,
              doubleTappingRageh: () {
                print('fuck you again');
              },
            ),
          ],
        ),
      ),
    );
  }
}
