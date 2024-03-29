import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/buttons/store_button.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/x_app_settings_controllers.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/i_gt_insta_screen/gt_insta_screen.dart';
import 'package:bldrs/i_gt_insta_screen/src/protocols/gt_insta_ops.dart';
import 'package:bldrs/super_dev_test.dart';
import 'package:bldrs/z_components/buttons/bz_buttons/create_new_bz_button.dart';
import 'package:bldrs/z_components/buttons/general_buttons/settings_wide_button.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zzzzz_videos_test_lab/video_editor_test_lab.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSettingsPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AppSettingsPage({
    super.key
  });
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    final bool _userIsSignedUp = Authing.userIsSignedUp(_userModel?.signInMethod);
    // --------------------
    return FloatingLayout(
      canSwipeBack: false,
      appBarType: AppBarType.non,
      pyramidButtons: UsersProvider.userIsRage7() == false ? null : <Widget>[

        /// VIDEOS
        PyramidFloatingButton(
          icon: Icons.video_library_outlined,
          toolTip: Verse.plain('Video Editor Test Lab'),
          color: Colorz.white20,
          onTap: () => BldrsNav.goToNewScreen(screen: const VideoEditorTestLab(),),

        ),

        /// GT-INSTA
        PyramidFloatingButton(
          icon: Iconz.gtInsta,
          iconSizeFactor: 0.9,
          toolTip: Verse.plain('GT-Insta'),
          color: Colorz.white20,
          corners: 5,
          onLongTap: () => BldrsNav.goToNewScreen(
              screen: const GtInstaScreen(),
          ),
          onTap: () => GtInstaOps.goGetToken(),
        ),

        /// SUPER DEV TEST
        PyramidFloatingButton(
          icon: Iconz.sexyStar,
          color: Colorz.white20,
          toolTip: Verse.plain('Super Dev Test'),
          onTap: () async {

            await superDevTestGoX();

          },
        ),

      ],
      pyramidType: PyramidType.non,
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
          onTap: () => onRebootBldrsAppSystem(hardReboot: false),
          onLongTap: () => onRebootBldrsAppSystem(hardReboot: true),
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
                                approxChildWidth: _buttonWidth,
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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
