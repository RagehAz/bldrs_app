import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:flutter/material.dart';

class AuthProtocols {
  // -----------------------------------------------------------------------------

  const AuthProtocols();

  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  ///
  static Future<bool> signInBldrsByEmail({
    @required BuildContext context,
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
      context: context,
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
    @required BuildContext context,
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
        context: context,
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
    @required BuildContext context,
    @required AuthModel authModel,
    @required String authError,
  }) async {
    bool _success = false;

    if (authError != null) {
      await onAuthError(
          context: context,
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
          context: context,
          authModel: authModel,
        );
      }

      /// EXISTING USER
      else {
        _success = await _onExistingUser(
          context: context,
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
    @required BuildContext context,
    @required String error,
  }) async {

    final String _errorMessage = error ?? 'Something went wrong, please try again';

    await Dialogs.authErrorDialog(
        context: context,
        result: _errorMessage,
    );

  }
  // --------------------
  ///
  static Future<bool> _onNewUser({
    @required BuildContext context,
    @required AuthModel authModel,
  }) async {

    final UserModel userModel = await UserProtocols.compose(
      context: context,
      authModel: authModel,
    );

    return userModel != null;
  }
  // --------------------
  ///
  static Future<bool> _onExistingUser({
    @required BuildContext context,
    @required UserModel userModel,
    @required AuthModel authModel,
  }) async {

    await UserProtocols.updateLocally(
      context: context,
      newUser: userModel,
    );

    UsersProvider.proSetMyAuthModel(
      context: context,
      authModel: authModel,
      notify: true,
    );

    await AuthLDBOps.insertAuthModel(authModel);

    return true;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  ///
  static Future<void> signOutBldrs({
    @required BuildContext context,
    @required bool routeToLogoScreen,
  }) async {

    final bool _success = await Authing.signOut(
        onError: (String error) async {
          await CenterDialog.showCenterDialog(
            context: context,
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
        context: context,
        animatedLogoScreen: true,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
