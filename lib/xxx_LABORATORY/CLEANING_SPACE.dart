// import 'package:bldrs/firestore/user_ops.dart';
// import 'package:bldrs/models/user_model.dart';
// import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// /// sign in with email & password
// Future<dynamic> emailSignInOpsy(BuildContext context, String email, String password) async {
//
//   UserCredential _userCredential;
//
//   /// try sign in and check result
//   dynamic _signInError = await tryCatchAndReturn(
//       context: context,
//       methodName: 'signInWithEmailAndPassword in emailSignInOps',
//       functions: () async {
//         _userCredential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
//         print('_userCredential : $_userCredential');
//       }
//   );
//
//   print('_signInError : $_signInError');
//   print('_userCredential : $_userCredential');
//
//   /// if sign it results user credentials and not an error string, get user id and read user ops
//   if (_userCredential == null){
//
//     return _signInError;
//
//   } else {
//
//     /// get user ID
//     User user = _userCredential.user;
//     String userID = user.uid;
//     print('x2 - emailSignInOps userID : $userID');
//
//     /// read user ops
//     UserModel _userModel = await UserOps().readUserOps(
//         context: context,
//         userID: userID
//     );
//     print('x2 - emailSignInOps _userModel : $_userModel');
//
//
//     return _userModel;
//
//   }
//
// }
