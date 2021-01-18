import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s02_starting_screen.dart';
import 'package:bldrs/views/screens/s11_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvided = Provider.of<UserModel>(context);
    print('user id : ${userProvided?.iD}');

    if (userProvided == null) { return StartingScreen(); }
    else
      { return HomeScreen(); }
  }
}
