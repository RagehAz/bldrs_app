import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/screens/a_starters/a_4_loading_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class ScreensManagerScreen extends StatelessWidget {

  const ScreensManagerScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'Screens Manager',
        listWidgets: <Widget>[

          WideButton(
            verse: 'Loading screen',
            onTap: () async {
              await Nav.goToNewScreen(context, const LoadingScreen());
            },
          )

        ],
    );
  }
}
