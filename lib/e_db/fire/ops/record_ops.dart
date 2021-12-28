import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
Future<void> createRecord({
  @required BuildContext context,
  @required RecordModel record,
}) async {

  // DocumentReference<Object> _docRef =
  await Fire.createDoc(
      context: context,
      collName: FireColl.records,
      input: record.toMap(toJSON: false,)
  );

}

// -----------------------------------------------------------------------------
Future<List<RecordModel>> readRecords({
  @required BuildContext context,
  @required String userID,
  @required ActivityType activityType,
  @required int limit,
  @required bool addDocSnapshotToEachMap,
  DocumentSnapshot<Object> startAfter,
}) async {

  final CollectionReference<Object> _collRef = Fire.getCollectionRef(FireColl.records);
  QuerySnapshot<Object> _collectionSnapshot;

  if (startAfter == null){

    final Query _initialQuery = _collRef
        .where('userID', isEqualTo: userID)
        .where('activityType', isEqualTo: RecordModel.cipherActivityType(activityType))
        .orderBy('timeStamp', descending: true)
        .limit(limit);

    _collectionSnapshot = await _initialQuery.get();
  }

  else {

    final Query _continueQuery = _collRef
        .where('userID', isEqualTo: userID)
        .where('activityType', isEqualTo: RecordModel.cipherActivityType(activityType))
        .orderBy('timeStamp', descending: true)
        .startAfterDocument(startAfter)
        .limit(limit);

    _collectionSnapshot = await _continueQuery.get();
  }

  final List<Map<String, dynamic>> _foundMaps = Mapper.getMapsFromQuerySnapshot(
    querySnapshot: _collectionSnapshot,
    addDocsIDs: true,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );

  final List<RecordModel> _records = RecordModel.decipherRecords(
    fromJSON: false,
    maps: _foundMaps,
  );

  return _records;
}
// -----------------------------------------------------------------------------
Future<void> deleteRecord({
  @required BuildContext context,
  @required String recordID,
}) async {

  await Fire.deleteDoc(
      context: context,
      collName: FireColl.records,
      docName: recordID,
  );

}
// -----------------------------------------------------------------------------
