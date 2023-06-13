import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class RecordersRealOps {
  // -----------------------------------------------------------------------------

  const RecordersRealOps();

  // -----------------------------------------------------------------------------

  /// PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createRecordTypeRealPath({
    @required RecordType recordType,
    @required String bzID,
    @required String flyerID,
  }){

    switch (recordType){

      case RecordType.call:
        return RealPath.recorders_bzz_bzID_recordingCalls(bzID: bzID); break;

      case RecordType.follow:
        return RealPath.recorders_bzz_bzID_recordingFollows(bzID: bzID); break;
      case RecordType.unfollow:
        return RealPath.recorders_bzz_bzID_recordingFollows(bzID: bzID); break;

      case RecordType.share:
        assert(flyerID != null, 'flyerID must not be null');
        return RealPath.recorders_flyers_bzID_flyerID_recordingShares(
            bzID: bzID,
            flyerID: flyerID,
        ); break;

      case RecordType.view:
        assert(flyerID != null, 'flyerID must not be null');
        return RealPath.recorders_flyers_bzID_flyerID_recordingViews(
            bzID: bzID,
            flyerID: flyerID,
        ); break;

      case RecordType.save:
        assert(flyerID != null, 'flyerID must not be null');
        return RealPath.recorders_flyers_bzID_flyerID_recordingSaves(
            bzID: bzID,
            flyerID: flyerID,
        ); break;

      case RecordType.unSave:
        assert(flyerID != null, 'flyerID must not be null');
        return RealPath.recorders_flyers_bzID_flyerID_recordingSaves(
            bzID: bzID,
            flyerID: flyerID,
        ); break;

      default: return null;
    }

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

    if (
        record != null
        &&
        Authing.userIsSignedUp() == true
    ){

      final String _path = RecordersRealOps.createRecordTypeRealPath(
        recordType: record.recordType,
        flyerID: record.flyerID,
        bzID: record.bzID,
      );

      _map = await Real.createDocInPath(
        pathWithoutDocName: _path,
        map: record.toMap(toJSON: true), // real db is json
        doc: record.recordID,
      );

    }

    final RecordModel _output = RecordModel.decipherRecord(
      map: _map,
      bzID: record.bzID,
      flyerID: record.flyerID,
      fromJSON: true,
    );

    // _output?.blogRecord(invoker: 'createRecord this aho');

    return _output;
  }
  // -----------------------------------------------------------------------------
}
