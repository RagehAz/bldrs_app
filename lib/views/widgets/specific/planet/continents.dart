import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/artworks/pyramids.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart' show Sky;
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class Continents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // double questionHeight = screenHeight * 0.35;
    // double wheelHeight = screenHeight * 0.65;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            const NightSky(sky: Sky.Black,),

            Container(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: const <Widget>[],
              ),
            ),

            // ABMain(),

            const Pyramids(
              pyramidsIcon: Iconz.PyramidzYellow,
              loading: true,
            ),

          ],
        ),
      ),
    );
  }
}


