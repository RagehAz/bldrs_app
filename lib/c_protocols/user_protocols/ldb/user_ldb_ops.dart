import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/a_user/draft/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';

/// => TAMAM
class UserLDBOps {
  // -----------------------------------------------------------------------------

  const UserLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertUserModel(UserModel? userModel) async {

    if (userModel != null){

      await LDBOps.insertMap(
        // allowDuplicateIDs: false,
        docName: LDBDoc.users,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.users),
        input: userModel.toMap(
          toJSON: true,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertUsers(List<UserModel>? users) async {

    if (Lister.checkCanLoop(users) == true){

      await LDBOps.insertMaps(
        // allowDuplicateIDs: false,
        docName: LDBDoc.users,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.users),
        inputs: UserModel.cipherUsers(
          users: users!,
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

    return UserModel.cleanDuplicateUsers(
      users: _users,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> readUserOps({
    required String? userID,
  }) async {

    final Map<String, dynamic>? _userMap = await LDBOps.searchFirstMap(
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: userID,
      docName: LDBDoc.users,
    );

    UserModel? _userModel;

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
  static Future<void> updateUserModel(UserModel? userModel) async {

    if (userModel != null){

      await LDBOps.insertMap(
        // allowDuplicateIDs: false,
        docName: LDBDoc.users,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.users),
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
  static Future<void> deleteUserOps(String? userID) async {

    if (userID != null){

      await LDBOps.deleteMap(
        docName: LDBDoc.users,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.users),
        objectID: userID,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// EDITOR SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveEditorSession({
    required DraftUser? draft,
  }) async {

    if (draft != null){

      await LDBOps.insertMap(
        docName: LDBDoc.userEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.userEditor),
        input: draft.toLDB(),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftUser?> loadEditorSession({
    required String? userID,
  }) async {
    DraftUser? _draft;

    if (userID != null) {

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: <String>[userID],
        docName: LDBDoc.userEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.userEditor),
      );

      if (Lister.checkCanLoop(_maps) == true) {
        _draft = DraftUser.fromLDB(_maps.first);
      }

    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeEditorSession(String? userID) async {

    await LDBOps.deleteMap(
      objectID: userID,
      docName: LDBDoc.userEditor,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.userEditor),
    );

  }
  // -----------------------------------------------------------------------------
}
