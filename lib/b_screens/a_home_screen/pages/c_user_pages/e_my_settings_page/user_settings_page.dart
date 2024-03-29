import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/b_screens/b_user_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/x_app_settings_controllers.dart';
import 'package:bldrs/z_components/buttons/general_buttons/settings_wide_button.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserSettingsPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsFloatingList(
      hasMargins: false,
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
          onTap: () => onEditProfileTap(
            initialTab: UserEditorTab.pic,
          ),
        ),

        /// EDIT FCM TOPICS
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_notifications_settings',
            translate: true,
          ),
          icon: Iconz.notification,
          onTap: () => onGoToFCMTopicsScreen(),
        ),

        /// DELETE MY ACCOUNT
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_delete_my_account',
            translate: true,
          ),
          icon: Iconz.xSmall,
          color: Colorz.bloodTest,
          onTap: () => onDeleteMyAccount(),
        ),

        const DotSeparator(),

        /// SIGN OUT
        SettingsWideButton(
          verse: const Verse(
            id: 'phid_signOut',
            translate: true,
          ),
          icon: Iconz.exit,
          onTap: () => onSignOutUser(
            showConfirmDialog: true,
          ),
        ),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
