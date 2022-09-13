import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/a_modules/m_ui_manager/d_balloon_types_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/m_ui_manager/c_emoji_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/m_ui_manager/b_bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
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

        WideButton(
          verse: Verse.plain('Bldrs icons'),
          icon: Iconz.dvGouran,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const IconsViewerScreen(),
            );

          },
        ),

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

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
