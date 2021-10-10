import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
class UserProvider {
  final String userID;

  UserProvider({this.userID});
// -----------------------------------------------------------------------------
//   /// users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data()['savedFlyersIDs']);
      // List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      // List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      // List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;

      final Map<String, dynamic> _map = doc.data() as Map;

      return UserModel(
        userID: _map['userID'] ?? '',
        createdAt: _map['createdAt'].toDate(),
        userStatus: UserModel.decipherUserStatus(_map['userStatus'] ?? 1),
        // -------------------------
        name: _map['name'] ?? '',
        pic: _map['pic'] ?? '',
        title: _map['title'] ?? '',
        company: _map['company'] ?? '',
        gender: UserModel.decipherGender(_map['gender'] ?? 2),
        zone: _map['zone'] ?? '',
        language: _map['language'] ?? 'en',
        position: _map['position'] ?? GeoPoint(0, 0),
        contacts: ContactModel.decipherContactsMaps(_map['contacts'] ?? []),
        // -------------------------
        myBzzIDs: _map['myBzzIDs'] ?? <dynamic>[],
        authBy: _map['authBy'] ?? null,

        /// TASK : user auth by in stream,
        emailIsVerified: _map['emailIsVerified'] ?? false,

        /// TASK : make sure about this,
        isAdmin: _map['isAdmin'] ?? false,
        fcmToken: FCMToken.decipherFCMToken(_map['fcmToken']) ?? null,
      );
    }).toList();
  }

// -----------------------------------------------------------------------------
  /// UserModel from Snapshot
  static UserModel _userModelFromSnapshot(DocumentSnapshot doc) {
    UserModel _userModel;

    if (doc != null) {
      try {
        Map<String, dynamic> _map = doc.data() as Map;


        List<dynamic> _myBzzIDs = _map == null ?
        <dynamic>[]
            :
        _map['myBzzIDs'] == null ?
        <dynamic>[]
            :
        _map['myBzzIDs'] as List<dynamic>;

        _userModel = UserModel(
          userID: _map['userID'] ?? '',
          createdAt: _map['createdAt'].toDate() ?? null,
          userStatus: UserModel.decipherUserStatus(_map['userStatus'] ?? 1),
          // -------------------------
          name: _map['name'] ?? '',
          pic: _map['pic'] ?? '',
          title: _map['title'] ?? '',
          company: _map['company'] ?? '',
          gender: UserModel.decipherGender(_map['gender'] ?? 2),
          zone: Zone.decipherZoneMap(_map['zone']) ?? null,
          language: _map['language'] ?? 'en',
          position: _map['position'] ?? GeoPoint(0, 0),
          contacts: ContactModel.decipherContactsMaps(_map['contacts'] ?? []),
          // -------------------------
          myBzzIDs: _myBzzIDs ?? <String>[],
          emailIsVerified: _map['emailIsVerified'] ?? false,
          authBy: UserModel.decipherAuthBy(_map['authBy']) ?? AuthBy.Unknown,
          isAdmin: _map['isAdmin'] ?? false,
          fcmToken: FCMToken.decipherFCMToken(_map['fcmToken']) ?? null,
        );
      } catch (error) {
        print(
            '_userModelFromSnapshot error is : $error');
        throw (error);
      }
    }

    return _userModel;
  }

// -----------------------------------------------------------------------------
  /// get users streams
  Stream<List<UserModel>> get allUsersStream {
    final CollectionReference _userCollection = UserOps().userCollectionRef();
    return _userCollection.snapshots().map(_usersListFromSnapshot);
  }

// -----------------------------------------------------------------------------
  /// get user doc stream
  Stream<UserModel> get userData {
    final CollectionReference _userCollection = UserOps().userCollectionRef();
    return _userCollection.doc(userID).snapshots().map(_userModelFromSnapshot);
  }
// -----------------------------------------------------------------------------
// Future<UserModel> getUserModel(BuildContext context, String userID) async {
//   Map<String, dynamic> _userMap = await Fire.readDoc(
//     context: context,
//     collName: FireCollection.users,
//     docName: userID,
//   );
//   UserModel _userModel = UserModel.decipherUserMap(_userMap);
//   return _userModel;
// }
// -----------------------------------------------------------------------------

  Future<dynamic> getSavedFlyersIDs(BuildContext context) async {
    // final Map<String, dynamic> _savedFlyersMap = await Fire.readSubDoc(
    //   context: context,
    //   collName: FireCollection.users,
    //   docName: userID,
    //   subCollName: FireCollection.users_user_records_flyers,
    //   subDocName: FireCollection.flyers,
    // );
    //
    // print('saved flyers on db are : ${_savedFlyersMap.toString()}');
    // return _savedFlyersMap == null ? {} : _savedFlyersMap;

    /// TASK : fix this
    return null;
  }

}
