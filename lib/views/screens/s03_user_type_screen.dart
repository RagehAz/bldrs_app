import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ChooseUserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of (context).size.width;

    double _boxMargins = 10;
    double _boxWidth = 170;
    double _boxHeight = 150;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          NightSky(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SuperVerse(
                  verse: 'Choose your account\'s type :',
                  size: 4,
                  weight: VerseWeight.thin,
                  designMode: false,
                  shadow: true,
                  centered: true,
                  italic: true,
                  color: Colorz.Yellow,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DreamBox(
                            width: _boxWidth,
                            height: _boxHeight,
                            verse: 'Normal Account',
                            verseColor: Colorz.White,
                            iconSizeFactor: 0.5,
                            color: Colorz.WhiteAir,
                            corners: 20,
                            boxMargins: EdgeInsets.all(_boxMargins),
                            boxFunction: () {
                              Navigator.pushNamed(context, Routez.Home);
                            }),
                        Container(
                          width: _boxWidth * 0.8,
                          height: _boxHeight,
                          margin: EdgeInsets.all(_boxMargins),
                          alignment: Alignment.topCenter,
                          child: SuperVerse(
                            verse:
                                'If you are a Home or Project owner, or just browsing and getting inspired',
                            color: Colorz.Grey,
                            size: 2,
                            maxLines: 10,
                            italic: true,
                            weight: VerseWeight.thin,
                            centered: true,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DreamBox(
                          width: _boxWidth,
                          height: _boxHeight,
                          verse: 'Business Account',
                          verseColor: Colorz.White,
                          iconSizeFactor: 0.5,
                          color: Colorz.WhiteAir,
                          corners: 20,
                          boxMargins: EdgeInsets.all(_boxMargins),
                        ),
                        Container(
                          width: _boxWidth * 0.8,
                          height: _boxHeight,
                          margin: EdgeInsets.all(_boxMargins),
                          alignment: Alignment.topCenter,
                          child: SuperVerse(
                            verse:
                                'If a Realtor, Designer, Supplier, Craftsman or Contractor individual or company.',
                            color: Colorz.Grey,
                            size: 2,
                            maxLines: 10,
                            italic: true,
                            weight: VerseWeight.thin,
                            centered: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Pyramids(
            whichPyramid: Iconz.PyramidzYellow,
          ),
        ],
      ),
    ));
  }
}
