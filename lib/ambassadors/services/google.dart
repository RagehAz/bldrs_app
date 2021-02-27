import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle(BuildContext context, Zone currentZone) async {
  // await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    // create a new firestore document for the user with the userID
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
      contacts: [
        ContactModel(contact: user.email, contactType: ContactType.Email)
      ],
      // -------------------------
      savedFlyersIDs: [''],
      followedBzzIDs: [''],
    );
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}