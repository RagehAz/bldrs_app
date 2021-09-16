import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/nav_dialog/nav_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


// an alert error should be thrown when firebase replies with the following line
// Firebase Authentication Error
// An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
// we should consider same scenario with other auth methods that have this conflict with existing signed up e-mail

// need to fix if user signed in with facebook previously,, use the existing proile and not overwrite the existing user profile data

class AuthOps {
// =============================================================================
  /// firebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth?.instance;
// -----------------------------------------------------------------------------
  static bool userIsSignedIn(){
    bool _userIsSignedIn = false;

    if (superFirebaseUser() == null){

      _userIsSignedIn = false;


    } else {

      _userIsSignedIn = true;

    }

    print('_userIsSignedIn() = $_userIsSignedIn');

    return _userIsSignedIn;
  }
// -----------------------------------------------------------------------------
  Future<dynamic> deleteFirebaseUser(BuildContext context, String userID) async {

    print('deleting firebase user');

    var _result = await tryCatchAndReturn(
      context: context,
      methodName: 'deleteFirebaseUser',
      functions: () async {

        _auth.currentUser.delete();


      }
    );

    return _result;
  }
// -----------------------------------------------------------------------------
  /// firebase user provider data
  dynamic getFirebaseUserProviderData ()  {
    // dynamic _thing = _auth.currentUser.

    User user = _auth.currentUser;

    print(user.providerData);

    return user.providerData;

    // if (user.providerData.length < 2) {
    //   // do something
    // }
    // else {
    //   print(user.providerData);
    // }

  }
// -----------------------------------------------------------------------------
  /// create firebase user
  Future<User> _createFirebaseUser({String email, String password}) async {

    UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);

    User _user = _result.user;

    return _user;
  }
// -----------------------------------------------------------------------------
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
  //     print(user);
  //
  //     UserCredential result = await user.reauthenticateWithCredential(credentials);
  //
  //     await result.user.delete();
  //
  //     return true;
  //
  //   } catch (error) {
  //
  //     print(error.toString());
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
  /// sign in with email & password
  Future<dynamic> emailSignInOps(BuildContext context, String email, String password) async {

    UserCredential _userCredential;

    /// try sign in and check result
    dynamic _signInError = await tryCatchAndReturn(
        context: context,
        methodName: 'signInWithEmailAndPassword in emailSignInOps',
        functions: () async {
          _userCredential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
          print('_userCredential : $_userCredential');
        }
        );

    print('_signInError : $_signInError');
    print('_userCredential : $_userCredential');

    /// if sign in results user credentials and not an error string, get user id and read user ops
    if (_signInError != null){

      print('emailSignInOps returns _signInError : $_signInError');
      return _signInError.toString();

    } else {
      /// get user ID
      User user = _userCredential.user;
      String userID = user.uid;
      print('x2 - emailSignInOps userID : $userID');

      /// read user ops
      UserModel _userModel = await UserOps().readUserOps(
          context: context,
          userID: userID
      );
      print('x2 - emailSignInOps _userModel : $_userModel');


      return _userModel;

    }

  }
// -----------------------------------------------------------------------------
  /// register with email & password
  Future<dynamic> emailRegisterOps(
      BuildContext context,
      Zone currentZone,
      String email,
      String password
      ) async {

    User _user;

    /// try register and check result
    dynamic _registerError = await tryCatchAndReturn(
      context: context,
      methodName: 'emailRegisterOps',
      functions: () async {

        /// create firebase user
        _user = await _createFirebaseUser(email: email, password: password);

      }
    );

    print('_registerError : $_registerError');
    print('_user : $_user');

    /// if sign it results User and not an error string, create initial user
    if (_user == null) {

      /// when _user is null the register fails and returns this error string
      return _registerError;

    } else {



      /// when register succeeded returning firebase user, convert it to userModel
      UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
        context: context,
        user: _user,
        zone: currentZone,
        authBy: AuthBy.email,
      );


      /// create a new firestore document for the user with the userID
      UserModel _finalUserModel = await UserOps().createUserOps(userModel: _initialUserModel);

      /// return the final userModel
      return _finalUserModel;
    }

  }
