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

// bug to fix when try sign in with email that was already signed in by facebook
// I/flutter (18102): auth error is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.
// I/flutter (18102): signing result is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.

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
  /// create firebase user
  Future<User> _createFirebaseUser({String email, String password}) async {

    UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);

    User _user = _result.user;

    return _user;
  }
// -----------------------------------------------------------------------------
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

    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      User user = result.user;
      String userID = user.uid;

      UserModel _userModel = await UserOps().readUserOps(
          context: context,
          userID: userID);

      return _userModel;

    } catch (error) {
      print('auth error is : ${error.toString()}');
      return error;
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

    try {

      /// create firebase user
      User user = await _createFirebaseUser(email: email, password: password);


      /// create initial UserModel
      UserModel _initialUserModel = UserModel.createInitialUserModelFromUser(
        context: context,
        user: user,
      );

      return _initialUserModel;

    } catch (error) {

      await superDialog(
        context: context,
        title: 'Couldn\'t sign up',
        body: error,
        boolDialog: false,
      );


      print('auth error is : ${error.toString()}');
      return error;
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
  /// google sign in
  Future<String> googleSignInOps(BuildContext context, Zone currentZone) async {
    // await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);

    final User user = authResult.user;

    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);


    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      /// create a new UserModel
      UserModel _newUserModel = UserModel(
        userID: user.uid,
        joinedAt: DateTime.now(),
        userStatus: UserStatus.Normal,
        // -------------------------
        name: user.displayName,
        pic: user.photoURL,
        title: '',
        gender: Gender.any,
        country: currentZone.countryID,
        province: currentZone.provinceID,
        area: currentZone.areaID,
        language: Wordz.languageCode(context),
        position: GeoPoint(0, 0),
        contacts: <ContactModel>[
          ContactModel(contact: user.email, contactType: ContactType.Email),
          ContactModel(contact: user.phoneNumber, contactType: ContactType.Phone),
        ],
        // -------------------------
        // savedFlyersIDs: [''],
        // followedBzzIDs: [''],
      );

      /// create a new firestore document for the user with the userID
      await UserOps().createUserOps(userModel: _newUserModel);

      final User currentUser = _auth.currentUser;

      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }
// -----------------------------------------------------------------------------
  /// google sign out
  Future<void> googleSignOutOps() async {
    GoogleSignInAccount _account = await googleSignIn.signOut();

    print("GoogleSignInAccount is : $_account");
  }
// -----------------------------------------------------------------------------

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




