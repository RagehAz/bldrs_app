import 'package:bldrs/ambassadors/services/facebook.dart';
import 'package:bldrs/ambassadors/services/google.dart';
import 'package:bldrs/ambassadors/services/google.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/view_brains/controllers/devicerz.dart';
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
import 'package:bldrs/view_brains/theme/wordz.dart';

class StartingScreen extends StatelessWidget {
  final Zone currentZone = Zone(countryID: '', provinceID: '', areaID: '');
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      appBarType: AppBarType.Intro,
      layoutWidget: Stack(
        children: <Widget>[
          // --- stuff
          Column(
            children: <Widget>[
              Stratosphere(),

              LogoSlogan(
                sizeFactor: 0.87,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0,
              ),

              // --- CONTINUE WITH APPLE
              deviceIsIOS() ?
              BTMain(
                buttonVerse: Wordz.continueApple(context),
                buttonIcon: Iconz.ComApple,
                buttonColor: Colorz.BlackBlack,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,

              ) :

              // CONTINUE WITH GOOGLE
              deviceIsAndroid() ?
              BTMain(
                buttonVerse: "Continue with Google",
                buttonIcon: Iconz.ComGooglePlus,
                buttonColor: Colorz.GoogleRed,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () {
                  signInWithGoogle(context, currentZone).then((result) {
                    if (result != null) {
                      return goToRoute(context, Routez.FillProfile);
                    }
                  });
                },
                stretched: false,
              )
              :
              Container(),


              // --- CONTINUE WITH FACEBOOK
              BTMain(
                buttonVerse: Wordz.continueFacebook(context),
                buttonIcon: Iconz.ComFacebookWhite,
                buttonColor: Colorz.Facebook,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () {
                  signInWithFacebook(context).then((result) {
                    if (result != null) {
                      return goToRoute(context, Routez.FillProfile);
                    }
                  });
                },
                stretched: false,
              ),

              // --- CONTINUE WITH LINKEDIN
              BTMain(
                buttonVerse: Wordz.continueLinkedIn(context),
                buttonIcon: Iconz.ComLinkedin,
                buttonColor: Colorz.LinkedIn,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,
              ),

              // --- CONTINUE WITH EMAIL
              BTMain(
                buttonVerse: Wordz.continueEmail(context),
                buttonIcon: Iconz.ComEmail,
                buttonColor: Colorz.WhiteAir,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () {
                  goToNewScreen(context, EmailAuth());
                },
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
