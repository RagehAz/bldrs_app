import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// bug to fix when try sign in with email that was already signed in by facebook
// I/flutter (18102): auth error is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.
// I/flutter (18102): signing result is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.

class AuthService {
//   BuildContext context;
//   Zone currentZone;
//
//   AuthService({
//     this.context,
//     this.currentZone,
// });

  // dynamic cc = Firebase.
  final FirebaseAuth _auth = FirebaseAuth?.instance;

  /// create user object based on firebase user
  UserModel _convertFirebaseUserToUserModel(User user) {

    return
      user == null ? null :
    UserModel(
      userID: user.uid,
      joinedAt: DateTime.now(),
      userStatus: UserStatus.Normal,
      // -------------------------
      name: user.displayName,
      pic: user.photoURL,
      title: '',
      gender: Gender.any,
      country: null,
      province: null,
      area: null,
      language: 'en',
      position: GeoPoint(0, 0),
      contacts: [],
      // -------------------------
      myBzzIDs: [],
    );

  }
  // ---------------------------------------------------------------------------
  /// auth change user stream
  Stream<UserModel> get userStream {
    return _auth.authStateChanges()
    .map((User user) => _convertFirebaseUserToUserModel(user));
    //     .map(
    //     _convertFirebaseUserToUserModel); // different syntax than previous snippet
  }
  // ---------------------------------------------------------------------------
  /// sign in anonymously
  Future<dynamic> signInAnon(BuildContext context, Zone currentZone) async {
    try {
      // they have renamed the class 'AuthResult' to 'UserCredential'
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _convertFirebaseUserToUserModel(user);
    } catch (error) {
      superDialog(context, error, 'Sorry Can\'t continue');
      print('auth error is : ${error.toString()}');
      return null;
    }
  }
  // ---------------------------------------------------------------------------
  /// sign in with email & password
  Future<dynamic> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;
      String userID = user.uid;
      UserModel _userModel = await UserProvider(userID: userID).getUserModel(userID);
      return _userModel;
    } catch (error) {
      print('auth error is : ${error.toString()}');

      return error;
    }
  }
  // ---------------------------------------------------------------------------
  /// register with email & password
  Future<dynamic> registerWithEmailAndPassword(
      BuildContext context,
      Zone currentZone,
      String email,
      String password
      ) async {

    try {

      /// create firebase user
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      User user = _result.user;

      /// conclude user contacts
      List<ContactModel> _concludeUserContacts(User user){
        List<ContactModel> _userContacts = new List();
        String _userEmail = user.email;
        String _userPhone = user.phoneNumber;

        if (_userEmail != null){
          _userContacts.add(
              ContactModel(contact: _userEmail, contactType: ContactType.Email)
          );
        }

        if (_userPhone != null){
          _userContacts.add(
              ContactModel(contact: _userPhone, contactType: ContactType.Phone)
          );
        }

        return _userContacts;
      }

      /// get user current location
      // TASK : need to trace user current location and pass it here while creating the userModel from firebase User
      CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);

      /// create initial UserModel
      UserModel _initialUserModel =
      UserModel(
        userID: user.uid,
        joinedAt: DateTime.now(),
        userStatus: UserStatus.Normal,
        // -------------------------
        name: user.displayName,
        pic: user.photoURL,
        title: '',
        gender: Gender.any,
        country: _countryPro.currentCountryID,
        province: _countryPro.currentProvinceID,
        area: _countryPro.currentAreaID,
        language: Wordz.languageCode(context),
        position: null,
        contacts: _concludeUserContacts(user),
        // -------------------------
        myBzzIDs: [],
      );

      return _initialUserModel;

    } catch (error) {
      // superDialog(context, error, 'Couldn\'t sign up');
      print('auth error is : ${error.toString()}');
      return error;
    }
  }
  // ---------------------------------------------------------------------------
  /// sign out
  Future<void> signOut(BuildContext context) async {
    try {
      return await _auth.signOut();
    } catch (error) {
      superDialog(context, error, 'Trouble Signing out');
      return null;
    }
  }
  // ---------------------------------------------------------------------------
  Future<void> deleteFirebaseUser(BuildContext context, String email, String password)
  async {
    try {
      User user = _auth.currentUser;
      AuthCredential credentials =
      EmailAuthProvider.credential(email: email, password: password);
      print(user);
      UserCredential result = await user.reauthenticateWithCredential(
          credentials);
      await result.user.delete();
      return true;
    } catch (error) {
      print(error.toString());
      superDialog(context, error, 'Could not delete account');
      return null;
    }
  }
}
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
  String superUserID(){
  String userID = superFirebaseUser()?.uid;
  return userID;
}
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
  User superFirebaseUser(){
  User _user = FirebaseAuth.instance.currentUser;
  return _user;
}
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
