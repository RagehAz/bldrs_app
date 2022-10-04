import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class UserLDBOps {
  // -----------------------------------------------------------------------------

  const UserLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
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

  // --------------------
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
  // --------------------
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

  // --------------------
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
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteUserOps(String userID) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.users,
      objectID: userID,
    );

  }
  // -----------------------------------------------------------------------------

  /// EDITOR SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveEditorSession({
    @required UserModel userModel,
  }) async {

    if (userModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.userEditor,
        input: userModel.toMap(toJSON: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> loadEditorSession({
    @required String userID,
  }) async {
    UserModel _user;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: <String>[userID],
      docName: LDBDoc.userEditor,
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _user = UserModel.decipherUser(
        map: _maps.first,
        fromJSON: true,
      );

    }

    return _user;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeEditorSession(String userID) async {

    await LDBOps.deleteMap(
      objectID: userID,
      docName: LDBDoc.userEditor,
    );

  }
  // -----------------------------------------------------------------------------

}
