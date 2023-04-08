import 'package:authing/authing.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IsSignedInButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const IsSignedInButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  bool _isSignedInCheck() {
    bool _isSignedIn;

    final User _firebaseUser = Authing.getFirebaseUser();

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
      verse: Verse(
        id: _isSignedIn ? 'phid_signIn' : 'phid_signOut',
        translate: true,
      ),
      color: _isSignedIn ? Colorz.green255 : Colorz.grey80,
      verseScaleFactor: 0.6,
      verseColor: _isSignedIn ? Colorz.white255 : Colorz.darkGrey255,
      bubble: false,
      onTap: () async {

        final bool _result = await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: const Verse(id: 'phid_sign_out_?', translate: true),
          boolDialog: true,
          confirmButtonVerse: const Verse(id: 'phid_signOut', translate: true),
        );

        if (_result == true){

          await AuthProtocols.signOutBldrs(
              routeToLogoScreen: true
          );

        }


      },
    );

  }

}
