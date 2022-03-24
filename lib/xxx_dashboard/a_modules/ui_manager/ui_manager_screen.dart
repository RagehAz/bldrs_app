import 'package:bldrs/xxx_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/a_modules/ui_manager/emoji_test_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ui_manager/icons_viewer_screen.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class UIManager extends StatelessWidget {
  const UIManager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'UI Manager',
      listWidgets: <Widget>[
        WideButton(
          verse: 'Bldrs icons',
          icon: Iconz.dvGouran,
          onTap: () async {
            await Nav.goToNewScreen(context, const IconsViewerScreen());
          },
        ),
        WideButton(
          verse: 'Emojis',
          icon: Iconz.emoji,
          onTap: () async {
            await Nav.goToNewScreen(context, const EmojiTestScreen());
          },
        ),
      ],
    );
  }
}
