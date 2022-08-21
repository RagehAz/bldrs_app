import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

class UserLDBOps {
// -----------------------------------------------------------------------------

  const UserLDBOps();

// -----------------------------------------------------------------------------

  /// CREATE

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertUserModel(UserModel userModel) async {

    if (userModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.users,
        input: userModel.toMap(
          toJSON: true,
        ),
      );

    }

  }
// ---------------------------------
  static Future<void> insertUsers(List<UserModel> users) async {

    if (Mapper.checkCanLoopList(users) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.users,
        inputs: UserModel.cipherUsers(
          users: users,
          toJSON: true,
        ),
      );

    }

  }
// -----------------------------------------------------------------------------

  /// READ

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.users,
    );

    final List<UserModel> _users = UserModel.decipherUsers(
      maps: _maps,
      fromJSON: true,
    );

    return _users;
  }
// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> readUserOps({
    @required String userID,
  }) async {

    final Map<String, dynamic> _userMap = await LDBOps.searchFirstMap(
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: userID,
      docName: LDBDoc.users,
    );

    UserModel _userModel;

    if (_userMap != null){
      _userModel = UserModel.decipherUser(
        map: _userMap,
        fromJSON: true,
      );
    }

    return _userModel;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateUserModel(UserModel userModel) async {

    if (userModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.users,
        input: userModel.toMap(
          toJSON: true,
        ),
      );

    }

  }
// ---------------------------------
  /*

  DEPRECATED

  static Future<void> addBzIDToMyBzzIDs({
    @required String bzIDToAdd,
    @required UserModel userModel,
  }) async {

    final UserModel _updatedUserModel = userModel.copyWith(
      myBzzIDs: <String>[bzIDToAdd, ...userModel.myBzzIDs],
    );

    await LDBOps.insertMap(
        docName: LDBDoc.users,
        input: _updatedUserModel.toMap(toJSON: true),
    );

  }
   */
// ---------------------------------
  static Future<void> removeBzIDFromMyBzIDs({
    @required String bzIDToRemove,
    @required UserModel userModel,
  }) async {

    // final String _myUserID = superUserID();
    //
    // final UserModel _userModel = await readUserOps(
    //   userID: _myUserID,
    // );

    if (userModel != null){

      final List<String> _myBzzIDs = Stringer.removeStringsFromStrings(
        removeFrom: userModel.myBzzIDs,
        removeThis: <String>[bzIDToRemove],
      );

      final UserModel _updatedModel = userModel.copyWith(
        myBzzIDs: _myBzzIDs,
      );

      await LDBOps.insertMap(
        docName: LDBDoc.users,
        input: _updatedModel.toMap(toJSON: true),
      );

    }

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ---------------------------------
  static Future<void> deleteUserOps(String userID) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.users,
      objectID: userID,
    );

  }
// -----------------------------------------------------------------------------
}
