import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/a5_user_settings_controllers.dart';
import 'package:bldrs/c_controllers/i_app_settings_controllers/app_settings_controllers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FloatingCenteredList(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        /// INVITE BZZ
        SettingsWideButton(
          verse: '##Invite Businesses you know',
          icon: Iconz.bz,
          color: Colorz.yellow255,
          verseColor: Colorz.black255,
          iconColor: Colorz.black255,
          onTap: () => onInviteBusinessesTap(context),
        ),

        const DotSeparator(),

        /// EDIT PROFILE
        SettingsWideButton(
          verse: 'phid_editProfile',
          icon: Iconz.gears,
          onTap: () => onEditProfileTap(context),
        ),

        /// DELETE MY ACCOUNT
        SettingsWideButton(
          verse: 'phid_delete_my_account',
          icon: Iconz.xSmall,
          color: Colorz.bloodTest,
          onTap: () => onDeleteMyAccount(context),
        ),

        const DotSeparator(),

        /// SIGN OUT
        SettingsWideButton(
          verse: 'phid_signOut',
          icon: Iconz.exit,
          onTap: () => onSignOut(context),
        ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );

  }
}
