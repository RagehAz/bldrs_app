import 'package:firebase_auth/firebase_auth.dart';


// class Auth {
//   final _auth = FirebaseAuth.instance;
//
//   Future<AuthResult> signUp(String email, String password) async
//   {
//     final authResult = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
//     return authResult;
//   }
//
//     Future<AuthResult> signIn(String email, String password) async
//   {
//     final authResult = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
//     return authResult;
//   }
//
// }

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user

  // sign in anonymously
Future signInAnon() async {
  try {
    // they have renamed the class 'AuthResult' to 'UserCredential'
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;
    return user;
  } catch (error) {
    print('auth error is : ${error.toString()}');
    return null;
  }
}

  // sign in with email & password

  // register with email & password

  // sign out
}