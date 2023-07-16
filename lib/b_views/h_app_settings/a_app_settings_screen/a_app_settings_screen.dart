import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/create_new_bz_button.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppSettingsScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final bool _userIsOnline = Authing.userIsSignedUp(_userModel?.signInMethod);

    return FloatingLayout(
      pyramidButtons: UsersProvider.userIsRage7() == false ? null : [

        // /// TEST
        // PyramidFloatingButton(
        //   icon: Iconz.lab,
        //   color: Colorz.red255,
        //   onTap: () async {
        //
        //     /// READ CHAINS TEST
        //     // final Map<String, dynamic> map = await Real.readPath(
        //     //     path: 'bldrsChains',
        //     // );
        //     //
        //     // blog('{');
        //     // for (final String key in map.keys.toList()){
        //     //
        //     //   blog('"$key": "${map[key]}",');
        //     //
        //     // }
        //     // blog('}');
        //
        //     // UiProvider.proSetLoadingVerse(
        //     //   verse: const Verse(id: 'phid_loading', translate: true),
        //     // );
        //     //
        //     // /// LOADING SCREEN TEST
        //     // await BldrsNav.goToLogoScreenAndRemoveAllBelow(
        //     //     animatedLogoScreen: true,
        //     // );
        //
        //     // UiProvider.proSetLoadingVerse(verse: Verse.plain(null));
        //
        //   },
        // ),

        /// LAUNCH APP STORE
        PyramidFloatingButton(
          icon: DeviceChecker.deviceIsIOS() ? Iconz.comApple
              :
          DeviceChecker.deviceIsAndroid() ? Iconz.comGooglePlay
              :
          Iconz.comWebsite,
          color: Colorz.blue80,
          onTap: () async {

            await Launcher.launchBldrsAppLinkOnStore();

          },
        ),

        /// LOCAL NOOT
        PyramidFloatingButton(
          icon: Iconz.notification,
          color: Colorz.blue80,
          onTap: () async {

            final bool _go = await Dialogs.confirmProceed(
              titleVerse: Verse.plain('Send Local Noot ?'),
            );

            if (_go == true){

              await FCM.pushGlobalNoot(
                title: 'This is a Notification',
                body: 'Test body',
                channelModel: ChannelModel.bldrsChannel,
                largeIconURL: Standards.bldrsAppIconURL,
                posterURL: Standards.bldrsNamePosterPicURL,
                payloadMap: {},
              );

            }


          },
        ),

        /// GLOBAL NOOT
        PyramidFloatingButton(
          icon: Iconz.contNorthAmerica,
          color: Colorz.blue80,
          onTap: () => pushFastNote(
            userID: BldrsKeys.ragehID,
            title: 'Hey you',
            body: 'How are you ?',
          ),
        ),


      ],
      columnChildren: <Widget>[

        const SettingsToSettingsButtons(),

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
          onTap: () => onRebootBldrsAppSystem(),
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

        AppVersionBuilder(
          builder: (context, String version) {
            return BldrsText(
              verse: Verse.plain(version),
              size: 1,
              italic: true,
              color: Colorz.white125,
              weight: VerseWeight.thin,
            );
          }
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
