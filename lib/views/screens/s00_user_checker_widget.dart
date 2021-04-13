import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s01_starting_screen.dart';
import 'package:bldrs/views/screens/s10_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : if appNeedsUpdate = true ? goTO(AppStore) : check the user as you wish
/// and we get this value from database and to be controlled from dashboard
class UserChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userProvided = Provider.of<UserModel>(context);
    // print('user id : ${_userProvided?.userID}');

    return
      _userProvided?.userID == null ?
      StartingScreen()
          :
      HomeScreen();
  }
}
