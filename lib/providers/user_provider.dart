import 'package:bldrs/db/firestore/auth_ops.dart';
import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
//   /// FETCHING USER
//   Future<UserModel> _fetchUserByID({BuildContext context, String userID}) async {
//     UserModel _userModel;
//
//     /// 1 - search in entire LDBs for this userModel
//     for (String doc in LDBDoc.userModelsDocs){
//
//       final Map<String, Object> _map = await LDBOps.searchMap(
//         docName: doc,
//         fieldToSortBy: 'userID',
//         searchField: 'userID',
//         searchValue: userID,
//       );
//
//       if (_map != null && _map != {}){
//         print('fetchUserModelByID : UserModel found in local db : ${doc}');
//         _userModel = UserModel.decipherUserMap(_map);
//         break;
//       }
//
//     }
//
//     /// 2 - if not found, search firebase
//     if (_userModel == null){
//       print('fetchUserModelByID : UserModel NOT found in local db');
//
//       /// 2.1 read firebase UserOps
//       _userModel = await UserOps().readUserOps(
//         context: context,
//         userID: userID,
//       );
//
//       /// 2.2 if found on firebase, store in ldb sessionUsers
//       if (_userModel != null){
//         print('fetchUserModelByID : UserModel found in firestore db');
//
//         await LDBOps.insertMap(
//           input: _userModel.toMap(),
//           docName: LDBDoc.sessionUsers,
//         );
//
//       }
//
//     }
//
//     return _userModel;
//   }
// // -------------------------------------
//   /// fetch Users By IDs
//   Future<List<UserModel>> _fetchUsersByIDs({BuildContext context, List<String> usersIDs}) async {
//     List<UserModel> _userModels = <UserModel>[];
//
//     if (usersIDs != null && usersIDs.isNotEmpty){
//
//       for (String userID in usersIDs){
//
//         final UserModel _userModel = await _fetchUserByID(context: context, userID: userID);
//
//         if (_userModel != null){
//
//           _userModels.add(_userModel);
//
//         }
//
//       }
//
//     }
//
//     return _userModels;
//   }

// -----------------------------------------------------------------------------
  /// MY USER MODEL
  UserModel _myModel; //UserModel.initializeUserModelStreamFromUser(superFirebaseUser()); needs to be null if didn't find the userModel
// -------------------------------------
  UserModel get myUserModel {
    return _myModel;
  }
// -------------------------------------
  Future<void> fetchMyUserModel({BuildContext context}) async {

    UserModel _userModel;

    final String _userID = superUserID();

    if (_userID != null){

      /// search myUserModel LDB
      final Map<String, Object> _map = await LDBOps.searchMap(
        docName: LDBDoc.myUserModel,
        fieldToSortBy: 'userID',
        searchField: 'userID',
        searchValue: _userID,
      );

      /// if not found in LDB
      if (_map == null){

        /// search firebase
        final UserModel _firebaseUserModel =  await UserOps.readUserOps(
          context: context,
          userID: _userID,
        );

        /// if found in firebase
        if (_firebaseUserModel != null){
          /// insert in LDB
          await LDBOps.insertMap(
            docName: LDBDoc.myUserModel,
            input: _firebaseUserModel.toMap(toJSON: true),
          );

          _userModel = _firebaseUserModel;
        }

      }

      /// if found in LDB
      else {
        _userModel = UserModel.decipherUserMap(
          map: _map,
          fromJSON: true,
        );
      }


    }

    _myModel = _userModel;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// USER STREAM
  Stream<UserModel> get userStream {
    final CollectionReference _userCollection = UserOps.userCollectionRef();
    final Stream<UserModel> _stream = _userCollection.doc(_myModel.userID).snapshots().map(_userModelFromSnapshot);
    return _stream;
  }
// -------------------------------------
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

}