import 'dart:developer';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
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

/// TASK : check this shit
/// an alert error should be thrown when firebase replies with the following line
/// Firebase Authentication Error
/// An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
/// we should consider same scenario with other auth methods that have this conflict with existing signed up e-mail
/// need to fix if user signed in with facebook previously,, use the existing profile and not overwrite the existing user profile data

// -----------------------------------------------------------------------------

/// REFERENCES

// ---------------------------------------------------
//   /// firebaseAuth instance
//   final FirebaseAuth _auth = FirebaseAuth?.instance;
// -----------------------------------------------------------------------------
bool userIsSignedIn() {
  bool _userIsSignedIn = false;

  if (superFirebaseUser() == null) {
    _userIsSignedIn = false;
  } else {
    _userIsSignedIn = true;
  }

  blog('_userIsSignedIn() = $_userIsSignedIn');

  return _userIsSignedIn;
}
// -----------------------------------------------------------------------------

/// CREATE

// ---------------------------------------------------
/// create firebase user
Future<User> _createFirebaseUser({
  @required String email,
  @required String password,
}) async {
  final FirebaseAuth _auth = FirebaseAuth?.instance;

  final UserCredential _result = await _auth.createUserWithEmailAndPassword(
      email: email.trim(), password: password);

  final User _user = _result.user;

  return _user;
}
// -----------------------------------------------------------------------------

/// DELETE

