import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s01_starting_screen.dart';
import 'package:bldrs/views/screens/s03_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : if appNeedsUpdate = true ? goTO(AppStore) : check the user as you wish
/// and we get this value from database and to be controlled from dashboard
class UserChecker extends StatelessWidget {

  void _exitApp(BuildContext context){
    Nav.goBack(context);
  }

  @override
  Widget build(BuildContext context) {

    final _userProvided = Provider.of<UserModel>(context);

    return
      _userProvided?.userID == null ?
      WillPopScope(
        onWillPop: () => Future.value(true),
        child: StartingScreen(
          // exitApp: () =>_exitApp(context),
        ),
      )
          :
      LoadingScreen();
  }
}
