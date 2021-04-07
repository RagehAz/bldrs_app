import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class BtSkipAuth extends StatefulWidget {
  final Zone currentZone;

  BtSkipAuth({
    @required this.currentZone,
});

  @override
  _BtSkipAuthState createState() => _BtSkipAuthState();
}

class _BtSkipAuthState extends State<BtSkipAuth> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: 40,
      // width: 70,
      verse: Wordz.skip(context),
      iconSizeFactor: 0.6,
      bubble: true,
      boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
      boxFunction: () async {
        dynamic result = await _auth.signInAnon(context, widget.currentZone);
        if (result == null){
          print('Couldn\'t sign in');
          Nav.goToRoute(context, Routez.Home);
        }
        else {
          print('Signed in successfully');
          print(result);
          Nav.goToRoute(context, Routez.Home);
        }
      },
    );
  }
}