// ---------------------------------------------------
/// TASK : fix this error
/// deleteFirebaseUser : tryAndCatch ERROR : [firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request.
Future<bool> deleteFirebaseUser({
  @required BuildContext context,
  @required String userID,
}) async {
  blog('deleting firebase user');
  // String _error;

  final bool _result = await tryCatchAndReturn(
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

/// BY EMAIL

// ---------------------------------------------------
/// sign in with email & password
Future<dynamic> emailSignInOps({
  @required BuildContext context,
  @required String email,
  @required String password,
}) async {
  UserCredential _userCredential;
  String _error;

  /// try sign in and check result
  final bool _signInResult = await tryCatchAndReturn(
      context: context,
      methodName: 'signInWithEmailAndPassword in emailSignInOps',
      functions: () async {
        final FirebaseAuth _auth = FirebaseAuth?.instance;

        _userCredential = await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password);
        blog('_userCredential : $_userCredential');
      },
      onError: (String error) async {
        {
          blog('emailSignInOps returns error : $error');
          _error = error;
        }
      });

  blog('_signInResult : $_signInResult');
  blog('_userCredential : $_userCredential');

  /// if sign in results user credentials and not an error string, get user id and read user ops
  if (_signInResult == true) {
    /// get user ID
    final User _user = _userCredential.user;
    final String _userID = _user.uid;
    blog('x2 - emailSignInOps userID : $_userID');

    /// read user ops
    final UserModel _userModel =
        await UserFireOps.readUser(context: context, userID: _userID);
    blog('x2 - emailSignInOps _userModel : $_userModel');

    return _userModel;
  } else {
    return _error;
  }
}
// -----------------------------------------------------------------------------
/// register with email & password
Future<dynamic> emailRegisterOps({
  @required BuildContext context,
  @required ZoneModel currentZone,
  @required String email,
  @required String password,
}) async {
  User _user;
  String _error;

  /// try register and check result
  final bool _registerResult = await tryCatchAndReturn(
      context: context,
      methodName: 'emailRegisterOps',
      functions: () async {
        /// create firebase user
        _user = await _createFirebaseUser(email: email, password: password);
      },
      onError: (String error) async {
        _error = error;
      });

  blog('_registerResult : $_registerResult');
  blog('_user : $_user');

  if (_registerResult == true) {
    final UserModel _initialUserModel =
        await UserModel.createInitialUserModelFromUser(
      context: context,
      user: _user,
      zone: currentZone,
      authBy: AuthBy.email,
    );

    /// create a new firestore document for the user with the userID
    final UserModel _finalUserModel = await UserFireOps.createUser(
      context: context,
      userModel: _initialUserModel,
      authBy: AuthBy.email,
    );

    return _finalUserModel;
  } else {
    return _error;
  }
}
// -----------------------------------------------------------------------------

/// sign out

// ---------------------------------------------------
Future<void> emailSignOutOps(BuildContext context) async {
  try {
    final FirebaseAuth _auth = FirebaseAuth?.instance;

    return await _auth.signOut();
  } on Exception catch (error) {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Trouble Signing out',
      body: error,
    );
  }
}
// -----------------------------------------------------------------------------
Future<dynamic> facebookSignInOps({
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

  User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _error;

  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return facebook auth
  final bool _signInResult = await tryCatchAndReturn(
      context: context,
      methodName: 'facebookSignInOps',
      functions: () async {
        // blog('1 language: ${Wordz.languageCode(context)},');

        /// B - get [accessToken]
        final LoginResult _loginResult = await FacebookAuth.instance.login();
        final AccessToken _accessToken = _loginResult.accessToken;
        blog('facebookSignInOps : _accessToken : $_accessToken');

        if (_accessToken != null) {
          /// C - Create [credential] from the [access token]
          final FacebookAuthCredential _credential =
              FacebookAuthProvider.credential(
            _accessToken.token,
          );
          blog('facebookSignInOps : _credential : $_credential');

          /// D - get [user credential] by [credential]
          final UserCredential _userCredential =
              await _auth.signInWithCredential(_credential);
          blog('facebookSignInOps : _userCredential : $_userCredential');

          /// E - get firebase [user] from [user credential]
          _user = _userCredential.user;
          blog('facebookSignInOps : _user : $_user');
        }

        /// B - [accessToken] is null
        else {
          blog('Facebook Access token is null');
        }
      },
      onError: (String error) async {
        _error = error;
      });

  blog('facebookSignInOps : _signInResult : $_signInResult');
  // ==============================================================

  /// X2 - process firebase user to return UserModel
  // -------------------------------------------------------
  /// xx - return error : if auth fails
  if (_user == null) {
    /// when _user is null the register fails and returns this error string
    return _error;
  }

  /// xx - return firebase user : if auth succeeds
  else {
    // blog('2 language: ${Wordz.languageCode(context)},');

    /// E - get Or Create UserModel From User
    final Map<String, dynamic> _userModelMap =
        await UserFireOps.getOrCreateUserModelFromUser(
      context: context,
      zone: currentZone,
      user: _user,
      authBy: AuthBy.facebook,
    );

    return _userModelMap;
  }
}
// -----------------------------------------------------------------------------
Future<dynamic> googleSignInOps({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {
  User _user;
  String _error;

  // steps ----------
  /// google sign in to get firebase user to check if it has a userModel or to
  /// create a new one
  ///
  /// X1 - try get firebase user or return error
  ///   xx - try catch return google auth on WEB & ANDROID-IOS
  ///     A - if on web
  ///       B - get [auth provider]
  ///       C - get [user credential] from [auth provider]
  ///       D - get [firebase user] from [user credential]
  ///     A - if not on web
  ///       B - get [google sign in account]
  ///       B - get [google sign in auth] from [google sign in account]
  ///       B - get [auth credential] from [google sign in auth]
  ///       C - get [user credential] from [auth credential]
  ///       D - get firebase user from user credential
  ///
  /// X2 - process firebase user to return UserModel or error
  ///   xx - return error : if auth fails
  ///   xx - return firebase user : if auth succeeds
  ///      E - get Or Create UserModel From User
  /// xxx deleted ?      E - read user ops if existed
  /// xxx deleted ?         Ex - if new user (userModel == null)
  /// xxx deleted ?            E1 - create initial user model
  /// xxx deleted ?            E2 - create user ops
  /// xxx deleted ?            E3 - return new userModel inside userModel-firstTimer map
  /// xxx deleted ?         Ex - if user has existing user model
  /// xxx deleted ?            E3 - return existing userMode inside userModel-firstTimer map
  // ----------

  /// X1 - try get firebase user or return error
  // -------------------------------------------------------
  /// xx - try catch return google auth
  final bool _signInResult = await tryCatchAndReturn(
      context: context,
      methodName: 'googleSignInOps',
      functions: () async {
        final FirebaseAuth _auth = FirebaseAuth?.instance;

        blog('1 language: ${Wordz.languageCode(context)},');

        /// A - if on web
        if (kIsWeb) {
          blog('googleSignInOps : kIsWeb : $kIsWeb');

          /// B - get [auth provider]
          final GoogleAuthProvider authProvider = GoogleAuthProvider();

          /// C - get [user credential] from [auth provider]
          final UserCredential _userCredential =
              await _auth.signInWithPopup(authProvider);

          /// D - get [firebase user] from [user credential]
          _user = _userCredential.user;
          blog('googleSignInOps : _user : $_user');
        }

        /// A - if kIsWeb != true : so its android or ios
        else {
          /// google sign in instance
          final GoogleSignIn _googleSignIn = GoogleSignIn();

          /// B - get [google sign in account]
          final GoogleSignInAccount _googleAccount =
              await _googleSignIn.signIn();
          blog('googleSignInOps : _googleAccount : $_googleAccount');

          if (_googleAccount != null) {
            /// B - get [google sign in auth] from [google sign in account]
            final GoogleSignInAuthentication _googleAuth =
                await _googleAccount.authentication;
            blog('googleSignInOps : _googleAuth : $_googleAuth');

            /// B - get [auth credential] from [google sign in auth]
            // TASK : signInMethod: google.com, can be found here
            /// AuthCredential(providerId: google.com, signInMethod: google.com, token: null)
            final AuthCredential _authCredential =
                GoogleAuthProvider.credential(
              accessToken: _googleAuth.accessToken,
              idToken: _googleAuth.idToken,
            );
            blog('googleSignInOps : _authCredential : $_authCredential');

            /// C - get [user credential] from [auth credential]
            final UserCredential _userCredential =
                await _auth.signInWithCredential(_authCredential);
            blog('googleSignInOps : _authResult : $_userCredential');

            /// D - get firebase user from user credential
            _user = _userCredential.user;
            blog('googleSignInOps : _user : $_user');
          }
        }
      },
      onError: (String error) async {
        _error = error;
      });

  blog('facebookSignInOps : _signInResult : $_signInResult');

  // ==============================================================

  /// X2 - process firebase user to return UserModel
  // -------------------------------------------------------
  /// xx - return error : if auth fails
  if (_user == null) {
    /// when _user is null the register fails and returns this error string
    return _error;
  }

  /// xx - return firebase user : if auth succeeds
  else {
    blog('2 language: ${Wordz.languageCode(context)},');

    /// E - get Or Create UserModel From User
    final Map<String, dynamic> _userModelMap =
        await UserFireOps.getOrCreateUserModelFromUser(
            context: context,
            zone: currentZone,
            user: _user,
            authBy: AuthBy.google);

    return _userModelMap;

    // /// E - read user ops if existed
    // UserModel _existingUserModel = await UserOps().readUserOps(
    //   context: context,
    //   userID: _user.uid,
    // );
    // // blog('lng : ${Wordz.languageCode(context)}');
    //
    // /// Ex - if new user (userModel == null)
    // if (_existingUserModel == null) {
    //
    //   // blog('lng : ${Wordz.languageCode(context)}');
    //
    //   /// E1 - create initial user model
    //   UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
    //     context: context,
    //     user: _user,
    //     zone: currentZone,
    //     authBy: AuthBy.google,
    //   );
    //   blog('googleSignInOps : _initialUserModel : $_initialUserModel');
    //
    //   /// E2 - create user ops
    //   UserModel _finalUserModel = await UserOps().createUserOps(
    //     context: context,
    //     userModel: _initialUserModel,
    //   );
    //   blog('googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');
    //
    //   /// E3 - return new userModel inside userModel-firstTimer map
    //   return
    //
    //     {
    //       'userModel' : _finalUserModel,
    //       'firstTimer' : true,
    //     };
    //
    // }
    //
    // /// Ex - if user has existing user model
    // else {
    //
    //   /// E3 - return existing userMode inside userModel-firstTimer map
    //   return
    //     {
    //       'userModel' : _existingUserModel,
    //       'firstTimer' : false,
    //     };
    // }

  }
}
// -----------------------------------------------------------------------------
Future<dynamic> appleAuthOps({
  @required BuildContext context,
  @required ZoneModel currentZone,
}) async {

  blog('starting apple auth ops');

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

/// TASK : send email verification : not tested yet
Future<void> sendVerificationEmail({@required BuildContext context}) async {
  await tryAndCatch(
      context: context,
      methodName: 'sendVerificationEmail',
      functions: () async {
        final User _currentUser = superFirebaseUser();

        final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
          url: '',
          androidInstallApp: true,
          androidMinimumVersion: '',
          androidPackageName: '',
          dynamicLinkDomain: '',
          handleCodeInApp: true,
          iOSBundleId: '',
        );

        await _currentUser.sendEmailVerification(actionCodeSettings);

        await NavDialog.showNavDialog(
          context: context,
          firstLine: 'Verification E-mail sent',
          secondLine: 'Please Check Your E-mail',
        );
      }
      // onError:
      );
}

// =============================================================================
String superUserID() {
  final String userID = superFirebaseUser()?.uid;
  return userID;
}
// =============================================================================
User superFirebaseUser() {
  final User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
// =============================================================================


/*

old shit

  /// firebase user provider data
  // List<UserInfo> _getFirebaseUserProviderData ()  {
  //
  //   final User user = _auth.currentUser;
  //
  //   // blog(user.providerData);
  //
  //   return user.providerData;
  //
  //   // if (user.providerData.length < 2) {
  //   //   // do something
  //   // }
  //   // else {
  //   //   blog(user.providerData);
  //   // }
  //
  // }


/// --------------------------------------

// /// facebook register
// Future<UserCredential> facebookRegisterOps(BuildContext context, Zone zone) async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // ---------------------------------------------------------------------------
//   try {
//     final AccessToken accessToken = await FacebookAuth.instance.login();
//     // -------------------------
//     /// Create a credential from the access token
//     final FacebookAuthCredential credential = FacebookAuthProvider.credential(accessToken.token,);
//     // -------------------------
//     final UserCredential authResult = await _auth.signInWithCredential(credential);
//     // -------------------------
//     final User user = authResult.user;
//     // -------------------------
//     /// create new UserModel
//     UserModel _newUserModel = UserModel(
//       userID: user.uid,
//       createdAt: DateTime.now(),
//       userStatus: UserStatus.Normal,
//       // -------------------------
//       name: user.displayName,
//       pic: user.photoURL,
//       title: '',
//       company: '',
//       gender: Gender.any,
//       country: zone.countryID,
//       province: zone.provinceID,
//       area: zone.districtID,
//       language: Wordz.languageCode(context),
//       position: GeoPoint(0, 0),
//       contacts: <ContactModel>[ContactModel(
//           contact: user.email,
//           contactType: ContactType.Email
//       ), ContactModel(
//         contact: user.phoneNumber,
//         contactType: ContactType.Phone,
//       ),],
//       // -------------------------
//       // savedFlyersIDs: [''],
//       // followedBzzIDs: [''],
//     );
//     // -------------------------
//     /// create a new firestore document for the user with the userID
//     await UserOps().createUserOps(userModel: _newUserModel);
//     // -------------------------
//     /// Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//     // -------------------------
//   } on FacebookAuthException catch (error) {
//     // handle the FacebookAuthException
//     blog("Facebook Authentication Error");
//     blog(error.message);
//
//     await superDialog(
//       context: context,
//       title: 'Couldn\'t continue with Facebook',
//       body: error,
//       boolDialog: false,
//     );
//
//   } on FirebaseAuthException catch (error) {
//     // handle the FirebaseAuthException
//     blog("Firebase Authentication Error");
//     blog(error.message);
//
//     await superDialog(
//       context: context,
//       title: 'Couldn\'t continue with Facebook',
//       body: error,
//       boolDialog: false,
//     );
//
//   } finally {}
//   return null;
// }


 */
