import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

class RecordRealOps {
  // -----------------------------------------------------------------------------

  const RecordRealOps();

  // -----------------------------------------------------------------------------

  /// PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createRecordTypeRealPath({
    @required RecordType recordType,
    @required String modelID,
  }){

    final Map<String, dynamic> _map = {
      RecordModel.cipherRecordType(RecordType.follow):         '${RealColl.recordingFollows}/$modelID/',     // modelID = bzID
      RecordModel.cipherRecordType(RecordType.unfollow):       '${RealColl.recordingFollows}/$modelID/',     // modelID = bzID
      RecordModel.cipherRecordType(RecordType.call):           '${RealColl.recordingCalls}/$modelID/',       // modelID = bzID
      RecordModel.cipherRecordType(RecordType.share):          '${RealColl.recordingShares}/$modelID/',      // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.view):           '${RealColl.recordingViews}/$modelID/',       // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.save):           '${RealColl.recordingSaves}/$modelID/',       // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.unSave):         '${RealColl.recordingSaves}/$modelID/',       // modelID = flyerID
      // RecordModel.cipherRecordType(RecordType.createReview):   '${RealColl.recordingReviews}/$modelID/',     // modelID = flyerID
      // RecordModel.cipherRecordType(RecordType.editReview):     '${RealColl.recordingReviews}/$modelID/',     // modelID = flyerID
      // RecordModel.cipherRecordType(RecordType.deleteReview):   '${RealColl.recordingReviews}/$modelID/',      // modelID = flyerID
      RecordModel.cipherRecordType(RecordType.createQuestion): '${RealColl.recordingQuestions}/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.editQuestion):   '${RealColl.recordingQuestions}/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.deleteQuestion): '${RealColl.recordingQuestions}/$modelID/',   // modelID = questionID
      RecordModel.cipherRecordType(RecordType.createAnswer):   '${RealColl.recordingAnswers}/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.editAnswer):     '${RealColl.recordingAnswers}/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.deleteAnswer):   '${RealColl.recordingAnswers}/$modelID/',     // modelID = questionID
      RecordModel.cipherRecordType(RecordType.search):         '${RealColl.recordingSearches}/$modelID/',    // modelID = userID
    };

    final String _path = _map[RecordModel.cipherRecordType(recordType)];

    return _path;
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<RecordModel> createRecord({ /// TASK : CORRECT NAME REMOVE a
    @required RecordModel record,
  }) async {

    /// NOTE : if record has recordID initialized : its used automatically as docName
    /// otherwise, a random doc name is created

    Map<String, dynamic> _map;

    if (record != null && Authing.userIsSignedIn() == true){

      final String _path = RecordRealOps.createRecordTypeRealPath(
        recordType: record.recordType,
        modelID: record.modelID,
      );

      _map = await Real.createDocInPath(
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

  // --------------------
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

  /// DELETE

  // --------------------
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
