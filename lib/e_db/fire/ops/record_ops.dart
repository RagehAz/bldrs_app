import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
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
  @required ModelType modelType,
  @required int limit,
  @required bool addDocSnapshotToEachMap,
}) async {

  final List<Map<String, dynamic>> _foundMaps = await FireSearch.mapsByTwoValuesEqualTo(
    context: context,
    collName: FireColl.records,
    fieldA: 'userID',
    valueA: userID,
    fieldB: 'modelType',
    valueB: RecordModel.cipherModelType(modelType),
    addDocsIDs: true, /// super important
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    limit: limit,
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
