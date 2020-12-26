import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';


void changingCountry(){
  Function switchingCountry;
  switchingCountry();
}

class StartingScreen extends StatefulWidget {
  StartingScreen({Key key}) : super(key: key);


  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen> {


  // final GlobalKey<FormState> _key = GlobalKey<FormState>();

//   void _changeLanguage(LanguageClass language) async {
// //    print(language.languageCode);
//     Locale _temp = await setLocale(language.langCode);
//
//     BldrsApp.setLocale(context, _temp);
//   }

// void tappingOnRagehFaceOnce(){
//   debugPrint('Rageh is Awesome');
//   Navigator.pushNamed(context, ObeliskRoute);
// }

  @override
  Widget build(BuildContext context) {

    // String theChosenFlag;
    // = flagFileNameSelectedFromPGLanguageList;
    // void switchingCountry(){
    //   setState(() {
    //     theChosenFlag = flagFileNameSelectedFromPGLanguageList;
    //   });
    // }

    // print(MediaQuery.of(context).size.width);

    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
          backgroundColor: Colorz.DarkBlue,
          body: Stack(
            children: <Widget>[

              NightSky(),

              Column(
                children: <Widget>[

                  // --- APP BAR BACKGROUND RECTANGLE
                  ABMain(
                    searchButtonOn: false,
                    countryButtonOn: true,
                  ),

                  LogoSlogan(),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0,
                  ),

                  // --- CONTINUE WITH APPLE
                  BTMain(
                    buttonVerse: getTranslated(context, 'Continue_Apple'),
                    buttonIcon: Iconz.ComApple,
                    buttonColor: Colorz.BlackBlack,
                    splashColor: Colorz.Yellow,
                    buttonVerseShadow: false,
                    function: Routez.Home,
                    stretched: false,
                  ),

                  // --- CONTINUE WITH FACEBOOK
                  BTMain(
                    buttonVerse: getTranslated(context, 'Continue_Facebook'),
                    buttonIcon: Iconz.ComFacebookWhite,
                    buttonColor: Colorz.Facebook,
                    splashColor: Colorz.Yellow,
                    buttonVerseShadow: false,
                    function: Routez.Home,
                    stretched: false,
                  ),

                  // --- CONTINUE WITH LINKEDIN
                  BTMain(
                    buttonVerse: getTranslated(context, 'Continue_LinkedIn'),
                    buttonIcon: Iconz.ComLinkedin,
                    buttonColor: Colorz.LinkedIn,
                    splashColor: Colorz.Yellow,
                    buttonVerseShadow: false,
                    function: Routez.Home,
                    stretched: false,

                  ),

                ],
              ),
              Pyramids(
                whichPyramid: Iconz.PyramidsYellow,
              ),
              // Rageh(
              //   tappingRageh:(){
              //     debugPrint('Rageh is FUCKINGGGG Awesome');
              //     Navigator.pushNamed(context, Routez.Obelisk);
              //     },
              //   doubleTappingRageh: (){},
              // )


            ],
          )),
    );
  }
}
