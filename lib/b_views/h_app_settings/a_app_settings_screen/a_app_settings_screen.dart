import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/widgets/buttons/stores_buttons/store_button.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/create_new_bz_button.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/super_dev_test.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSettingsScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AppSettingsScreen({
    super.key
  });
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    DynamicRouter.blogGo('AppSettingsScreen');
    // --------------------
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final bool _userIsSignedUp = Authing.userIsSignedUp(_userModel?.signInMethod);
    // --------------------
    return FloatingLayout(
      pyramidButtons: UsersProvider.userIsRage7() == false ? null : <Widget>[

        /// SUPER DEV TEST
        PyramidFloatingButton(
          icon: Iconz.star,
          color: Colorz.yellow200,
          toolTip: Verse.plain('Super Dev Test'),
          onTap: () async {

            await superDevTestGoX();

          },
        ),

        /// LAUNCH APP STORE
        PyramidFloatingButton(
          toolTip: Verse.plain('Launch App Store'),
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
          toolTip: Verse.plain('Send Local Noot'),
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
          toolTip: Verse.plain('Send Global Noot'),
          color: Colorz.blue80,
          onTap: () => pushFastNote(
            userID: BldrsKeys.ragehID,
            title: 'Hey you',
            body: 'How are you ?',
          ),
        ),

        /// GLOBAL NOOT
        PyramidFloatingButton(
          icon: Iconz.contNorthAmerica,
          toolTip: Verse.plain('Send Global Noot'),
          color: Colorz.blue80,
          onTap: () => pushFastNote(
            userID: BldrsKeys.ragehID,
            title: 'Hey you',
            body: 'How are you ?',
          ),
        ),

        /// TEMP_DASH_BOARD_FOR_WEB_TESTING
        // PyramidFloatingButton(
        //   icon: Iconz.bldrsNameSquare,
        //   toolTip: Verse.plain('Go to Dashboard'),
        //   color: Colorz.blue80,
        //   onTap: () => Nav.goToNewScreen(
        //       context: context,
        //       screen: const BldrsDashBoardApp(),
        //   ),
        // ),


      ],
      columnChildren: <Widget>[

        /// ------> SEPARATOR
        const DotSeparator(color: Colorz.yellow80),

        /// SETTINGS BUTTONS
        const SettingsToSettingsButtons(),

        /// SIGN IN BY OTHER ACCOUNT
        SettingsWideButton(
          verse: const Verse(id: 'phid_sign_in_other_account', translate: true),
          icon: Iconz.normalUser,
          isOn: _userIsSignedUp,
          onTap: () => signInByAnotherAccount(),
        ),

        /// ------> SEPARATOR
        const DotSeparator(),

        /// CREATE NEW BZ ACCOUNT BUTTON
        const CreateNewBzButton(),

        const Spacing(size: 5,),

        /// ------> SEPARATOR
        const DotSeparator(),

        /// FEEDBACK
        SettingsWideButton(
          verse: const Verse(id: 'phid_feedback', translate: true),
          icon: Iconz.balloonThinking,
          isOn: _userIsSignedUp,
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

        /// ------> SEPARATOR
        const DotSeparator(),

        /// CHANGE LANGUAGE
        SettingsWideButton(
          verse: const Verse(
            id: 'Language . اللغة . Idioma . Lingua . Sprache . Langue . 语言',
            translate: false,
          ),
          onTap: () => onChangeAppLanguageTap(),
          icon: Iconz.language,
        ),

        /// REBOOT
        SettingsWideButton(
          verse: const Verse(id: 'phid_clean_and_restart', translate: true),
          icon: Iconz.reload,
          onTap: () => onRebootBldrsAppSystem(),
        ),

        /// ------> SEPARATOR
        const DotSeparator(
          color: Colorz.yellow80,
        ),

        /// APP VERSION
        AppVersionBuilder(
            versionShouldBe: null,
            builder: (_, bool shouldUpdate, String version) {

              return BldrsText(
                verse: Verse.plain(version),
                size: 1,
                italic: true,
                color: Colorz.white125,
                weight: VerseWeight.thin,
              );

            }),

        /// UPDATE APP BUTTON
        if (DeviceChecker.deviceIsSmartPhone() == true)
        Selector<GeneralProvider, AppStateModel?>(
            selector: (_, GeneralProvider pro) => pro.globalAppState,
            builder: (_, AppStateModel? globalState, Widget? child) {

              return AppVersionBuilder(
                  versionShouldBe: globalState?.appVersion,
                  builder: (_, bool shouldUpdate, String version) {

                    if (shouldUpdate == true){

                      final double _buttonWidth = StoreButton.getWidth(
                        context: context,
                        heightOverride: SettingsWideButton.height,
                      );

                      return SizedBox(
                        width: _buttonWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            /// STORE BUTTON
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: RedDotBadge(
                                childWidth: _buttonWidth,
                                redDotIsOn: true,
                                verse: const Verse(
                                  id: 'phid_update',
                                  translate: true,
                                ),
                                shrinkChild: true,
                                child: StoreButton(
                                  storeType: StoreButton.getStoreType(),
                                  height: SettingsWideButton.height,
                                  onTap: () => Launcher.launchBldrsAppLinkOnStore(),
                                ),
                              ),
                            ),

                            /// NOTICE
                            BldrsText(
                              verse: const Verse(
                                id: 'phid_update_to_new_version_now',
                                translate: true,
                              ),
                              color: Colorz.red255,
                              width: _buttonWidth,
                              size: 1,
                              italic: true,
                              weight: VerseWeight.thin,
                              centered: false,
                              maxLines: 3,
                              textDirection: UiProvider.getAppTextDir(),
                              appIsLTR: UiProvider.checkAppIsLeftToRight(),
                            ),

                            /// NEW VERSION NUMBER
                            BldrsText(
                              verse: Verse(
                                id: globalState?.appVersion,
                                translate: false,
                              ),
                              color: Colorz.red255,
                              width: _buttonWidth,
                              size: 1,
                              italic: true,
                              weight: VerseWeight.thin,
                              centered: false,
                              textDirection: UiProvider.getAppTextDir(),
                              appIsLTR: UiProvider.checkAppIsLeftToRight(),
                            ),

                          ],
                        ),
                      );
                    }

                    else {
                      return const SizedBox();
                    }

                  });
            }
            ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
