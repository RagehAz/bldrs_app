import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
class UserProvider{
  final String userID;

  UserProvider({this.userID});
// ---------------------------------------------------------------------------
  /// users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      // print(doc.data()['savedFlyersIDs']);
      List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      // List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
      return UserModel(
        userID : doc.data()['userID'] ?? '',
        joinedAt : decipherDateTimeString(doc.data()['joinedAt'] ?? ''),
        userStatus : UserModel.decipherUserStatus(doc.data()['userStatus']?? 1),
        // -------------------------
        name : doc.data()['name'] ?? '',
        pic : doc.data()['pic'] ?? '',
        title : doc.data()['title'] ?? '',
        company : doc.data()['company'] ?? '',
        gender : UserModel.decipherGender(doc.data()['gender'] ?? 2),
        zone : doc.data()['zone'] ?? '',
        language : doc.data()['language'] ?? 'en',
        position : doc.data()['position'] ?? GeoPoint(0, 0),
        contacts : ContactModel.decipherContactsMaps(doc.data()['contacts'] ?? []),
        // -------------------------
        myBzzIDs: doc.data()['myBzzIDs'] ?? [],
      );
    }).toList();
  }
// ---------------------------------------------------------------------------
  /// UserModel from Snapshot
  UserModel _userModelFromSnapshot(DocumentSnapshot doc){

    try{
      var _map = doc.data();

      List<dynamic> _myBzzIDs = _map['myBzzIDs'] == null ? [] : _map['myBzzIDs'] as List<dynamic>;

      return UserModel(
        userID : _map['userID'] ?? '',
        joinedAt : decipherDateTimeString(_map['joinedAt'] ?? ''),
        userStatus : UserModel.decipherUserStatus(_map['userStatus']?? 1),
        // -------------------------
        name : _map['name'] ?? '',
        pic : _map['pic'] ?? '',
        title : _map['title'] ?? '',
        company : _map['company'] ?? '',
        gender : UserModel.decipherGender(_map['gender'] ?? 2),
        zone : Zone.decipherZoneMap(_map['zone']) ?? null,
        language : _map['language'] ?? 'en',
        position : _map['position'] ?? GeoPoint(0, 0),
        contacts : ContactModel.decipherContactsMaps(_map['contacts'] ?? []),
        // -------------------------
        myBzzIDs: _myBzzIDs ?? [],
      );

    } catch(error){
      print('_userModelFromSnapshot error is : $error');
      throw(error);
    }
  }
// ---------------------------------------------------------------------------
  /// get users streams
  Stream<List<UserModel>> get allUsersStream {
    CollectionReference _userCollection = UserOps().userCollectionRef();
    return _userCollection.snapshots()
        .map(_usersListFromSnapshot);
  }
// ---------------------------------------------------------------------------
  /// get user doc stream
  Stream<UserModel> get userData {
    CollectionReference _userCollection = UserOps().userCollectionRef();
    return _userCollection.doc(userID).snapshots()
        .map(_userModelFromSnapshot);
  }
// ---------------------------------------------------------------------------
// Future<UserModel> getUserModel(BuildContext context, String userID) async {
//   Map<String, dynamic> _userMap = await Fire.readDoc(
//     context: context,
//     collName: FireCollection.users,
//     docName: userID,
//   );
//   UserModel _userModel = UserModel.decipherUserMap(_userMap);
//   return _userModel;
// }
// ---------------------------------------------------------------------------

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
