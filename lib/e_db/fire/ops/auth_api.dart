import 'dart:developer';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// ----------------------------------------------------------------------------
User getFirebaseUser() {
  final User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
/// ----------------------------------------------------------------------------
String getFirebaseUserID() {
  final String userID = getFirebaseUser()?.uid;
  return userID;
}
// -----------------------------------------------------------------------------

/// DELETE FIREBASE USER

// ---------------------------------------------------
/// TASK : fix this error
/// deleteFirebaseUser : tryAndCatch ERROR : [firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request.
Future<bool> deleteFirebaseUser({
  @required BuildContext context,
  @required String userID,
}) async {

  blog('deleting firebase user');
  // String _error;

  final bool _result = await tryCatchAndReturnBool(
      context: context,
      methodName: 'deleteFirebaseUser',
      functions: () async {

        final FirebaseAuth _auth = FirebaseAuth?.instance;
        await _auth.currentUser.delete();

      },
      onError: (String error) {
        // String _error = error.toString();
      });

  return _result;

  /*
      /// delete firebase user
  // Future<void> _deleteFirebaseUser({
  //   BuildContext context,
  //   String email,
  //   String password,
  // }) async {
  //
  //   try {
  //
  //     User user = _auth.currentUser;
  //
  //     AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
  //
  //     blog(user);
  //
  //     UserCredential result = await user.reauthenticateWithCredential(credentials);
  //
  //     await result.user.delete();
  //
  //     return true;
  //
  //   } catch (error) {
  //
  //     blog(error.toString());
  //
  //     await superDialog(
  //       context: context,
  //       title: 'Could not delete account',
  //       body: error,
  //       boolDialog: false,
  //     );
  //
  //     return null;
  //   }
  // }
// -----------------------------------------------------------------------------
     */
}
// -----------------------------------------------------------------------------

/// AUTHENTICATORS

// ---------------------------------------------------
/// SIGN IN BY EMAIL AND PASSWORD
Future<AuthModel> signInByEmailAndPassword({
  @required BuildContext context,
  @required String email,
  @required String password,
}) async {

  final AuthModel _authModel = AuthModel();

  /// try sign in and check result
  _authModel.authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByEmailAndPassword',
      functions: () async {

        _authModel.firebaseAuth = FirebaseAuth?.instance;

        _authModel.userCredential = await _authModel
            .firebaseAuth
            .signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

      },

      onError: (String error) async {
        _authModel.authError = error;
      }

  );

  /// READ USER MODEL IF AUTH SUCCEEDS
  if (_authModel.authSucceeds == true) {

    /// read user ops
    _authModel.userModel = await UserFireOps.readUser(
        context: context,
        userID: _authModel.userCredential.user.uid,
    );

  }

  _authModel.blogAuthModel(methodName: 'signInByEmailAndPassword');

  return _authModel;
}
// -----------------------------------------------------------------------------
/// REGISTER BY EMAIL AND PASSWORD
Future<AuthModel> registerByEmailAndPassword({
  @required BuildContext context,
  @required ZoneModel currentZone,
  @required String email,
  @required String password,
}) async {

  final AuthModel _authModel = AuthModel();

  /// try register and check result
  _authModel.authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'registerByEmailAndPassword',
      functions: () async {

        _authModel.firebaseAuth = FirebaseAuth?.instance;

        _authModel.userCredential = await _authModel
            .firebaseAuth
            .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

        },
      onError: (String error) async {
        _authModel.authError = error;
      }

      );

  _authModel.blogAuthModel(methodName: 'registerByEmailAndPassword');

  /// CREATE USER MODEL IS AUTH SUCCEEDS
  if (_authModel.authSucceeds == true) {

    final UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
      context: context,
      user: _authModel.userCredential.user,
      zone: currentZone,
      authBy: AuthBy.email,
    );

    /// create a new firestore document for the user with the userID
    _authModel.userModel = await UserFireOps.createUser(
      context: context,
      userModel: _initialUserModel,
      authBy: AuthBy.email,
    );

  }

  return _authModel;
}
// -----------------------------------------------------------------------------
Future<AuthModel> signInByFacebook({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {
  // steps ----------
  /// facebook sign in to get firebase user to check if it has a userModel or to
  /// create a new one
  ///
  /// X1 - try get firebase user or return error
  ///   xx - try catch return google auth on WEB & ANDROID-IOS
  ///       B - get [accessToken]
  ///       C - Create [credential] from the [access token]
  ///       D - get [user credential] by [credential]
  ///       E - get firebase [user] from [user credential]
  ///
  /// X2 - process firebase user to return UserModel or error
  ///   xx - return error : if auth fails
  ///   xx - return firebase user : if auth succeeds
  ///      E - get Or Create UserModel From User
  // ----------

  final AuthModel _authModel = AuthModel();

  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return facebook auth
  _authModel.authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByFacebook',
      functions: () async {

        /// get [accessToken]
        _authModel.facebookLoginResult = await FacebookAuth.instance.login();
        final AccessToken _accessToken = _authModel.facebookLoginResult?.accessToken;

        /// IF COULD LOGIN BY FACEBOOK
        if (_accessToken != null) {

          /// C - Create [credential] from the [access token]
          _authModel.facebookAuthCredential = FacebookAuthProvider
              .credential(_accessToken.token,);


          /// D - get [user credential] by [credential]
          _authModel.userCredential = await _authModel
              .firebaseAuth
              .signInWithCredential(_authModel.facebookAuthCredential);

        }

        /// IF COULD NOT LOGIN AND ACCESS TOKEN == NULL
        else {
          blog('Facebook Access token is null');
        }

      },

      onError: (String error) async {
        _authModel.authError = error;
      }
  );


  /// xx - return firebase user : if auth succeeds
  if (_authModel.authSucceeds == true) {

    /// E - get Or Create UserModel From User
    _authModel.userModel = await UserFireOps.getOrCreateUserModelFromUser(
      context: context,
      zone: currentZone,
      user: _authModel.userCredential.user,
      authBy: AuthBy.facebook,
    );

  }

  return _authModel;
}
// -----------------------------------------------------------------------------

/// sign out

// ---------------------------------------------------
Future<void> emailSignOutOps(BuildContext context) async {

  try {
    final FirebaseAuth _auth = FirebaseAuth?.instance;
    return await _auth.signOut();
  }

  on Exception catch (error) {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Trouble Signing out',
      body: error,
    );
  }

}
