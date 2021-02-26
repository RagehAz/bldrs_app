import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// an alert error should be thrown when firebase replies with the following line
// Firebase Suthentication Error
// An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
// we should consider same scenario with other auth methods that have this conflict with existing signed up e-mail

// need to fix if user signed in with facebook previously,, use the existing proile and not overwrite the existing user profile data
// === === === === === === === === === === === === === === === === === === ===
Future<UserCredential> signUpWithFacebook(BuildContext context, Zone zone) async {
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
    /// create a new firestore document for the user with the userID
    await UserProvider(userID: user.uid).updateUserData(
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
      contacts: <ContactModel>[
        ContactModel(
            value: user.email,
            type: ContactType.Email
        ),
        ContactModel(
            value: user.phoneNumber,
            type: ContactType.Phone,
        ),

      ],
      // -------------------------
      savedFlyersIDs: [''],
      followedBzzIDs: [''],
    );
    // -------------------------
    /// Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    // -------------------------
  } on FacebookAuthException catch (e) {
    // handle the FacebookAuthException
    print("Facebook Authentication Error");
    print(e.message);
  } on FirebaseAuthException catch (e) {
    // handle the FirebaseAuthException
    print("Firebase Authentication Error");
    print(e.message);
  } finally {}
  return null;
}


dynamic signInWithFacebook(BuildContext context) async {

}