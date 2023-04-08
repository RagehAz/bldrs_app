import 'package:authing/authing.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/a_email_auth_screen.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class AuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthScreenView({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SignInMethod> methods = [
      if (DeviceChecker.deviceIsIOS() == true) SignInMethod.apple,
      SignInMethod.google,
      SignInMethod.facebook
    ];

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

        /// --- CONTINUE WITH EMAIL
        MainButton(
          verse: const Verse(
            id: 'phid_continueEmail',
            translate: true,
          ),
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

        /// SOCIAL AUTH BUTTONS
        SizedBox(
          width:  MainButton.getButtonWidth(stretched: false),
          height: SocialAuthButton.standardSize,
          child: Row(
            children: <Widget>[
              ...List.generate(methods.length, (index) {
                return SocialAuthButton(
                  signInMethod: methods[index],
                  socialKeys: BldrsKeys.socialKeys,
                  onSuccess: (AuthModel authModel) => authBySocialMedia(
                    authModel: authModel,
                  ),
                  onError: (String error) => AuthProtocols.onAuthError(
                    error: error,
                  ),
                  onAuthLoadingChanged: (bool loading){
                    blog('is loading : $loading');
                  },
                  manualAuthing: DeviceChecker.deviceIsAndroid(),
                );
              }),
            ],
          ),
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
