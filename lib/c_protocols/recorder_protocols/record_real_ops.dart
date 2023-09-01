import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class RecordersRealOps {
  // -----------------------------------------------------------------------------

  const RecordersRealOps();

  // -----------------------------------------------------------------------------

  /// PATH

  // --------------------
  /// DEPRECATED
  /*
  static String? createRecordTypeRealPathX({
    required RecordType? recordType,
    required String? bzID,
    required String? flyerID,
  }){

    if (recordType == null && bzID == null && flyerID == null && Authing.userHasID() == false){
      return null;
    } else {

      switch (recordType) {

        // case RecordType.session:
        //   return RealPath.recorders_users_userID_records(
        //     userID: Authing.getUserID()!,
        //   );

        // case RecordType.review:
        //    return RealPath.recorders_users_userID_records(
        //     userID: Authing.getUserID()!,
        //   );

        // case RecordType.call:
        //   if (bzID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_bzz_bzID_recordingCalls(bzID: bzID);

        // case RecordType.follow:
        //   if (bzID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_bzz_bzID_recordingFollows(bzID: bzID);

        // case RecordType.unfollow:
        //   if (bzID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_bzz_bzID_recordingFollows(bzID: bzID);

        // case RecordType.share:
        //   if (bzID == null || flyerID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_flyers_bzID_flyerID_recordingShares(
        //     bzID: bzID,
        //     flyerID: flyerID,
        //   );

        // case RecordType.view:
        //   if (bzID == null || flyerID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_flyers_bzID_flyerID_recordingViews(
        //     bzID: bzID,
        //     flyerID: flyerID,
        //   );

        // case RecordType.save:
        //   if (bzID == null || flyerID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_flyers_bzID_flyerID_recordingSaves(
        //     bzID: bzID,
        //     flyerID: flyerID,
        //   );

        // case RecordType.unSave:
        //   if (bzID == null || flyerID == null){
        //     return null;
        //   }
        //   return RealPath.recorders_flyers_bzID_flyerID_recordingSaves(
        //     bzID: bzID,
        //     flyerID: flyerID,
        //   );

        // default:
        //   return null;
      }
    }
  }
   */
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<RecordModel?> createRecord({
    required RecordModel? record,
    required String? path,
  }) async {

    /// NOTE : if record has recordID initialized : its used automatically as docName
    /// otherwise, a random doc name is created

    Map<String, dynamic>? _map;

    if (
        record != null
        &&
        Authing.userHasID() == true
        &&
        path != null
    ){

      _map = await Real.createDocInPath(
        pathWithoutDocName: path,
        map: record.toMap(toJSON: true), // real db is json
        doc: record.recordID,
      );

    }

    final RecordModel? _output = RecordModel.decipherRecord(
      map: _map,
      bzID: record?.bzID,
      flyerID: record?.flyerID,
      fromJSON: true,
    );

    // _output?.blogRecord(invoker: 'createRecord this aho');

    return _output;
  }
  // -----------------------------------------------------------------------------
}
