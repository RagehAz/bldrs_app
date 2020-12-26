import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
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

            NightSky(),

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
              whichPyramid: Iconz.PyramidzYellow,
            ),

          ],
        ),
      ),
    );
  }
}


