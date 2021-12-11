import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/helpers/drafters/tracers.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
  /// FETCHING USER
  Future<UserModel> _fetchUserByID({BuildContext context, String userID}) async {
    UserModel _userModel;

    /// 1 - search in entire LDBs for this userModel
    for (final String doc in LDBDoc.userModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: doc,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchValue: userID,
      );

      if (_map != null && _map != <String, dynamic>{}){
        blog('fetchUserModelByID : UserModel found in local db : $doc');
        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: true);
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_userModel == null){
      blog('fetchUserModelByID : UserModel NOT found in local db');

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
        context: context,
        userID: userID,
      );

      /// 2.2 if found on firebase, store in ldb sessionUsers
      if (_userModel != null){
        blog('fetchUserModelByID : UserModel found in firestore db');

        await LDBOps.insertMap(
          input: _userModel.toMap(toJSON: true),
          docName: LDBDoc.users,
          primaryKey: 'id',
        );

      }

    }

    return _userModel;
  }
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
  UserModel _myUserModel; //UserModel.initializeUserModelStreamFromUser(superFirebaseUser()); needs to be null if didn't find the userModel
// -------------------------------------
  UserModel get myUserModel {
    return _myUserModel;
  }
// -------------------------------------
  Future<void> getsetMyUserModel({BuildContext context}) async {

    UserModel _userModel;

    final String _myUserID = FireAuthOps.superUserID();

    if (_myUserID != null){

      _userModel = await _fetchUserByID(context: context, userID: _myUserID);

    }

    _myUserModel = _userModel;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// USER STREAM
  Stream<UserModel> get myUserModelStream {
    final CollectionReference<Object> _userCollection = UserFireOps.collRef();
    final Stream<UserModel> _stream = _userCollection.doc(_myUserModel?.id).snapshots().map(_userModelFromSnapshot);
    return _stream;
  }
// -------------------------------------
  static UserModel _userModelFromSnapshot(DocumentSnapshot<Object> doc) {
    UserModel _userModel;

    if (doc != null) {

      try {
        final Map<String, dynamic> _map = doc.data() as Map<String, dynamic>;

        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: false);

      }
      on Exception catch (error) {
        blog('_userModelFromSnapshot error is : $error');
        rethrow;
      }
    }

    return _userModel;
  }
// -----------------------------------------------------------------------------

}
