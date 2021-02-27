import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class BtSkipAuth extends StatefulWidget {

  @override
  _BtSkipAuthState createState() => _BtSkipAuthState();
}

class _BtSkipAuthState extends State<BtSkipAuth> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 5,
      child: DreamBox(
        height: 40,
        // width: 70,
        verse: Wordz.skip(context),
        iconSizeFactor: 0.6,
        bubble: true,
        boxFunction: () async {
          dynamic result = await _auth.signInAnon(context);
          if (result == null){
            print('Couldn\'t sign in');
            goToRoute(context, Routez.Home);
          }
          else {
            print('Signed in successfully');
            print(result);
            goToRoute(context, Routez.Home);
          }
        },
      ),
    );
  }
}
