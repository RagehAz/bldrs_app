import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/animations_lab.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/d_balloon_types_screen.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/images_test_screen.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/super_rage7.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/c_emoji_test_screen.dart';
import 'package:bldrs/x_dashboard/m_ui_manager/b_bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class UIManager extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UIManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'UI Manager',
      listWidgets: <Widget>[

        const Stratosphere(),

        /// BLDRS ICONS
        WideButton(
          verse: Verse.plain('Bldrs icons'),
          icon: Iconz.dvGouran,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const BldrsIconsScreen(),
            );

          },
        ),

        /// EMOJIS
        WideButton(
          verse: Verse.plain('Emojis'),
          icon: Iconz.emoji,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const EmojiTestScreen(),
            );

          },
        ),

        /// BALLOON TYPES
        WideButton(
          verse: Verse.plain('Balloons'),
          icon: Iconz.utSelling,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const BalloonTypesScreen(),
            );

          },
        ),

        /// SUPER RAGE7
        WideButton(
          verse: Verse.plain('Super Rage7'),
          icon: Iconz.dvRageh,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SuperRage7Screen(),
            );

          },
        ),

        /// ANIMATIONS LAB
        WideButton(
          verse: Verse.plain('Animations Lab'),
          icon: Iconz.dvDonaldDuck,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const AnimationsLab(),
            );

          },
        ),

        /// IMAGE TEST SCREEN
        WideButton(
          verse: Verse.plain('Images testing'),
          icon: Iconz.camera,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const ImagesTestScreen(),
            );

          },
        ),

        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
