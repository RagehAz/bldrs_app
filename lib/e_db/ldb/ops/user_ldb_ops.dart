import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
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
  static Future<void> removeBzIDFromMyBzIDs({
    @required String bzIDToRemove,
}) async {

    final String _myUserID = superUserID();

    final UserModel _userModel = await readUserOps(
      userID: _myUserID,
    );

    if (_userModel != null){

      final List<String> _myBzzIDs = removeStringsFromStrings(
        removeFrom: _userModel.myBzzIDs,
        removeThis: <String>[bzIDToRemove],
      );

      final UserModel _updatedModel = _userModel.copyWith(
        myBzzIDs: _myBzzIDs,
      );

      await LDBOps.updateMap(
        docName: LDBDoc.users,
        input: _updatedModel.toMap(toJSON: true),
        objectID: _myUserID,
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
