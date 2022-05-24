import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserFireSearch{

  UserFireSearch();

// -----------------------------------------------------------------------------

  /// USERS

// -----------------------------------------------
  static Future<List<UserModel>> usersByUserName({
    @required BuildContext context,
    @required String name,
  }) async {
    // /// WORK GOOD WITH 1 SINGLE WORD FIELDS,, AND SEARCHES BY MATCHES THE INITIAL CHARACTERS :
    // /// 'Rag' --->    gets [Rageh Mohamed]
    // /// 'geh' -/->    doesn't get [Rageh Mohamed]
    // /// 'Moh' -/->    doesn't get [Rageh Mohamed]
    // /// 'Mohamed -/-> doesn't get [Rageh Mohamed]
    // QuerySnapshot<Map<String, dynamic>> _snapshots = await Fire.getCollectionRef(FireCollection.users).orderBy("name").where("name",isGreaterThanOrEqualTo: compareValue).where("name",isLessThanOrEqualTo: compareValue+"z").get();

    // QuerySnapshot<Map<String, dynamic>> _snapshots = await Fire.getCollectionRef(FireCollection.users)
    //     .orderBy("name")
    //     .where("nameTrigram", arrayContainsAny: [compareValue]).get();
    //     // .where("name",isLessThanOrEqualTo: compareValue+"z")
    // List<Map<String, dynamic> >_result = Mapper.getMapsFromQuerySnapshot(
    //   querySnapshot: _snapshots,
    //   addDocsIDs: false,
    // );

    final List<Map<String, dynamic>> _result = await FireSearch.mapsByFieldValue(
      context: context,
      collName: FireColl.users,
      field: 'trigram',
      compareValue: name.trim(),
      valueIs: FireSearch.ValueIs.arrayContains,
    );

    List<UserModel> _usersModels = <UserModel>[];

    if (Mapper.canLoopList(_result)) {
      _usersModels = UserModel.decipherUsersMaps(
        maps: _result,
        fromJSON: false,
      );
    }

    _usersModels.removeWhere((user) => user.id == superUserID());

    return _usersModels;
  }
// -----------------------------------------------
  static Future<List<UserModel>> usersByNameAndIsAuthor({
    @required BuildContext context,
    @required String name,
    int limit = 3,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
  }) async {
    List<UserModel> _usersModels = <UserModel>[];

    await tryAndCatch(
        context: context,
        methodName: 'usersByNameAndIsAuthor',
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

          if (Mapper.canLoopList(_maps)) {
            _usersModels =
                UserModel.decipherUsersMaps(maps: _maps, fromJSON: false);
          }
        });

    return _usersModels;
  }
// -----------------------------------------------------------------------------

}
