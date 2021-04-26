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

    final UserModel _userProvided = Provider.of<UserModel>(context);
    List<String> _missingFields = UserModel.missingFields(_userProvided);

    return

    /// when the user is null after sign out, or did not auth yet
      _userProvided?.userID == null ?
      WillPopScope(
        onWillPop: () => Future.value(true),
        child: StartingScreen(
          // exitApp: () =>_exitApp(context),
        ),
      )

      //     :
      //
      // /// when user has his account not finished
      // _missingFields.length != 0 ?
      // EditProfileScreen(user: _userProvided, firstTimer: false,)

          :

      /// when user is valid to enter home screen, start loading screen then home
      LoadingScreen();

  }
}
