import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Sky;
import 'package:bldrs/views/widgets/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:flutter/material.dart';

class Continents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // double questionHeight = screenHeight * 0.35;
    // double wheelHeight = screenHeight * 0.65;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            NightSky(sky: Sky.Black,),

            Container(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                ],
              ),
            ),

            // ABMain(),

            Pyramids(
              pyramidsIcon: Iconz.PyramidzYellow,
              loading: true,
            ),

          ],
        ),
      ),
    );
  }
}


