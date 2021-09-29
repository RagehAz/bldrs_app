import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/emoji_test.dart';
import 'package:bldrs/dashboard/screens_manager.dart';
import 'package:bldrs/dashboard/ui_manager/icons_viewer.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class UIManager extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'UI Manager',
      loading: false,
      listWidgets: <Widget>[

        WideButton(
          verse: 'Bldrs icons',
          icon: Iconz.DvGouran,
          onTap: () async {
            await Nav.goToNewScreen(context, BldrsIconsViewer());
          },
        ),

        WideButton(
          verse: 'Screens Manager',
          icon: Iconz.MobilePhone,
          onTap: () async {
            await Nav.goToNewScreen(context, ScreensManager());
          },
        ),

        WideButton(
          verse: 'Emojis',
          icon: Iconz.Emoji,
          onTap: () async {
            await Nav.goToNewScreen(context, EmojiTest());
          },
        ),



      ],
    );
  }
}
