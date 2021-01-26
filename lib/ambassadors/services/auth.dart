import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  UserModel _convertFirebaseUserToUserModel(User user){
    return user == null ? null :
    UserModel(
      userID: user.uid,
      // savedFlyersIDs: ,
      // followedBzzIDs: ,
      // publishedFlyersIDs: ,
      // name: ,
      // lastName: ,
      // pic: ,
      // title: ,
      // city: ,
      // country: ,
      // whatsAppIsOn: ,
      // contacts: ,
      // position: ,
      // joinedAt: ,
      // gender: ,
      // language: ,
      // userStatus: ,
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
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User user = result.user;

      // create a new firestore document for the user with the userID
      await UserProvider(userID: user.uid).updateUserData(
        userID : user.uid                 ,      // userID
        savedFlyersIDs : ['savedFlyersIDs']             ,      // savedFlyersIDs
        followedBzzIDs : ['followedBzzIDs']             ,      // followedBzzIDs
        name : user.displayName           ,      // name
        pic : user.photoURL               ,      // pic
        title : 'title'                   ,      // title
        city : 'city'                     ,      // city
        country : 'country'               ,      // country
        // [
        //   {
        //     'type' : '${cipherContactType(ContactType.Email)}',
        //     'value' : '${user.email}',
        //     'show' : true
        //   },
        // ]                      ,      // contacts
        position : GeoPoint(0, 0)         ,      // position
        // DateTime.now()         ,      // joinedAt
        gender : 'gender'                 ,      // gender
        language : 'language'             ,      // language
        userStatus : 1                    ,      // userStatus
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