import 'package:authing/authing.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/a_email_auth_screen.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
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
import 'package:legalizer/legalizer.dart';

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
          width:  MainButton.getButtonWidth(
            context: context,
            stretched: false,
          ),
          height: SocialAuthButton.standardSize,
          child: Row(
            children: <Widget>[
              ...List.generate(methods.length, (index) {
                return SocialAuthButton(
                  signInMethod: methods[index],
                  socialKeys: BldrsKeys.socialKeys,
                  onSuccess: (AuthModel authModel) => authBySocialMedia(
                    context: context,
                    authModel: authModel,
                    mounted: true,
                  ),
                  onError: (String error) => AuthProtocols.onAuthError(
                    context: context,
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

        /// DISCLAIMER LINE
        LegalDisclaimerLine(
          onPolicyTap: () => onPrivacyTap(context),
          onTermsTap: () => onTermsAndTap(context),
          disclaimerLine: Verse.transBake(context, 'phid_by_using_bldrs_you_agree_to_our'),
          andLine: Verse.transBake(context, 'phid_and'),
          policyLine: Verse.transBake(context, 'phid_privacy_policy'),
          termsLine: Verse.transBake(context, 'phid_terms_of_service'),
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
