import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/connectivity_sensor.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {

  const AppSettingsScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BasicListLayout(
        columnChildren: <Widget>[

          /// CHANGE LANGUAGE
          WideButtonX(
            verse: superPhrase(context, 'phid_changeLanguage'),
            onTap: () => onChangeAppLanguageTap(context),
            icon: Iconz.language,
          ),

          const BubblesSeparator(),

          /// ABOUT
          WideButtonX(
            verse: '${superPhrase(context, 'phid_about')} ${Wordz.bldrsFullName(context)}',
            onTap: () => onAboutBldrsTap(context),
            icon: Iconz.language,
          ),

          /// FEEDBACK
          WideButtonX(
            verse: superPhrase(context, 'phid_feedback'),
            icon: Iconz.utSearching,
            onTap: () => onFeedbackTap(context),
          ),

          /// TERMS AND REGULATIONS
          WideButtonX(
            verse: superPhrase(context, 'phid_termsRegulations'),
            icon: Iconz.terms,
            onTap: () => onTermsAndRegulationsTap(context),
          ),

          /// INVITE FRIENDS
          WideButtonX(
            verse: superPhrase(context, 'phid_inviteFriends'),
            icon: Iconizer.shareAppIcon(),
            onTap: () => onInviteFriendsTap(context),
          ),

          const BubblesSeparator(),

          /// ADD NEW BZ
          WideButtonX(
            verse: superPhrase(context, 'phid_createBzAccount'),
            icon: Iconz.bz,
            onTap: () => onCreateNewBzTap(context),
          ),

          if (AuthModel.userIsSignedIn() == true)
            const BubblesSeparator(),

          /// SIGN OUT
          if (AuthModel.userIsSignedIn() == true)
          WideButtonX(
            verse: superPhrase(context, 'phid_signOut'),
            icon: Iconz.exit,
            onTap: () => onSignOut(context),
          ),

        ],
    );

  }
}

class WideButtonX extends StatelessWidget {

  const WideButtonX({
    @required this.verse,
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);

  final String verse;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return DreamBox(
      height: 50,
      verse: verse.toUpperCase(),
      icon: icon,
      width: _screenWidth * 0.7,
      margins: 5,
      iconSizeFactor: 0.5,
      verseCentered: false,
      verseMaxLines: 2,
      verseItalic: true,
      color: Colorz.white20,
      verseScaleFactor: 1.2,
      // size: 4,
      // margin: 5,
      // labelColor: Colorz.white20,
      // italic: true,
      onTap: onTap,
    );

  }
}

class BasicListLayout extends StatelessWidget {

  const BasicListLayout({
    @required this.columnChildren,
    Key key
  }) : super(key: key);

  final List<Widget> columnChildren;

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);

    return SafeArea(
      child: ConnectivitySensor(
        child: Stack(
          children: <Widget>[

            Scaffold(
              key: const ValueKey<String>('mainScaffold'),

              /// INSETS
              resizeToAvoidBottomInset: false, /// this false prevents keyboard from pushing pyramids up
              // resizeToAvoidBottomPadding: false,

              /// BACK GROUND COLOR
              backgroundColor: Colorz.black255,

              /// BODY CONTENT
              body: SizedBox(
                width: _screenWidth,
                height: _screenHeight,
                child: Stack(
                  children: <Widget>[

                    Container(
                      width: _screenWidth,
                      height: _screenHeight,
                      // color: Colorz.bloodTest,
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[

                            ...columnChildren,

                          ],
                        ),
                      ),
                    ),

                    Pyramids(
                        pyramidType: PyramidType.crystalYellow,
                        loading: ValueNotifier(false),
                        onPyramidTap: null
                    ),

                  ],
                ),
              ),

            ),

          ],
        ),
      ),
    );

  }
}
