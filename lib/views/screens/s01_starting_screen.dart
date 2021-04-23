import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 's02_auth_screen.dart';

class StartingScreen extends StatelessWidget {
// -----------------------------------------------------------------------------
/// should fetch user current location automatically and suggest them here
  final Zone currentZone = Zone(countryID: '', provinceID: '', areaID: '');
// -----------------------------------------------------------------------------
  void _tapGoogleContinue(BuildContext context) {
      // signInWithGoogle(context, currentZone).then((result) {
      //   if (result != null) {return goToNewScreen(context, EditProfileScreen(firstTimer: true, user: xxxxxxxxxxxxxxxxxxxxxx,));}
      // });
  }
// -----------------------------------------------------------------------------
  void _tapFacebookContinue(BuildContext context){
      // signUpWithFacebook(context, currentZone).then((result) {
      //   if (result != null) {return goToNewScreen(context, EditProfileScreen(firstTimer: true, user: xxxxxxxxxxxxxxxxxxxxxx,));}
      // });
    }
// -----------------------------------------------------------------------------
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

              LogoSlogan(sizeFactor: 0.87,),

              // --- CONTINUE WITH APPLE
              DeviceChecker.deviceIsIOS() ?
              BTMain(
                buttonVerse: Wordz.continueApple(context),
                buttonIcon: Iconz.ComApple,
                buttonColor: Colorz.BlackBlack,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,

              )
                  :
              // CONTINUE WITH GOOGLE
              DeviceChecker.deviceIsAndroid() ?
              BTMain(
                buttonVerse: "Continue with Google",
                buttonIcon: Iconz.ComGooglePlus,
                buttonColor: Colorz.GoogleRed,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: ()=> _tapGoogleContinue(context),
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
                function: () => _tapFacebookContinue(context),
                stretched: false,
              ),

              // --- CONTINUE WITH EMAIL
              BTMain(
                buttonVerse: Wordz.continueEmail(context),
                buttonIcon: Iconz.ComEmail,
                buttonColor: Colorz.WhiteAir,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () => Nav.goToNewScreen(context, AuthScreen()),
                stretched: false,
              ),

            ],
          ),

          // // --- SKIP BUTTON
          // BtSkipAuth(),

        ],
      ),
    );
  }
}
