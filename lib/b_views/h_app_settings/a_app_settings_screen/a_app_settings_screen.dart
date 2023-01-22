import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_image/super_image.dart';

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
            verse: const Verse(
              text: 'Language . اللغة', //'phid_changeLanguage',
              translate: false,
            ),
            onTap: () => onChangeAppLanguageTap(context),
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
            verse: const Verse(text: 'phid_feedback', translate: true),
            icon: Iconz.balloonThinking,
            isOn : _userIsOnline,
            onTap: () => onFeedbackTap(context),
          ),

          /// TERMS AND REGULATIONS
          SettingsWideButton(
            verse: const Verse(text: 'phid_termsRegulations', translate: true,),
            icon: Iconz.terms,
            onTap: () => onTermsAndTap(context),
          ),

          // /// INVITE FRIENDS
          // SettingsWideButton(
          //   verse: const Verse(text: 'phid_inviteFriends', translate: true,),
          //   icon: Iconizer.shareAppIcon(),
          //   onTap: () => onInviteFriendsTap(context),
          // ),

          const DotSeparator(),

            /// CREATE NEW BZ ACCOUNT BUTTON
            SizedBox(
              width: SettingsWideButton.width,
              height: 130,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  const Positioned(
                    left: -60,
                    top: -(130 / 2) - 30,
                    child: SuperImage(
                      width: 300,
                      height: 300,
                      pic: Iconz.bz,
                      iconColor: Colorz.yellow20,
                    ),
                  ),

                  Opacity(
                    opacity: _userIsOnline == true ? 1 : 0.5,
                    child: const SuperVerse(
                      verse: Verse(
                          text: 'phid_createBzAccount',
                          translate: true,
                        casing: Casing.upperCase,
                      ),
                      italic: true,
                      size: 3,
                      maxLines: 2,
                      margin: 30,
                      weight: VerseWeight.black,
                      shadow: true,
                    ),
                  ),

                  DreamBox(
                    width: SettingsWideButton.width,
                    height: 130,
                    color: Colorz.yellow50,
                    isDisabled: !_userIsOnline,
                    onTap: () => onCreateNewBzTap(context),
                    onDeactivatedTap: () async {

                      await Dialogs.youNeedToBeSignedInDialog(
                        context: context,
                        afterHomeRouteName: Routing.appSettings,
                        afterHomeRouteArgument: null,
                      );

                    },
                  ),

                ],

              ),
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
