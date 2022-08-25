import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';

class IsSignedInButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const IsSignedInButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  bool _isSignedInCheck() {
    bool _isSignedIn;

    final User _firebaseUser = AuthFireOps.superFirebaseUser();

    if (_firebaseUser == null) {
      _isSignedIn = false;
    } else {
      _isSignedIn = true;
    }

    return _isSignedIn;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSignedIn = _isSignedInCheck();

    return DreamBox(
      height: Ratioz.appBarButtonSize,
      verse: _isSignedIn ? 'Signed in' : 'Signed out',
      color: _isSignedIn ? Colorz.green255 : Colorz.grey80,
      verseScaleFactor: 0.6,
      verseColor: _isSignedIn ? Colorz.white255 : Colorz.darkGrey255,
      bubble: false,
      onTap: () async {

        final bool _result = await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: 'Sign out ?',
          boolDialog: true,
          confirmButtonVerse: 'Yes!\nSign out',
        );

        if (_result == true){

          await AuthFireOps.signOut(
              context: context,
              routeToLogoScreen: true
          );

        }


      },
    );

  }

}
