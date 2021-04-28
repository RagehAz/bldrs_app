import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> _deleteFirebaseUser({
    BuildContext context,
    String email,
    String password,
  }) async {

    try {

      User user = _auth.currentUser;

      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);

      print(user);

      UserCredential result = await user.reauthenticateWithCredential(credentials);

      await result.user.delete();

      return true;

    } catch (error) {

      print(error.toString());

      await superDialog(
        context: context,
        title: 'Could not delete account',
        body: error,
        boolDialog: false,
      );

      return null;
    }
  }
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

      await superDialog(
        context: context,
        title: 'Trouble Signing out',
        body: error,
        boolDialog: false,
      );

      return null;
    }
  }
// -----------------------------------------------------------------------------
  /// facebook register
  Future<UserCredential> facebookRegisterOps(BuildContext context, Zone zone) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // ---------------------------------------------------------------------------
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();
      // -------------------------
      /// Create a credential from the access token
      final FacebookAuthCredential credential = FacebookAuthProvider.credential(accessToken.token,);
      // -------------------------
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      // -------------------------
      final User user = authResult.user;
      // -------------------------
      /// create new UserModel
      UserModel _newUserModel = UserModel(
        userID: user.uid,
        joinedAt: DateTime.now(),
        userStatus: UserStatus.Normal,
        // -------------------------
        name: user.displayName,
        pic: user.photoURL,
        title: '',
        company: '',
        gender: Gender.any,
        country: zone.countryID,
        province: zone.provinceID,
        area: zone.areaID,
        language: Wordz.languageCode(context),
        position: GeoPoint(0, 0),
        contacts: <ContactModel>[ContactModel(
            contact: user.email,
            contactType: ContactType.Email
        ), ContactModel(
          contact: user.phoneNumber,
          contactType: ContactType.Phone,
        ),],
        // -------------------------
        // savedFlyersIDs: [''],
        // followedBzzIDs: [''],
      );
      // -------------------------
      /// create a new firestore document for the user with the userID
      await UserOps().createUserOps(userModel: _newUserModel);
      // -------------------------
      /// Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
      // -------------------------
    } on FacebookAuthException catch (error) {
      // handle the FacebookAuthException
      print("Facebook Authentication Error");
      print(error.message);

      await superDialog(
        context: context,
        title: 'Couldn\'t continue with Facebook',
        body: error,
        boolDialog: false,
      );

    } on FirebaseAuthException catch (error) {
      // handle the FirebaseAuthException
      print("Firebase Authentication Error");
      print(error.message);

      await superDialog(
        context: context,
        title: 'Couldn\'t continue with Facebook',
        body: error,
        boolDialog: false,
      );

    } finally {}
    return null;
  }
// -----------------------------------------------------------------------------
  /// facebook sign in
  dynamic facebookSignInOps(BuildContext context) async {

  }
// -----------------------------------------------------------------------------
  /// google sign in instance
  final GoogleSignIn googleSignIn = GoogleSignIn();
// -----------------------------------------------------------------------------
  /// google sign in to get firebase user to check if it has a userModel or to
  /// create a new one
  Future<dynamic> googleSignInOps(BuildContext context, Zone currentZone) async {
    User _user;

    /// 1 - start google sign in processes to get firebase user
    // -------------------------------------------------------
    /// try google sign in
    dynamic _registerError = await tryCatchAndReturn(
        context: context,
        methodName: 'googleSignInOps',
        functions: () async {
          print('1 language: ${Wordz.languageCode(context)},');
          if
          /// if it's on web
          (kIsWeb){
            print('googleSignInOps : kIsWeb : $kIsWeb');

            /// get auth provider
            GoogleAuthProvider authProvider = GoogleAuthProvider();

            /// get user credential from auth provider
            final UserCredential _userCredential = await _auth.signInWithPopup(authProvider);

            /// get firebase user
            _user = _userCredential.user;
            print('googleSignInOps : _user : $_user');

          }

          /// if kIsWeb != trye : so its android or ios
          else {

            /// get google sign in account
            final GoogleSignInAccount _googleAccount = await googleSignIn.signIn();
            print('googleSignInOps : _googleAccount : $_googleAccount');

            if(_googleAccount != null){

              /// get google sign in auth from google account
              final GoogleSignInAuthentication _googleAuth = await _googleAccount.authentication;
              print('googleSignInOps : _googleAuth : $_googleAuth');

              /// get auth credential from google sign in auth
              // TASK : signInMethod: google.com, can be found here
              /// AuthCredential(providerId: google.com, signInMethod: google.com, token: null)
              final AuthCredential _authCredential = GoogleAuthProvider.credential(
                accessToken: _googleAuth.accessToken,
                idToken: _googleAuth.idToken,
              );
              print('googleSignInOps : _authCredential : $_authCredential');

              /// get user credential from auth credential
              final UserCredential _userCredential = await _auth.signInWithCredential(_authCredential);
              print('googleSignInOps : _authResult : $_userCredential');

              /// get firebase user
              _user = _userCredential.user;
              print('googleSignInOps : _user : $_user');

            }

          }

        }
    );
    // ==============================================================

    /// 2 - process firebase user to return UserModel
    // -------------------------------------------------------
    /// if google sign in results a String, its an error to be returned
    if (_user == null) {

      /// when _user is null the register fails and returns this error string
      return _registerError.toString();
    }

    /// if _user is not null
    else {
      print('2 language: ${Wordz.languageCode(context)},');
      /// we check existing userModel
      UserModel _existingUserModel = await UserOps().readUserOps(
        context: context,
        userID: _user.uid,
      );
      // print('lng : ${Wordz.languageCode(context)}');

      /// if it's a new user, we start creating new account
      if (_existingUserModel == null) {
        // print('lng : ${Wordz.languageCode(context)}');

        /// create initial user model from firebase user
        UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
          context: context,
          user: _user,
          zone: currentZone,
          authBy: AuthBy.google,
        );
        print('googleSignInOps : _initialUserModel : $_initialUserModel');

        /// start create user ops
        UserModel _finalUserModel = await UserOps().createUserOps(
          context: context,
          userModel: _initialUserModel,
        );
        print('googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');

        /// return the final userModel map
        return

          {
            'userModel' : _finalUserModel,
            'firstTimer' : true,
          };

      }

      /// if user has existing userModel
      else {

        /// return this existing userModel
        return
          {
            'userModel' : _existingUserModel,
            'firstTimer' : false,
          };
      }

    }
  }
// -----------------------------------------------------------------------------
  /// google sign out
  Future<void> googleSignOutOps(BuildContext context) async {

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

      }
    );

    print('googleSignOutOps : currentUser is : ${googleSignIn.currentUser}');

  }
// -----------------------------------------------------------------------------
  Future<void> signOut(BuildContext context) async {

    print('Signing out');
    await googleSignOutOps(context);
    await emailSignOutOps(context);
    // Nav.goToRoute(context, Routez.Starting);

    Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);

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




