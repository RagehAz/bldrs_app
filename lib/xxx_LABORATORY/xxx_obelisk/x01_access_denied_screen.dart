import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/black_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AccessDeniedScreen extends StatelessWidget {
  static String id = 'AccessDeniedScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

            BlackSky(),

            Container(
              child: Center(
                child: SuperVerse(
                  verse: 'Not yet Designed', // transelate this shit and come back again
                  color: Colorz.Yellow,
                  weight: VerseWeight.black,
                  size: 4,
                  shadow: true,
                ),
              ),
            ),

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
