import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class AuthProtocols {
  // -----------------------------------------------------------------------------

  const AuthProtocols();

  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  ///
  static Future<bool> signInBldrsByEmail({
    @required String email,
    @required String password,
  }) async {
    String _authError;

    final AuthModel _authModel = await EmailAuthing.signIn(
      email: email.trim(),
      password: password,
      onError: (String error) {
        _authError = error;
      },
    );

    final bool _success = await composeOrUpdateUser(
      authModel: _authModel,
      authError: _authError,
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// REGISTER

  // --------------------
  ///
  static Future<bool> registerInBldrsByEmail({
    @required String email,
    @required String password,
    // @required ZoneModel currentZone,
  }) async {

    String _authError;

    final AuthModel _authModel = await EmailAuthing.register(
      email: email,
      password: password,
      onError: (String error){
        _authError = error;
      },
    );

    final bool _success = await composeOrUpdateUser(
        authModel: _authModel,
        authError: _authError
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// AFTER AUTH

  // --------------------
  ///
  static Future<bool> composeOrUpdateUser({
    @required AuthModel authModel,
    @required String authError,
  }) async {
    bool _success = false;

    if (authError != null) {
      await onAuthError(
          error: authError
      );
    }

    else if (authModel != null) {

      final UserModel _userModel = await UserFireOps.readUser(
        userID: authModel.id,
      );

      /// NEW USER
      if (_userModel == null){
        _success = await _onNewUser(
          authModel: authModel,
        );
      }

      /// EXISTING USER
      else {
        _success = await _onExistingUser(
          userModel: _userModel,
          authModel: authModel,
        );
      }


    }

    return _success;
  }
  // --------------------
  ///
  static Future<void> onAuthError({
    @required String error,
  }) async {

    final String _errorMessage = error ?? 'Something went wrong, please try again';

    await Dialogs.authErrorDialog(
        result: _errorMessage,
    );

  }
  // --------------------
  ///
  static Future<bool> _onNewUser({
    @required AuthModel authModel,
  }) async {

    final UserModel userModel = await UserProtocols.compose(
      authModel: authModel,
    );

    return userModel != null;
  }
  // --------------------
  ///
  static Future<bool> _onExistingUser({
    @required UserModel userModel,
    @required AuthModel authModel,
  }) async {

    await UserProtocols.updateLocally(
      context: getMainContext(),
      newUser: userModel,
    );

    return true;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  ///
  static Future<void> signOutBldrs({
    @required bool routeToLogoScreen,
  }) async {

    final bool _success = await Authing.signOut(
        onError: (String error) async {
          await CenterDialog.showCenterDialog(
            titleVerse: const Verse(
              id: 'phid_trouble_signing_out',
              translate: true,
            ),
            bodyVerse: Verse(
              id: error,
              translate: false,
            ),
          );
        }
        );

    if (_success == true && routeToLogoScreen == true) {
      await BldrsNav.goBackToLogoScreen(
        animatedLogoScreen: true,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// RAGEH SIGN IN

  // --------------------
  static Future<void> signInAsRage7({
    @required BuildContext context,
  }) async {
    final AuthModel _authModel = await EmailAuthing.signIn(
      email: 'rageh@bldrs.net',
      password: '123456',
      onError: (String error) =>
          AuthProtocols.onAuthError(
            error: error,
          ),
    );

    if (_authModel != null) {
      final Map<String, dynamic> _map = await Fire.readDoc(
        coll: FireColl.users,
        doc: _authModel.id,
      );

      final UserModel _userModel = UserModel.decipherUser(
        map: _map,
        fromJSON: false,
      );

      /// UPDATE LDB USER MODEL
      await UserLDBOps.updateUserModel(_userModel);

      UsersProvider.proSetMyUserModel(
        userModel: _userModel,
        notify: true,
      );
    }
  }
  /// --------------------------------------------------------------------------
}
