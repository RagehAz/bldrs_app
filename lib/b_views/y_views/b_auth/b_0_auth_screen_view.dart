import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';


class AuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthScreenView({
    this.onAuthTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<AuthBy> onAuthTap;
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

        /// --- CONTINUE WITH APPLE
        if (DeviceChecker.deviceIsIOS() == true)
          MainButton(
            buttonVerse: Wordz.continueApple(context),
            buttonIcon: Iconz.comApple,
            buttonColor: Colorz.black230,
            buttonVerseShadow: false,
            function: Routez.home,
          ),

        /// --- CONTINUE WITH GOOGLE
        if (DeviceChecker.deviceIsAndroid() == true)
          MainButton(
            buttonVerse: 'Continue with Google',
            buttonIcon: Iconz.comGooglePlus,
            buttonColor: Colorz.googleRed,
            buttonVerseShadow: false,
            function: () => onAuthTap(AuthBy.google),
          ),

        /// --- CONTINUE WITH FACEBOOK
        MainButton(
          buttonVerse: Wordz.continueFacebook(context),
          buttonIcon: Iconz.comFacebookWhite,
          buttonColor: Colorz.facebook,
          buttonVerseShadow: false,
          function: () => onAuthTap(AuthBy.facebook),
        ),

        /// --- CONTINUE WITH EMAIL
        MainButton(
          buttonVerse: Wordz.continueEmail(context),
          buttonIcon: Iconz.comEmail,
          buttonColor: Colorz.white10,
          buttonVerseShadow: false,
          function: () => onAuthTap(AuthBy.email),
        ),

      ],
    );
  }
}
