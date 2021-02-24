import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// bug to fix when try sign in with email that was already signed in by facebook
// I/flutter (18102): auth error is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.
// I/flutter (18102): signing result is : [firebase_auth/wrong-password] The password is invalid or the user does not have a password.

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// create user object based on firebase user
  UserModel _convertFirebaseUserToUserModel(User user){
    return user == null ? null :
    UserModel(
      userID: user.uid,
      // joinedAt: DateTime.now(),
      // userStatus: UserStatus.Normal,
      // -------------------------
      name: user.displayName,
      pic: user.photoURL,
      // title: '',
      // gender: Gender.any,
      // country: currentZone.countryID,
      // province: currentZone.provinceID,
      // area: currentZone.areaID,
      // language: Wordz.languageCode(context),
      // position: GeoPoint(0, 0),
      contacts: [ContactModel(contact: user.email, contactType: ContactType.Email)],
      // -------------------------
      // savedFlyersIDs: [''],
      // followedBzzIDs: [''],
    );
  }
  // ---------------------------------------------------------------------------
  /// auth change user stream
  Stream<UserModel> get userStream {
    return _auth.authStateChanges()
    // .map((User user) => _convertFirebaseUserToUserModel(user));
    .map(_convertFirebaseUserToUserModel); // different syntax than previous snippet
  }
  // ---------------------------------------------------------------------------
  /// sign in anonymously
  Future signInAnon() async {
    try {
      // they have renamed the class 'AuthResult' to 'UserCredential'
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _convertFirebaseUserToUserModel(user);
    } catch (error) {
      print('auth error is : ${error.toString()}');
      return null;
    }
  }
  // ---------------------------------------------------------------------------
  /// sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User user = result.user;
      return _convertFirebaseUserToUserModel(user);
    } catch(error) {
      print('auth error is : ${error.toString()}');
      return error;
    }
  }
  // ---------------------------------------------------------------------------
  /// register with email & password
  Future registerWithEmailAndPassword(BuildContext context,Zone currentZone, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User user = result.user;

      /// create a new firestore document for the user with the userID
      await UserProvider(userID: user.uid).updateUserData(
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
          contacts: [ContactModel(contact: user.email, contactType: ContactType.Email)],
          // -------------------------
          savedFlyersIDs: [''],
          followedBzzIDs: [''],
      );

      return _convertFirebaseUserToUserModel(user);
    } catch(error) {
      print('auth error is : ${error.toString()}');
      return error;
    }
  }
  // ---------------------------------------------------------------------------
  /// sign out
  Future signOut() async {
      try{
        return await _auth.signOut();
      } catch (e) {
        print (e.toString());
        return null;
      }
  }
  // ---------------------------------------------------------------------------
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
String superUserID(){
  String userID = (FirebaseAuth.instance.currentUser).uid;
  return userID;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
