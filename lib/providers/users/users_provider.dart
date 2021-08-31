import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
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

      Map<String, dynamic> _map = doc.data() as Map;

      return UserModel(
        userID : _map['userID'] ?? '',
        joinedAt : Timers.decipherDateTimeString(_map['joinedAt'] ?? ''),
        userStatus : UserModel.decipherUserStatus(_map['userStatus']?? 1),
        // -------------------------
        name : _map['name'] ?? '',
        pic : _map['pic'] ?? '',
        title : _map['title'] ?? '',
        company : _map['company'] ?? '',
        gender : UserModel.decipherGender(_map['gender'] ?? 2),
        zone : _map['zone'] ?? '',
        language : _map['language'] ?? 'en',
        position : _map['position'] ?? GeoPoint(0, 0),
        contacts : ContactModel.decipherContactsMaps(_map['contacts'] ?? []),
        // -------------------------
        myBzzIDs: _map['myBzzIDs'] ?? [],
        authBy: _map['authBy'] ?? null, /// TASK : user auth by in stream,
        emailIsVerified: _map['emailIsVerified'] ?? false, /// TASK : make sure about this,

      );
    }).toList();

  }

// -----------------------------------------------------------------------------
  /// UserModel from Snapshot
  static UserModel _userModelFromSnapshot(DocumentSnapshot doc) {
    UserModel _userModel;
    Map<String, dynamic> _mapa = {};

    if (doc != null) {
      try {
        Map<String, dynamic> _map = doc.data() as Map;

        _mapa = _map;

        List<dynamic> _myBzzIDs = _map == null
            ? []
            : _map['myBzzIDs'] == null
                ? []
                : _map['myBzzIDs'] as List<dynamic>;

        _userModel = UserModel(
          userID: _map['userID'] ?? '',
          joinedAt: Timers.decipherDateTimeString(_map['joinedAt'] ?? ''),
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
          myBzzIDs: _myBzzIDs ?? [],
          emailIsVerified: _map['emailIsVerified'] ?? false,
          authBy: UserModel.decipherAuthBy(_map['authBy']) ?? AuthBy.Unknown,
        );
      } catch (error) {
        print('_userModelFromSnapshot error is : $error : _map[\'authBy\'] : ${_mapa['authBy']}');
        throw (error);
      }
    }

    return _userModel;
  }

// -----------------------------------------------------------------------------
  /// get users streams
  Stream<List<UserModel>> get allUsersStream {
    CollectionReference _userCollection = UserOps().userCollectionRef();
    return _userCollection.snapshots().map(_usersListFromSnapshot);
  }

// -----------------------------------------------------------------------------
  /// get user doc stream
  Stream<UserModel> get userData {
    CollectionReference _userCollection = UserOps().userCollectionRef();
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
    Map<String, dynamic> _savedFlyersMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.subUserSaves,
      subDocName: FireCollection.flyers,
    );

    print('saved flyers on db are : ${_savedFlyersMap.toString()}');
    return _savedFlyersMap == null ? {} : _savedFlyersMap;
  }
}
