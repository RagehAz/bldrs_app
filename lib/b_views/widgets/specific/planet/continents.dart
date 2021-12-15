import 'package:bldrs/b_views/widgets/general/artworks/pyramids.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class Continents extends StatelessWidget {
  const Continents({Key key}) : super(key: key);

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
            const Sky(
              skyType: SkyType.black,
            ),

            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(),
            ),

            // ABMain(),

            const Pyramids(
              pyramidsIcon: Iconz.pyramidzYellow,
            ),

          ],
        ),
      ),
    );
  }
}
