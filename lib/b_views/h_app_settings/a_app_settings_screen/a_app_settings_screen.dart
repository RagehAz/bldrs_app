import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/create_new_bz_button.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class AppSettingsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppSettingsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _userIsOnline = Authing.userHasID();

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
          onTap: () => onChangeAppLanguageTap(),
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
          onTap: () => onFeedbackTap(),
        ),

        /// TERMS AND REGULATIONS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_termsRegulations',
            translate: true,
          ),
          icon: Iconz.terms,
          onTap: () => onTermsAndTap(),
        ),

        /// INVITE FRIENDS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_inviteFriends',
            translate: true,
          ),
          icon: Iconizer.shareAppIcon(),
          onTap: () => onInviteFriendsTap(),
        ),

        const DotSeparator(),

        /// CREATE NEW BZ ACCOUNT BUTTON
        const CreateNewBzButton(),

        const DotSeparator(),

        /// REBOOT
        SettingsWideButton(
          verse: const Verse(id: 'phid_clean_and_restart', translate: true),
          icon: Iconz.reload,
          onTap: () => onRebootSystem(),
        ),

        /// SIGN OUT
        SettingsWideButton(
          verse: const Verse(id: 'phid_signOut', translate: true),
          icon: Iconz.exit,
          isOn: _userIsOnline,
          onTap: () => onSignOut(),
        ),

        const DotSeparator(
          color: Colorz.yellow80,
        ),

        BldrsText(
          verse: Verse.plain(BLDRS_APP_VERSION),
          size: 1,
          italic: true,
          color: Colorz.white125,
          weight: VerseWeight.thin,
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
