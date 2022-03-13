import 'dart:developer';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// ----------------------------------------------------------------------------
User superFirebaseUser() {
  final User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
/// ----------------------------------------------------------------------------
String superUserID() {
  final String userID = superFirebaseUser()?.uid;
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
      authBy: AuthType.emailSignIn,
    );

    /// create a new firestore document for the user with the userID
    _authModel.userModel = await UserFireOps.createUser(
      context: context,
      userModel: _initialUserModel,
      authBy: AuthType.emailSignIn,
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

        _authModel.firebaseAuth = FirebaseAuth?.instance;

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
              .signInWithCredential(_authModel.authCredential);

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
      authBy: AuthType.facebook,
    );

  }

  return _authModel;
}
// -----------------------------------------------------------------------------
/// returns error string or AuthModel
Future<AuthModel> signInByGoogle({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {

  final AuthModel _authModel = AuthModel();

  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return google auth
  _authModel.authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByGoogle',
      functions: () async {

        _authModel.firebaseAuth = FirebaseAuth?.instance;

        /// A - if on web
        if (kIsWeb) {

          /// B - get [auth provider]
          _authModel.googleAuthProvider = GoogleAuthProvider();

          /// C - get [user credential] from [auth provider]
          _authModel.userCredential = await _authModel
              .firebaseAuth
              .signInWithPopup(_authModel.googleAuthProvider);

        }

        /// A - if kIsWeb != true : so its android or ios
        else {

          /// google sign in instance
          _authModel.googleSignIn = GoogleSignIn();

          /// B - get [google sign in account]
          _authModel.googleSignInAccount = await _authModel
              .googleSignIn
              .signIn();

          if (_authModel.googleSignInAccount != null) {

            /// B - get [google sign in auth] from [google sign in account]
            _authModel.googleSignInAuthentication = await _authModel
                .googleSignInAccount
                .authentication;

            /// B - get [auth credential] from [google sign in auth]
            _authModel.authCredential = GoogleAuthProvider.credential(
              accessToken: _authModel.googleSignInAuthentication.accessToken,
              idToken: _authModel.googleSignInAuthentication.idToken,
            );

            /// C - get [user credential] from [auth credential]
            _authModel.userCredential = await _authModel
                .firebaseAuth
                .signInWithCredential(_authModel.authCredential);

          }

        }

        },
      onError: (String error) async {
        _authModel.authError = error;
      }
      );

  /// GET USER MODEL IF AUTH SUCCEEDS
  if (_authModel.authSucceeds == true) {

    /// E - get Or Create UserModel From User
    _authModel.userModel = await UserFireOps.getOrCreateUserModelFromUser(
      context: context,
      zone: currentZone,
      user: _authModel.userCredential.user,
      authBy: AuthType.google,
    );

  }

  _authModel.blogAuthModel(methodName: 'signInByGoogle');

  return _authModel;
}
// -----------------------------------------------------------------------------
Future<AuthModel> signInByApple({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {

  final AuthModel _authModel = AuthModel();

  blog('starting apple auth ops');


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
// -----------------------------------------------------------------------------
/// google sign out
Future<bool> googleSignOutOps(BuildContext context) async {

  bool _isSignedIn = true;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  blog('googleSignOutOps : currentUser was : ${googleSignIn.currentUser}');

  await tryAndCatch(
      context: context,
      methodName: 'googleSignOutOps',
      functions: () async {
        if (!kIsWeb) {
          await googleSignIn.signOut();
        }

        await FirebaseAuth.instance.signOut();

        _isSignedIn = false;
      },
      onError: (String error) {
        log(error);

        _isSignedIn = true;
      });

  blog('googleSignOutOps : currentUser is : ${googleSignIn.currentUser}');

  return _isSignedIn;
}
// -----------------------------------------------------------------------------
Future<void> signOut({
  @required BuildContext context,
  @required bool routeToUserChecker,
}) async {

  blog('Signing out');
  await googleSignOutOps(context);
  await emailSignOutOps(context);
  // Nav.goToRoute(context, Routez.Starting);

  if (routeToUserChecker == true) {
    await Nav.pushNamedAndRemoveAllBelow(context, Routez.logoScreen);
  }
}
// -----------------------------------------------------------------------------
