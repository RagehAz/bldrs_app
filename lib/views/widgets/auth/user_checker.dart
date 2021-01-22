import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s01_sc_starting_screen.dart';
import 'package:bldrs/views/screens/s10_sc_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvided = Provider.of<UserModel>(context);
    print('user id : ${userProvided?.userID}');

    return
      userProvided == null ?
      StartingScreen()
          :
      HomeScreen();
  }
}
