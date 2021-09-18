import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/screens/a_starters/a_4_loading_screen.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class ScreensManager extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'Screens Manager',
        loading: false,
        listWidgets: <Widget>[

          WideButton(
            verse: 'Loading screen',
            onTap: () async {
              await Nav.goToNewScreen(context, LoadingScreen());
            },
          )

        ],
    );
  }
}
