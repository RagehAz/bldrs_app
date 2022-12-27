import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppSettingsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _userIsOnline = AuthModel.userIsSignedIn();

    return FloatingLayout(
        columnChildren: <Widget>[

          const DotSeparator(color: Colorz.yellow80,),

          /// CHANGE LANGUAGE
          SettingsWideButton(
            verse: const Verse(text: 'phid_changeLanguage', translate: true,),
            onTap: () => onChangeAppLanguageTap(context),
            icon: Iconz.language,
          ),

          const DotSeparator(),

          /// ABOUT
          SettingsWideButton(
            verse: const Verse(text: 'phid_about_bldrsnet', translate: true),
            onTap: () => onAboutBldrsTap(context),
            icon: Iconz.bldrsNameSquare,
          ),

          /// FEEDBACK
          SettingsWideButton(
            verse: const Verse(text: 'phid_feedback', translate: true),
            icon: Iconz.balloonThinking,
            isOn : _userIsOnline,
            onTap: () => onFeedbackTap(context),
          ),

          /// TERMS AND REGULATIONS
          SettingsWideButton(
            verse: const Verse(text: 'phid_termsRegulations', translate: true,),
            icon: Iconz.terms,
            onTap: () => onTermsAndRegulationsTap(context),
          ),

          /// INVITE FRIENDS
          SettingsWideButton(
            verse: const Verse(text: 'phid_inviteFriends', translate: true,),
            icon: Iconizer.shareAppIcon(),
            onTap: () => onInviteFriendsTap(context),
          ),

          const DotSeparator(),

          /// ADD NEW BZ
          SettingsWideButton(
            verse: const Verse(text: 'phid_createBzAccount', translate: true),
            icon: Iconz.bz,
            isOn : _userIsOnline,
            onTap: () => onCreateNewBzTap(context),
          ),

            const DotSeparator(),

          /// SIGN OUT
          SettingsWideButton(
            verse: const Verse(text: 'phid_signOut', translate: true),
            icon: Iconz.exit,
            isOn: _userIsOnline,
            onTap: () => onSignOut(context),
          ),

          const DotSeparator(color: Colorz.yellow80,),

        ],
    );

  }
// -----------------------------------------------------------------------------
}
