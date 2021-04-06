import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
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
        country : doc.data()['country'] ?? '',
        province :  doc.data()['province'] ?? '',
        area :  doc.data()['area'] ?? '',
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
      var _doc = doc.data();

      List<dynamic> _myBzzIDs = _doc['myBzzIDs'] == null ? [] : _doc['myBzzIDs'] as List<dynamic>;

      return UserModel(
        userID : _doc['userID'] ?? '',
        joinedAt : decipherDateTimeString(_doc['joinedAt'] ?? ''),
        userStatus : UserModel.decipherUserStatus(_doc['userStatus']?? 1),
        // -------------------------
        name : _doc['name'] ?? '',
        pic : _doc['pic'] ?? '',
        title : _doc['title'] ?? '',
        company : _doc['company'] ?? '',
        gender : UserModel.decipherGender(_doc['gender'] ?? 2),
        country : _doc['country'] ?? '',
        province : _doc['province'] ?? '',
        area : _doc['area'] ?? '',
        language : _doc['language'] ?? 'en',
        position : _doc['position'] ?? GeoPoint(0, 0),
        contacts : ContactModel.decipherContactsMaps(_doc['contacts'] ?? []),
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
    CollectionReference _userCollection = UserCRUD().userCollectionRef();
    return _userCollection.snapshots()
        .map(_usersListFromSnapshot);
  }
// ---------------------------------------------------------------------------
  /// get user doc stream
  Stream<UserModel> get userData {
    CollectionReference _userCollection = UserCRUD().userCollectionRef();
    return _userCollection.doc(userID).snapshots()
        .map(_userModelFromSnapshot);
  }
// ---------------------------------------------------------------------------
Future<UserModel> getUserModel(BuildContext context, String userID) async {
  Map<String, dynamic> _userMap = await getFireStoreDocumentMap(
    context: context,
    collectionName: FireStoreCollection.users,
    documentName: userID,
  );
  UserModel _userModel = UserModel.decipherUserMap(_userMap);
  return _userModel;
}
// ---------------------------------------------------------------------------
}
