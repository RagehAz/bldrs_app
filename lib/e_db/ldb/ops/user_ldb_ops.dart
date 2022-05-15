import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class UserLDBOps {

  UserLDBOps();
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------------

// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------
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
      _userModel = UserModel.decipherUserMap(
          map: _userMap,
          fromJSON: true,
      );
    }

    return _userModel;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------------
  static Future<void> addBzIDToMyBzzIDs({
    @required String bzIDToAdd,
    @required UserModel userModel,
  }) async {

    final UserModel _updatedUserModel = userModel.copyWith(
      myBzzIDs: <String>[bzIDToAdd, ...userModel.myBzzIDs],
    );

    await LDBOps.updateMap(
        docName: LDBDoc.users,
        objectID: _updatedUserModel.id,
        input: _updatedUserModel.toMap(toJSON: true),
    );

  }
// ----------------------------------------
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

      final List<String> _myBzzIDs = removeStringsFromStrings(
        removeFrom: userModel.myBzzIDs,
        removeThis: <String>[bzIDToRemove],
      );

      final UserModel _updatedModel = userModel.copyWith(
        myBzzIDs: _myBzzIDs,
      );

      await LDBOps.updateMap(
        docName: LDBDoc.users,
        input: _updatedModel.toMap(toJSON: true),
        objectID: _updatedModel.id,
      );

    }

}
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------------
  static Future<void> deleteUserOps({
    @required String userID,
  }) async {

    await LDBOps.deleteMap(
        docName: LDBDoc.users,
        objectID: userID,
    );

  }
// -----------------------------------------------------------------------------
}
