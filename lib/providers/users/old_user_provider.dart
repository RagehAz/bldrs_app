import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
class OldUserProvider {
  final String userID;

  OldUserProvider({this.userID});
// -----------------------------------------------------------------------------
//   /// users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data()['savedFlyersIDs']);
      // List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      // List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      // List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;

      final Map<String, dynamic> _map = doc.data() as Map;

      final UserModel _userModel = UserModel.decipherUserMap(map: _map, fromJSON: false,);

      return _userModel;

    }).toList();
  }

// -----------------------------------------------------------------------------
  /// UserModel from Snapshot
  static UserModel _userModelFromSnapshot(DocumentSnapshot doc) {
    UserModel _userModel;

    if (doc != null) {
      try {
        Map<String, dynamic> _map = doc.data() as Map;

        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: false);


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
    final CollectionReference _userCollection = UserOps.userCollectionRef();
    return _userCollection.snapshots().map(_usersListFromSnapshot);
  }

// -----------------------------------------------------------------------------
  /// get user doc stream
  Stream<UserModel> get userData {
    final CollectionReference _userCollection = UserOps.userCollectionRef();
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
