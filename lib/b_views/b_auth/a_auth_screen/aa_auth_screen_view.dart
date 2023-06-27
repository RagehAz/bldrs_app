import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/a_email_auth_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class AuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthScreenView({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SignInMethod> methods = [
      if (DeviceChecker.deviceIsIOS() == true)
        SignInMethod.apple,
      SignInMethod.google,
      SignInMethod.facebook
    ];

    return FloatingList(
      padding: Stratosphere.stratosphereSandwich,
      columnChildren: <Widget>[

        const LogoSlogan(
          showSlogan: true,
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
          verseShadow: false,
          onTap: () async {

              await Nav.goToNewScreen(
                  context: context,
                  screen: const EmailAuthScreen(),
              );

          },
        ),

        /// SOCIAL AUTH BUTTONS
        /// TASK : FIX_SOCIAL_AUTH_BUTTONS
        // if (AuthProtocols.showSocialAuthButtons == true)
        // SizedBox(
        //   width:  MainButton.getButtonWidth(
        //     context: context,
        //   ),
        //   height: SocialAuthButton.standardSize,
        //   child: Row(
        //     children: <Widget>[
        //
        //       ...List.generate(methods.length, (index) {
        //         return SocialAuthButton(
        //           signInMethod: methods[index],
        //           socialKeys: BldrsKeys.socialKeys,
        //           onSuccess: (AuthModel authModel) => authBySocialMedia(
        //             authModel: authModel,
        //             mounted: true,
        //           ),
        //           onError: (String error) => AuthProtocols.onAuthError(
        //             error: error,
        //           ),
        //           onAuthLoadingChanged: (bool loading){
        //             blog('is loading : $loading');
        //           },
        //           manualAuthing: DeviceChecker.deviceIsAndroid(),
        //         );
        //       }),
        //
        //     ],
        //   ),
        // ),

        /// DISCLAIMER LINE
        LegalDisclaimerLine(
          onPolicyTap: () => onPrivacyTap(),
          onTermsTap: () => onTermsAndTap(),
          disclaimerLine: Verse.transBake('phid_by_using_bldrs_you_agree_to_our')!,
          andLine: Verse.transBake('phid_and')!,
          policyLine: Verse.transBake('phid_privacy_policy')!,
          termsLine: Verse.transBake('phid_terms_of_service')!,
          textDirection: UiProvider.getAppTextDir(),
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
