import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/real/real.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as fireDB;
import 'package:flutter/material.dart';

class RecordRealOps {
// -----------------------------------------------------------------------------

  RecordRealOps();

// -----------------------------------------------------------------------------

  /// PATH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String createRecordTypeRealPath({
    @required RecordType recordType,
    @required String modelID,
  }){

    final Map<String, dynamic> _map = {
      RecordModel.cipherRecordType(RecordType.follow):         'follows/$modelID/',     // modelID = bzID
      RecordModel.cipherRecordType(RecordType.unfollow):       'follows/$modelID/',     // modelID = bzID
      RecordModel.cipherRecordType(RecordType.call):           'calls/$modelID/',       // modelID = bzID
      RecordModel.cipherRecordType(RecordType.share):          'shares/$modelID/',      // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.view):           'views/$modelID/',       // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.save):           'saves/$modelID/',       // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.unSave):         'saves/$modelID/',       // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.createReview):   'reviews/$modelID/',     // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.editReview):     'reviews/$modelID/',     // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.deleteReview):   'review/$modelID/',      // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.createQuestion): 'questions/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.editQuestion):   'questions/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.deleteQuestion): 'questions/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.createAnswer):   'answers/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.editAnswer):     'answers/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.deleteAnswer):   'answers/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.search):         'searches/$modelID/',    // modelID = userID
    };

    final String _path = _map[RecordModel.cipherRecordType(recordType)];

    return _path;
  }
// -----------------------------------------------------------------------------

  /// CREATE

// ---------------------------------
  /// TESTED : WORKS PERFECT
  static Future<RecordModel> createRecord({
    @required BuildContext context,
    @required RecordModel record,
  }) async {

    /// NOTE : if record has recordID initialized : its used automatically as docName
    /// otherwise, a random doc name is created

    Map<String, dynamic> _map;

    if (record != null){

      final String _path = RecordRealOps.createRecordTypeRealPath(
        recordType: record.recordType,
        modelID: record.modelID,
      );

      _map = await Real.createDocInPath(
        context: context,
        pathWithoutDocName: _path,
        addDocIDToOutput: true,
        map: record.toMap(toJSON: true), // real db is json
        docName: record.recordID,
      );

    }

    return RecordModel.decipherRecord(
        map: _map,
        fromJSON: true,
    );

  }
// -----------------------------------------------------------------------------

/// READ

// ----------------------------------
  static Future<List<RecordModel>> paginateRecords({
    @required BuildContext context,
    @required String userID,
    @required RecordType activityType,
    @required int limit,
    DocumentSnapshot<Object> startAfter,
  }) async {

    final CollectionReference<Object> _collRef = Fire.getCollectionRef(FireColl.records);
    QuerySnapshot<Object> _collectionSnapshot;

    if (startAfter == null){

      final Query _initialQuery = _collRef
          .where('userID', isEqualTo: userID)
          .where('activityType', isEqualTo: RecordModel.cipherRecordType(activityType))
          .orderBy('timeStamp', descending: true)
          .limit(limit);

      _collectionSnapshot = await _initialQuery.get();
    }

    else {

      final Query _continueQuery = _collRef
          .where('userID', isEqualTo: userID)
          .where('activityType', isEqualTo: RecordModel.cipherRecordType(activityType))
          .orderBy('timeStamp', descending: true)
          .startAfterDocument(startAfter)
          .limit(limit);

      _collectionSnapshot = await _continueQuery.get();
    }

    final List<Map<String, dynamic>> _foundMaps = Mapper.getMapsFromQuerySnapshot(
      querySnapshot: _collectionSnapshot,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<RecordModel> _records = RecordModel.decipherRecords(
      fromJSON: false,
      maps: _foundMaps,
    );

    return _records;
  }
// -----------------------------------------------------------------------------

/// COUNTERS

  // ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerCounterModel> incrementFlyerCounter({
    @required BuildContext context,
    @required bool increaseOne, // or decrease one
    @required String flyerID,
    @required String field,
  }) async {

    blog('incrementFlyerCounter : START');

    const String collName = 'flyersCounters';

    await Real.updateDocField(
        context: context,
      collName: collName,
        docName: flyerID,
        fieldName: field,
        value: fireDB.ServerValue.increment(increaseOne ? 1 : -1),
    );

    Map<String, dynamic> _map = await Real.readDocOnce(
      context: context,
      collName: collName,
      docName: flyerID,
    );

    _map = Mapper.insertPairInMap(
        map: _map,
        key: 'flyerID',
        value: flyerID,
    );

    final FlyerCounterModel _model = FlyerCounterModel.decipherCounterMap(_map);

    blog('incrementFlyerCounter : END');

    return _model;
  }
  // ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzCounterModel> incrementBzCounter({
    @required BuildContext context,
    @required String bzID,
    @required String field,
    bool increaseOne, // or decrease one
    int incrementThis,
  }) async {

    assert (
    increaseOne != null || incrementThis != null,
    'incrementBzCounter :YOU FORGOT TO ASSIGN INCREMENTATION VALUE MAN',
    );

    blog('incrementBzCounter : START');

    const String collName = 'bzzCounters';

    final int _value = incrementThis ?? increaseOne ? 1 : -1;

    await Real.updateDocField(
      context: context,
      collName: collName,
      docName: bzID,
      fieldName: field,
      value: fireDB.ServerValue.increment(_value),
    );

    Map<String, dynamic> _map = await Real.readDocOnce(
      context: context,
      collName: collName,
      docName: bzID,
    );

    _map = Mapper.insertPairInMap(
      map: _map,
      key: 'bzID',
      value: bzID,
    );

    final BzCounterModel _model = BzCounterModel.decipherCounterMap(_map);

    blog('incrementBzCounter : END');

    return _model;
  }

// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /* static Future<void> deleteRecord({
    @required BuildContext context,
    @required String recordID,
  }) async {

    await Fire.deleteDoc(
      context: context,
      collName: FireColl.records,
      docName: recordID,
    );

  }
   */
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
