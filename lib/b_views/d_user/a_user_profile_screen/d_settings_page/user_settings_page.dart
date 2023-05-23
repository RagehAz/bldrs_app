import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class UserSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsFloatingList(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        // /// INVITE BZZ
        // SettingsWideButton(
        //   verse: const Verse(
        //     text: 'phid_invite_bzz_you_know',
        //     translate: true,
        //   ),
        //   icon: Iconz.bz,
        //   color: Colorz.yellow255,
        //   verseColor: Colorz.black255,
        //   iconColor: Colorz.black255,
        //   onTap: () => onInviteBusinessesTap(context),
        // ),
        //
        // const DotSeparator(),

        /// EDIT PROFILE
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_editProfile',
            translate: true,
          ),
          icon: Iconz.gears,
          onTap: () => onEditProfileTap(context),
        ),

        /// EDIT FCM TOPICS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_notifications_settings',
            translate: true,
          ),
          icon: Iconz.notification,
          onTap: () => onGoToFCMTopicsScreen(context),
        ),

        /// DELETE MY ACCOUNT
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_delete_my_account',
            translate: true,
          ),
          icon: Iconz.xSmall,
          color: Colorz.bloodTest,
          onTap: () => onDeleteMyAccount(context),
        ),

        const DotSeparator(),

        /// SIGN OUT
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_signOut',
            translate: true,
          ),
          icon: Iconz.exit,
          onTap: () => onSignOut(context),
        ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}