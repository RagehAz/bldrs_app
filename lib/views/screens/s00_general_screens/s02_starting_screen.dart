import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
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

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Localizer,
      layoutWidget: Stack(
        children: <Widget>[

          // --- stuff
          Column(
            children: <Widget>[

              Stratosphere(),

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

          // --- SKIP BUTTON
          Positioned(
            bottom: 5,
            left: 5,
            child: DreamBox(
              height: 40,
              // width: 70,
              verse: 'Skip       ',
              bubble: true,
              verseScaleFactor: 0.6,
              boxFunction: () => goToRoute(context, Routez.Home),
            ),
          )

        ],
      ),
    );
  }
}
