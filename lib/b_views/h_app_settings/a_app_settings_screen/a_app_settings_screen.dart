import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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

    return CenteredListLayout(
        columnChildren: <Widget>[

          const DotSeparator(color: Colorz.yellow80,),

          /// CHANGE LANGUAGE
          SettingsWideButton(
            verse: 'phid_changeLanguage',
            onTap: () => onChangeAppLanguageTap(context),
            icon: Iconz.language,
          ),

          const DotSeparator(),

          /// ABOUT
          SettingsWideButton(
            verse: 'phid_about_bldrsnet',
            onTap: () => onAboutBldrsTap(context),
            icon: Iconz.bldrsNameSquare,
          ),

          /// FEEDBACK
          SettingsWideButton(
            verse: 'phid_feedback',
            icon: Iconz.utSearching,
            isOn : _userIsOnline,
            onTap: () => onFeedbackTap(context),
          ),

          /// TERMS AND REGULATIONS
          SettingsWideButton(
            verse: 'phid_termsRegulations',
            icon: Iconz.terms,
            onTap: () => onTermsAndRegulationsTap(context),
          ),

          /// INVITE FRIENDS
          SettingsWideButton(
            verse: 'phid_inviteFriends',
            icon: Iconizer.shareAppIcon(),
            onTap: () => onInviteFriendsTap(context),
          ),

          const DotSeparator(),

          /// ADD NEW BZ
          SettingsWideButton(
            verse: 'phid_createBzAccount',
            icon: Iconz.bz,
            isOn : _userIsOnline,
            onTap: () => onCreateNewBzTap(context),
          ),

            const DotSeparator(),

          /// SIGN OUT
          SettingsWideButton(
            verse: 'phid_signOut',
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
