import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class UserFireSearch{
  // -----------------------------------------------------------------------------

  const UserFireSearch();

  // -----------------------------------------------------------------------------

  /// USERS

  // --------------------
  /// TASK : TEST ME
  static Future<List<UserModel>> usersByUserName({
    @required String name,
    @required List<String> userIDsToExclude,
    QueryDocumentSnapshot<Object> startAfter,
    int limit = 10,
  }) async {

    final List<Map<String, dynamic>> _result = await Fire.readColl(
      addDocSnapshotToEachMap: true,
      startAfter: startAfter,
      queryModel: FireQueryModel(
        coll: FireColl.users,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'trigram',
            comparison: FireComparison.arrayContains,
            value: name.trim(),
          ),
        ],
      ),
    );

    List<UserModel> _usersModels = <UserModel>[];

    if (Mapper.checkCanLoopList(_result)) {
      _usersModels = UserModel.decipherUsers(
        maps: _result,
        fromJSON: false,
      );
    }

    if (Mapper.checkCanLoopList(userIDsToExclude) == true){
      for (final String userID in userIDsToExclude){
        _usersModels.removeWhere((user) => user.id == userID);
      }
    }

    return _usersModels;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<UserModel>> usersByNameAndIsAuthor({
    @required String name,
    int limit = 3,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _result = await Fire.readColl(
      addDocSnapshotToEachMap: true,
      addDocsIDs: true,
      startAfter: startAfter,
      // orderBy: const QueryOrderBy(fieldName: 'trigram', descending: false),
      queryModel: FireQueryModel(
        coll: FireColl.users,
        limit: limit,
        finders: <FireFinder>[

        const FireFinder(
          field: 'myBzzIDs',
          comparison: FireComparison.notEqualTo,
          value: <String>[],
        ),

      if (name != null)
        FireFinder(
          field: 'trigram',
          comparison: FireComparison.arrayContains,
          value: name.trim(),
        ),
      ],
      ),
    );

    List<UserModel> _usersModels = <UserModel>[];

    if (Mapper.checkCanLoopList(_result)) {
      _usersModels = UserModel.decipherUsers(
        maps: _result,
        fromJSON: false,
      );
    }

    return _usersModels;
  }
// -----------------------------------------------------------------------------
}
