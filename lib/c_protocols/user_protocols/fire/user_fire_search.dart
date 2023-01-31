import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class UserFireSearch{
  // -----------------------------------------------------------------------------

  const UserFireSearch();

  // -----------------------------------------------------------------------------

  /// USERS

  // --------------------
  static Future<List<UserModel>> usersByUserName({
    @required String name,
    @required List<String> userIDsToExclude,
    QueryDocumentSnapshot<Object> startAfter,
    int limit = 10,
  }) async {

    final List<Map<String, dynamic>> _result = await Fire.readCollectionDocs(
      collName: FireColl.users,
      addDocSnapshotToEachMap: true,
      limit: limit,
      startAfter: startAfter,
      finders: <FireFinder>[
        FireFinder(
          field: 'trigram',
          comparison: FireComparison.arrayContains,
          value: name.trim(),
        ),
      ],
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
  static Future<List<UserModel>> usersByNameAndIsAuthor({
    @required String name,
    int limit = 3,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
  }) async {
    List<UserModel> _usersModels = <UserModel>[];

    await tryAndCatch(
        invoker: 'usersByNameAndIsAuthor',
        functions: () async {
          final CollectionReference<Object> _usersCollection =
          Fire.getCollectionRef(FireColl.users);

          final QuerySnapshot<Object> _collectionSnapshot = await _usersCollection
              .where('myBzzIDs', isNotEqualTo: <String>[])
              .where('trigram', arrayContains: name.trim().toLowerCase())
              .limit(limit)
              .get();

          final List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: addDocsIDs,
            addDocSnapshotToEachMap: addDocSnapshotToEachMap,
          );

          if (Mapper.checkCanLoopList(_maps)) {
            _usersModels =
                UserModel.decipherUsers(maps: _maps, fromJSON: false);
          }
        });

    return _usersModels;
  }
// -----------------------------------------------------------------------------
}
