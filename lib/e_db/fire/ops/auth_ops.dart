import 'dart:developer';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFireOps {
// ----------------------------------------------------------------------------

  const AuthFireOps();

// ----------------------------------------------------------------------------
  static User superFirebaseUser() {
  final User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
/// ----------------------------------------------------------------------------
static String superUserID() {
  final String userID = superFirebaseUser()?.uid;
  return userID;
}
// -----------------------------------------------------------------------------

/// DELETE FIREBASE USER

// ---------------------------------------
  static Future<bool> deleteFirebaseUser({
  @required BuildContext context,
  @required String userID,
}) async {

  blog('deleting firebase user');
  // String _error;

  final bool _success = await tryCatchAndReturnBool(
      context: context,
      methodName: 'deleteFirebaseUser',
      functions: () async {

        final FirebaseAuth _auth = FirebaseAuth?.instance;

        await _auth.currentUser.delete();

      },
      onError: (String error) {
        // String _error = error.toString();
      });

  return _success;

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

// ---------------------------------------
/// SIGN IN BY EMAIL AND PASSWORD
  static Future<AuthModel> signInByEmailAndPassword({
  @required BuildContext context,
  @required String email,
  @required String password,
}) async {
  // -----------------------------
  AuthModel _authModel = const AuthModel();
  UserCredential _userCredential;
  String _authError;
  // -----------------------------
  /// try sign in and check result
  final bool _authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByEmailAndPassword',
      functions: () async {

        final FirebaseAuth _firebaseAuth = FirebaseAuth?.instance;

        _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

      },

      onError: (String error) async {
        _authError = error;
      }

  );
  // -----------------------------
  _authModel = AuthModel.create(
    authSucceeds: _authSucceeds,
    authError: _authError,
    userCredential: _userCredential,
  );
  // -----------------------------
  /// READ USER MODEL IF AUTH SUCCEEDS
  if (_authModel.authSucceeds == true) {

    /// read user ops
    final UserModel _userModel = await UserFireOps.readUser(
        context: context,
        userID: _authModel.uid,
    );

    _authModel = _authModel.copyWith(
      userModel: _userModel,
    );

    _authModel.blogAuthModel(methodName: 'signInByEmailAndPassword');
  }
  
  return _authModel;
}
// ---------------------------------------
/// REGISTER BY EMAIL AND PASSWORD
  static Future<AuthModel> registerByEmailAndPassword({
  @required BuildContext context,
  @required ZoneModel currentZone,
  @required String email,
  @required String password,
}) async {
  UserCredential _userCredential;
  String _authError;
  // -----------------------------
  /// try register and check result
  final bool _authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'registerByEmailAndPassword',
      functions: () async {

        final FirebaseAuth _firebaseAuth = FirebaseAuth?.instance;

        _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

        },
      onError: (String error) async {
        _authError = error;
      }

      );
  // -----------------------------
  final AuthModel _authModel = await UserProtocols.composeUser(
    context: context,
    authSucceeds: _authSucceeds,
    userCredential: _userCredential,
    authError: _authError,
    authType: AuthType.emailRegister,
  );
  // -----------------------------
  return _authModel;
}
// ---------------------------------------
  static Future<AuthModel> signInByFacebook({
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
  AuthModel _authModel = const AuthModel();
  LoginResult _facebookLoginResult;
  UserCredential _userCredential;
  String _authError;
  FacebookAuthCredential _facebookAuthCredential;
  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return facebook auth
  final bool _authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByFacebook',
      functions: () async {

        final FirebaseAuth _firebaseAuth = FirebaseAuth?.instance;

        /// get [accessToken]
        _facebookLoginResult = await FacebookAuth.instance.login();
        final AccessToken _accessToken = _facebookLoginResult?.accessToken;

        /// IF COULD LOGIN BY FACEBOOK
        if (_accessToken != null) {

          /// C - Create [credential] from the [access token]
          _facebookAuthCredential = FacebookAuthProvider.credential(_accessToken.token);

          /// D - get [user credential] by [credential]
          _userCredential = await _firebaseAuth.signInWithCredential(_facebookAuthCredential);

        }

        /// IF COULD NOT LOGIN AND ACCESS TOKEN == NULL
        else {
          blog('Facebook Access token is null');
        }

      },

      onError: (String error) async {
        _authError = error;
      }
  );
  // -----------------------------
  _authModel = AuthModel.create(
    authSucceeds: _authSucceeds,
    authError: _authError,
    userCredential: _userCredential,
    facebookLoginResult: _facebookLoginResult,
    facebookAuthCredential: _facebookAuthCredential,

  );
  // -----------------------------
  /// xx - return firebase user : if auth succeeds
  if (_authModel.authSucceeds == true) {

    /// E - get Or Create UserModel From User
    final UserModel _userModel = await UserFireOps.getOrCreateUserModelFromUser(
      context: context,
      zone: currentZone,
      user: _userCredential.user,
      authBy: AuthType.facebook,
    );

    _authModel = _authModel.copyWith(
      userModel: _userModel,
    );

  }

  return _authModel;
}
// ---------------------------------------
/// returns error string or AuthModel
  static Future<AuthModel> signInByGoogle({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {

  AuthModel _authModel = const AuthModel();
  UserCredential _userCredential;
  String _authError;
  GoogleAuthProvider _googleAuthProvider;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _googleSignInAccount;
  GoogleSignInAuthentication _googleSignInAuthentication;
  AuthCredential _authCredential;
  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return google auth
  final bool _authSucceeds = await tryCatchAndReturnBool(
      context: context,
      methodName: 'signInByGoogle',
      functions: () async {

        final FirebaseAuth _firebaseAuth = FirebaseAuth?.instance;

        /// A - if on web
        if (kIsWeb) {

          /// B - get [auth provider]
          _googleAuthProvider = GoogleAuthProvider();

          /// C - get [user credential] from [auth provider]
          _userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);

        }

        /// A - if kIsWeb != true : so its android or ios
        else {

          /// google sign in instance
          _googleSignIn = GoogleSignIn();

          /// B - get [google sign in account]
          _googleSignInAccount = await _googleSignIn.signIn();

          if (_googleSignInAccount != null) {

            /// B - get [google sign in auth] from [google sign in account]
            _googleSignInAuthentication = await _googleSignInAccount.authentication;

            /// B - get [auth credential] from [google sign in auth]
            _authCredential = GoogleAuthProvider.credential(
              accessToken: _googleSignInAuthentication.accessToken,
              idToken: _googleSignInAuthentication.idToken,
            );

            /// C - get [user credential] from [auth credential]
            _userCredential = await _firebaseAuth.signInWithCredential(_authCredential);

          }

        }

        },
      onError: (String error) async {
        _authError = error;
      }
      );
  // -----------------------------
  _authModel = AuthModel.create(
    authSucceeds: _authSucceeds,
    authError: _authError,
    userCredential: _userCredential,
    googleAuthProvider: _googleAuthProvider,
    googleSignIn: _googleSignIn,
    googleSignInAccount: _googleSignInAccount,
    googleSignInAuthentication: _googleSignInAuthentication,
    authCredential: _authCredential,
  );
  // -----------------------------
  /// GET USER MODEL IF AUTH SUCCEEDS
  if (_authModel.authSucceeds == true) {

    /// E - get Or Create UserModel From User
    final UserModel _userModel = await UserFireOps.getOrCreateUserModelFromUser(
      context: context,
      zone: currentZone,
      user: _userCredential.user,
      authBy: AuthType.google,
    );

    _authModel = _authModel.copyWith(
      userModel: _userModel,
    );

  }
  // -----------------------------
  _authModel.blogAuthModel(methodName: 'signInByGoogle');
  // -----------------------------
  return _authModel;
}
// ---------------------------------------
  static Future<AuthModel> signInByApple({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {

  const AuthModel _authModel = AuthModel();

  blog('starting apple auth ops');


  return _authModel;
}
// -----------------------------------------------------------------------------

/// sign out

// ---------------------------------------
  static Future<void> emailSignOutOps(BuildContext context) async {

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
// ---------------------------------------
/// google sign out
  static Future<bool> googleSignOutOps(BuildContext context) async {

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
// ---------------------------------------
  static Future<void> signOut({
  @required BuildContext context,
  @required bool routeToLogoScreen,
}) async {

  blog('Signing out');
  await googleSignOutOps(context);
  await emailSignOutOps(context);
  // Nav.goToRoute(context, Routez.Starting);

  if (routeToLogoScreen == true) {

    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );

  }
}
// -----------------------------------------------------------------------------

/// CHECKERS

// ---------------------------------------
/// TESTED :
static Future<bool> passwordIsCorrect({
  @required BuildContext context,
  @required String password,
  @required String email,
}) async {

  UserCredential _credential;

  final bool _credentialsAreGood = await tryCatchAndReturnBool(
      context: context,
      functions: () async {

        final AuthCredential _authCredential = EmailAuthProvider.credential(
            email: email,
            password: password,
        );

        final FirebaseAuth _auth = FirebaseAuth?.instance;
        _credential = await _auth.currentUser?.reauthenticateWithCredential(_authCredential);

      }
  );

  if (_credentialsAreGood == true && _credential != null){
    return true;
  }
  else {
    return false;
  }

}
// -----------------------------------------------------------------------------

/// UPDATE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> updateUserEmail({
    @required BuildContext context,
    @required String newEmail,
  }) async {
    blog('updateUserEmail : START');

    bool _success = false;

    final FirebaseAuth _auth = FirebaseAuth?.instance;
    final String _oldEmail = _auth.currentUser.email;

    blog('updateUserEmail : new : $newEmail : old : $_oldEmail');

    if (_oldEmail != newEmail){

      _success = await tryCatchAndReturnBool(
        context: context,
        methodName: 'updateUserEmail',
        functions: () async {
          await _auth.currentUser.updateEmail(newEmail);
          blog('updateUserEmail : END');
        },
      );

    }

    return _success;
  }
// -----------------------------------------------------------------------------
}
