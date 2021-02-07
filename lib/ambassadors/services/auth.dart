import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  UserModel _convertFirebaseUserToUserModel(User user){
    return user == null ? null :
    UserModel(
      userID: user.uid,
      // joinedAt: DateTime.now(),
      // userStatus: UserStatus.NormalUser,
      // -------------------------
      name: user.displayName,
      pic: user.photoURL,
      // title: '',
      // gender: Gender.any,
      // country: currentHQ.countryID,
      // province: currentHQ.provinceID,
      // area: currentHQ.areaID,
      // language: Wordz.languageCode(context),
      // position: GeoPoint(0, 0),
      contacts: [ContactModel(contact: user.email, contactType: ContactType.Email)],
      // -------------------------
      // savedFlyersIDs: [''],
      // followedBzzIDs: [''],
    );
  }
// ---------------------------------------------------------------------------
  // auth change user stream
  Stream<UserModel> get userStream {
    return _auth.authStateChanges()
    // .map((User user) => _convertFirebaseUserToUserModel(user));
    .map(_convertFirebaseUserToUserModel); // different syntax than previous snippet
  }
// ---------------------------------------------------------------------------
  // sign in anonymously
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
  // sign in with email & password
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
  // register with email & password
  Future registerWithEmailAndPassword(BuildContext context,HQ currentHQ, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User user = result.user;

      // create a new firestore document for the user with the userID
      await UserProvider(userID: user.uid).updateUserData(
          userID: user.uid,
          joinedAt: DateTime.now(),
          userStatus: UserStatus.NormalUser,
          // -------------------------
          name: user.displayName,
          pic: user.photoURL,
          title: '',
          gender: Gender.any,
          country: currentHQ.countryID,
          province: currentHQ.provinceID,
          area: currentHQ.areaID,
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
  // sign out
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