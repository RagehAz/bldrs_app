import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// an alert error should be thrown when firebase replies with the following line
// Firebase Suthentication Error
// An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
// we should consider same scenario with other auth methods that have this conflict with existing signed up e-mail

Future<UserCredential> signInWithFacebook() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    final AccessToken accessToken = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential credential = FacebookAuthProvider.credential(
      accessToken.token,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
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
      country: "egy",
      language: "en",
      position: GeoPoint(0, 0),
      contacts: [
        ContactModel(contact: user.email, contactType: ContactType.Email)
      ],
      // -------------------------
      savedFlyersIDs: [''],
      followedBzzIDs: [''],
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FacebookAuthException catch (e) {
    // handle the FacebookAuthException
    print("Facebook Authentication Error");
    print(e.message);
  } on FirebaseAuthException catch (e) {
    // handle the FirebaseAuthException
    print("Firebase Suthentication Error");
    print(e.message);
  } finally {}
  return null;
}
