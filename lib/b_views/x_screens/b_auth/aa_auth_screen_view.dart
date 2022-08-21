import 'package:bldrs/b_views/x_screens/b_auth/b_email_auth_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols_old.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthScreenView({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        const LogoSlogan(
          showTagLine: true,
          showSlogan: true,
          sizeFactor: 0.8,
        ),

        const SizedBox(
          height: Ratioz.appBarMargin,
        ),

        /// TASK : - FACEBOOK - GOOGLE - APPLE AUTH WILL BE IN V1.1
        // /// --- CONTINUE WITH APPLE
        // if (DeviceChecker.deviceIsIOS() == true)
        //   MainButton(
        //     buttonVerse: Wordz.continueApple(context),
        //     buttonIcon: Iconz.comApple,
        //     buttonColor: Colorz.black230,
        //     buttonVerseShadow: false,
        //     function: Routez.home,
        //
        //   ),
        //
        // /// --- CONTINUE WITH GOOGLE
        // if (DeviceChecker.deviceIsAndroid() == true)
        //   MainButton(
        //     buttonVerse: 'Continue with Google',
        //     buttonIcon: Iconz.comGooglePlus,
        //     buttonColor: Colorz.googleRed,
        //     buttonVerseShadow: false,
        //     function: () => authByGoogle(context),
        //   ),
        //
        // /// --- CONTINUE WITH FACEBOOK
        // MainButton(
        //   buttonVerse: Wordz.continueFacebook(context),
        //   buttonIcon: Iconz.comFacebookWhite,
        //   buttonColor: Colorz.facebook,
        //   buttonVerseShadow: false,
        //   function: () => authByFacebook(context),
        // ),

        /// --- CONTINUE WITH EMAIL
        MainButton(
          verse: xPhrase(context, 'phid_continueEmail'),
          icon: Iconz.comEmail,
          buttonColor: Colorz.white10,
          buttonVerseShadow: false,
          onTap: () async {

              await Nav.goToNewScreen(
                  context: context,
                  screen: const EmailAuthScreen(),
              );

          },
        ),

      ],
    );

  }
}
