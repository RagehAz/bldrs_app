import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/auth/email_auth_screen.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/buttons/bt_skip_auth.dart';
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
      sky: Sky.Black,
      appBarType: AppBarType.Localizer,
      layoutWidget: Stack(
        children: <Widget>[

          // --- stuff
          Column(
            children: <Widget>[

              Stratosphere(),

              LogoSlogan(sizeFactor: 0.87,),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0,
              ),

              // --- CONTINUE WITH APPLE
              BTMain(
                buttonVerse: translate(context, 'Continue_Apple'),
                buttonIcon: Iconz.ComApple,
                buttonColor: Colorz.BlackBlack,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,
              ),

              // --- CONTINUE WITH FACEBOOK
              BTMain(
                buttonVerse: translate(context, 'Continue_Facebook'),
                buttonIcon: Iconz.ComFacebookWhite,
                buttonColor: Colorz.Facebook,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,
              ),

              // --- CONTINUE WITH LINKEDIN
              BTMain(
                buttonVerse: translate(context, 'Continue_LinkedIn'),
                buttonIcon: Iconz.ComLinkedin,
                buttonColor: Colorz.LinkedIn,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,

              ),

              // --- CONTINUE WITH EMAIL
              BTMain(
                buttonVerse: 'Continue with E-mail',
                buttonIcon: Iconz.ComEmail,
                buttonColor: Colorz.WhiteAir,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: (){goToNewScreen(context, EmailAuth());},
                stretched: false,

              ),

            ],
          ),

          // --- SKIP BUTTON
          BtSkipAuth(),

        ],
      ),
    );
  }
}