// -----------------------------------------------------------------------------
  /// sign out
  Future<void> emailSignOutOps(BuildContext context) async {

    try {

      return await _auth.signOut();

    } catch (error) {

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Trouble Signing out',
        body: error,
        boolDialog: false,
      );

      return null;
    }
  }
// -----------------------------------------------------------------------------
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
  dynamic facebookSignInOps(BuildContext context, Zone currentZone) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    /// X1 - try get firebase user or return error
    // -------------------------------------------------------
    /// xx - try catch return facebook auth
    dynamic _registerError = await tryCatchAndReturn(
        context: context,
        methodName: 'facebookSignInOps',
        functions: () async {

          print('1 language: ${Wordz.languageCode(context)},');


          /// B - get [accessToken]
          final LoginResult _loginResult = await FacebookAuth.instance.login();
          final AccessToken _accessToken =_loginResult.accessToken;
          print('facebookSignInOps : _accessToken : $_accessToken');

            if(_accessToken != null){

              /// C - Create [credential] from the [access token]
              final FacebookAuthCredential _credential = FacebookAuthProvider.credential(_accessToken.token,);
              print('facebookSignInOps : _credential : $_credential');

              /// D - get [user credential] by [credential]
              final UserCredential _userCredential = await _auth.signInWithCredential(_credential);
              print('facebookSignInOps : _userCredential : $_userCredential');

              /// E - get firebase [user] from [user credential]
              _user = _userCredential.user;
              print('facebookSignInOps : _user : $_user');

            }

            /// B - [accessToken] is null
            else {
              print('Facebook Access token is null');
            }

        }
    );
    // ==============================================================

    /// X2 - process firebase user to return UserModel
    // -------------------------------------------------------
    /// xx - return error : if auth fails
    if (_user == null) {

      /// when _user is null the register fails and returns this error string
      return _registerError.toString();
    }

    /// xx - return firebase user : if auth succeeds
    else {
      print('2 language: ${Wordz.languageCode(context)},');

      /// E - get Or Create UserModel From User
      Map<String, dynamic> _userModelMap = await UserOps().getOrCreateUserModelFromUser(
        context: context,
        zone: currentZone,
        user: _user,
      );

      return _userModelMap;

    }

  }
