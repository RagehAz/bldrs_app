import 'package:authing/authing.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:super_image/super_image.dart';

class AppSettingsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppSettingsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _userIsOnline = Authing.userIsSignedIn();

    return FloatingLayout(
      columnChildren: <Widget>[

        const DotSeparator(
          color: Colorz.yellow80,
        ),

        /// CHANGE LANGUAGE
        SettingsWideButton(
          verse: const Verse(
            id: 'Language . اللغة', //'phid_changeLanguage',
            translate: false,
          ),
          onTap: () => onChangeAppLanguageTap(context),
          icon: Iconz.language,
        ),

        const DotSeparator(),

        /// PLAN : ENHANCE - DESIGN - DEVELOP : ABOUT BLDRS SCREEN
        // /// ABOUT
        // SettingsWideButton(
        //   verse: const Verse(text: 'phid_about_bldrsnet', translate: true),
        //   onTap: () => onAboutBldrsTap(context),
        //   icon: Iconz.bldrsNameSquare,
        // ),

        /// FEEDBACK
        SettingsWideButton(
          verse: const Verse(id: 'phid_feedback', translate: true),
          icon: Iconz.balloonThinking,
          isOn: _userIsOnline,
          onTap: () => onFeedbackTap(context),
        ),

        /// TERMS AND REGULATIONS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_termsRegulations',
            translate: true,
          ),
          icon: Iconz.terms,
          onTap: () => onTermsAndTap(context),
        ),

        /// INVITE FRIENDS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_inviteFriends',
            translate: true,
          ),
          icon: Iconizer.shareAppIcon(),
          onTap: () => onInviteFriendsTap(context),
        ),

        const DotSeparator(),

        /// CREATE NEW BZ ACCOUNT BUTTON
        const CreateNewBzButton(),

        const DotSeparator(),

        /// SIGN OUT
        SettingsWideButton(
          verse: const Verse(id: 'phid_signOut', translate: true),
          icon: Iconz.exit,
          isOn: _userIsOnline,
          onTap: () => onSignOut(context),
        ),

        const DotSeparator(
          color: Colorz.yellow80,
        ),

        BldrsText(
          verse: Verse.plain(bldrsAppVersion),
          size: 0,
          italic: true,
          color: Colorz.white125,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}

class CreateNewBzButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CreateNewBzButton({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _userIsOnline = Authing.userIsSignedIn();

    return SizedBox(
      width: SettingsWideButton.width,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// BACKGROUND GRAPHIC
          const Positioned(
            left: -60,
            top: -(130 / 2) - 30,
            child: SuperImage(
              width: 300,
              height: 300,
              pic: Iconz.bz,
              iconColor: Colorz.yellow20,
            ),
          ),

          /// TEXT
          Positioned(
            top: 0,
            child: Opacity(
              opacity: _userIsOnline == true ? 1 : 0.5,
              child: const BldrsText(
                width: SettingsWideButton.width,
                verse: Verse(
                  id: 'phid_createBzAccount',
                  translate: true,
                  casing: Casing.upperCase,
                ),
                italic: true,
                size: 3,
                maxLines: 2,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                weight: VerseWeight.black,
                shadow: true,
              ),
            ),
          ),

          const Positioned(
            bottom: 0,
            child: BldrsBulletPoints(
              centered: true,
              showBottomLine: false,
              verseSizeFactor: 0.8,
              bulletPoints: <Verse>[

                Verse(id: 'phid_free_account_no_commissions', translate: true),

                // Verse(id: 'phid_no_deal_commissions', translate: true),

                Verse(id: 'phid_account_addons_are_purchasable', translate: true),

              ],
            ),
          ),

          /// TAP LAYER
          BldrsBox(
            width: SettingsWideButton.width,
            height: 130,
            color: Colorz.yellow50,
            isDisabled: !_userIsOnline,
            onTap: () => onCreateNewBzTap(context),
            onDisabledTap: () async {
              await Dialogs.youNeedToBeSignedInDialog(
                context: context,
                afterHomeRouteName: Routing.appSettings,
                afterHomeRouteArgument: null,
              );
            },
          ),
        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
