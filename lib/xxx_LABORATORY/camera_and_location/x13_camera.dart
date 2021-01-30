import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_appbar.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            NightSky(),

            Pyramids(whichPyramid: Iconz.PyramidsYellow),

            ABStrip(
              scrollable: true,
              rowWidgets:[

                DreamBox(
                  height: 40,
                  width: 40,
                  boxMargins: EdgeInsets.all(5),
                  icon: Iconz.SavedFlyers,
                  iconSizeFactor: 0.8,
                  color: Colorz.Nothing,
                  boxFunction: (){},
                ),

              ],
            ),


            // Rageh(
            //   tappingRageh:
            //       getTranslated(context, 'Active_Language') == 'Arabic' ?
            //           () async {
            //               Locale temp = await setLocale('en');
            //               BldrsApp.setLocale(context, temp);
            //             } :
            //           () async {
            //               Locale temp = await setLocale('ar');
            //               BldrsApp.setLocale(context, temp);
            //             },
            //   doubleTappingRageh: () {print(screenHeight * 0.0075 / screenWidth);},
            // ),

          ],
        ),
      ),
    );
  }
}
