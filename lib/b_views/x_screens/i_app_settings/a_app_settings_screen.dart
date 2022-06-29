import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/a_user_screen_controllers.dart';
import 'package:bldrs/c_controllers/i_app_settings_controllers/app_settings_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
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
            verse: superPhrase(context, 'phid_changeLanguage'),
            onTap: () => onChangeAppLanguageTap(context),
            icon: Iconz.language,
          ),

          const DotSeparator(),

          /// ABOUT
          SettingsWideButton(
            verse: '${superPhrase(context, 'phid_about')} ${Wordz.bldrsFullName(context)}',
            onTap: () => onAboutBldrsTap(context),
            icon: Iconz.language,
          ),

          /// FEEDBACK
          SettingsWideButton(
            verse: superPhrase(context, 'phid_feedback'),
            icon: Iconz.utSearching,
            isOn : _userIsOnline,
            onTap: () => onFeedbackTap(context),
          ),

          /// TERMS AND REGULATIONS
          SettingsWideButton(
            verse: superPhrase(context, 'phid_termsRegulations'),
            icon: Iconz.terms,
            onTap: () => onTermsAndRegulationsTap(context),
          ),

          /// INVITE FRIENDS
          SettingsWideButton(
            verse: superPhrase(context, 'phid_inviteFriends'),
            icon: Iconizer.shareAppIcon(),
            onTap: () => onInviteFriendsTap(context),
          ),

          const DotSeparator(),

          /// ADD NEW BZ
          SettingsWideButton(
            verse: superPhrase(context, 'phid_createBzAccount'),
            icon: Iconz.bz,
            isOn : _userIsOnline,
            onTap: () => onCreateNewBzTap(context),
          ),

            const DotSeparator(),

          /// SIGN OUT
          SettingsWideButton(
            verse: superPhrase(context, 'phid_signOut'),
            icon: Iconz.exit,
            isOn: _userIsOnline,
            onTap: () => onSignOut(context),
          ),

          const DotSeparator(color: Colorz.yellow80,),

        ],
    );

  }
}
