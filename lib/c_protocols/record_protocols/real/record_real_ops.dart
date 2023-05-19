import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
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
      RecordModel.cipherRecordType(RecordType.search):         '${RealColl.recordingSearches}/$modelID/',    // modelID = userID
    };

    final String _path = _map[RecordModel.cipherRecordType(recordType)];

    return _path;
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<RecordModel> createRecord({
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
        map: record.toMap(toJSON: true), // real db is json
        doc: record.recordID,
      );

    }

    final RecordModel _output = RecordModel.decipherRecord(
      map: _map,
      fromJSON: true,
    );

    _output?.blogRecord(invoker: 'createRecord this aho');

    return _output;
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