// -----------------------------------------------------------------------------
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
  // /      E - read user ops if existed
  // /         Ex - if new user (userModel == null)
  // /            E1 - create initial user model
  // /            E2 - create user ops
  // /            E3 - return new userModel inside userModel-firstTimer map
  // /         Ex - if user has existing user model
  // /            E3 - return existing userMode inside userModel-firstTimer map
  Future<dynamic> googleSignInOps(BuildContext context, Zone currentZone) async {
    User _user;

    /// X1 - try get firebase user or return error
    // -------------------------------------------------------
    /// xx - try catch return google auth
    dynamic _registerError = await tryCatchAndReturn(
        context: context,
        methodName: 'googleSignInOps',
        functions: () async {

          print('1 language: ${Wordz.languageCode(context)},');

          /// A - if on web
          if (kIsWeb){
            print('googleSignInOps : kIsWeb : $kIsWeb');

            /// B - get [auth provider]
            GoogleAuthProvider authProvider = GoogleAuthProvider();

            /// C - get [user credential] from [auth provider]
            final UserCredential _userCredential = await _auth.signInWithPopup(authProvider);

            /// D - get [firebase user] from [user credential]
            _user = _userCredential.user;
            print('googleSignInOps : _user : $_user');

          }

          /// A - if kIsWeb != true : so its android or ios
          else {

            /// google sign in instance
            final GoogleSignIn _googleSignIn = GoogleSignIn();

            /// B - get [google sign in account]
            final GoogleSignInAccount _googleAccount = await _googleSignIn.signIn();
            print('googleSignInOps : _googleAccount : $_googleAccount');

            if(_googleAccount != null){

              /// B - get [google sign in auth] from [google sign in account]
              final GoogleSignInAuthentication _googleAuth = await _googleAccount.authentication;
              print('googleSignInOps : _googleAuth : $_googleAuth');

              /// B - get [auth credential] from [google sign in auth]
              // TASK : signInMethod: google.com, can be found here
              /// AuthCredential(providerId: google.com, signInMethod: google.com, token: null)
              final AuthCredential _authCredential = GoogleAuthProvider.credential(
                accessToken: _googleAuth.accessToken,
                idToken: _googleAuth.idToken,
              );
              print('googleSignInOps : _authCredential : $_authCredential');

              /// C - get [user credential] from [auth credential]
              final UserCredential _userCredential = await _auth.signInWithCredential(_authCredential);
              print('googleSignInOps : _authResult : $_userCredential');

              /// D - get firebase user from user credential
              _user = _userCredential.user;
              print('googleSignInOps : _user : $_user');

            }

          }

        }
    );
    // ==============================================================

    /// X2 - process firebase user to return UserModel
    // -------------------------------------------------------
    /// xx - return error : if auth fails
    if (_user == null) {

      /// when _user is null the register fails and returns this error string
      return _registerError.toString();
    }

    /// xx - return firebase user : if auth succeeds
    else {
      print('2 language: ${Wordz.languageCode(context)},');

      /// E - get Or Create UserModel From User
      Map<String, dynamic> _userModelMap = await UserOps().getOrCreateUserModelFromUser(
        context: context,
        zone: currentZone,
        user: _user,
      );

      return _userModelMap;

      // /// E - read user ops if existed
      // UserModel _existingUserModel = await UserOps().readUserOps(
      //   context: context,
      //   userID: _user.uid,
      // );
      // // print('lng : ${Wordz.languageCode(context)}');
      //
      // /// Ex - if new user (userModel == null)
      // if (_existingUserModel == null) {
      //
      //   // print('lng : ${Wordz.languageCode(context)}');
      //
      //   /// E1 - create initial user model
      //   UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
      //     context: context,
      //     user: _user,
      //     zone: currentZone,
      //     authBy: AuthBy.google,
      //   );
      //   print('googleSignInOps : _initialUserModel : $_initialUserModel');
      //
      //   /// E2 - create user ops
      //   UserModel _finalUserModel = await UserOps().createUserOps(
      //     context: context,
      //     userModel: _initialUserModel,
      //   );
      //   print('googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');
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
  /// google sign out
  static Future<bool> googleSignOutOps(BuildContext context) async {

    bool _isSignedIn = true;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    print('googleSignOutOps : currentUser was : ${googleSignIn.currentUser}');

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
      onError: (){
        _isSignedIn = true;
      }
    );

    print('googleSignOutOps : currentUser is : ${googleSignIn.currentUser}');

    return _isSignedIn;
  }
// -----------------------------------------------------------------------------
  Future<void> signOut({
    BuildContext context,
    bool routeToUserChecker,
  }) async {

    print('Signing out');
    await googleSignOutOps(context);
    await emailSignOutOps(context);
    // Nav.goToRoute(context, Routez.Starting);

    if (routeToUserChecker == true){
    await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
    }

  }
// -----------------------------------------------------------------------------

  /// TASK : send email verification : not tested yet
  static Future<void> sendVerificationEmail({BuildContext context, }) async {

    await tryAndCatch(
      context: context,
      methodName: 'sendVerificationEmail',
      functions: () async {

        User _currentUser = superFirebaseUser();

        ActionCodeSettings actionCodeSettings = ActionCodeSettings(
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
          isBig: true,
        );

      }
      // onError:
    );

}
}
// =============================================================================
  String superUserID(){
  String userID = superFirebaseUser()?.uid;
  return userID;
}
// =============================================================================
  User superFirebaseUser(){
  User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
// =============================================================================
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
//       joinedAt: DateTime.now(),
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
//     print("Facebook Authentication Error");
//     print(error.message);
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
//     print("Firebase Authentication Error");
//     print(error.message);
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




