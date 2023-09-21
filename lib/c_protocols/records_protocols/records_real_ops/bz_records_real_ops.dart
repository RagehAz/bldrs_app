import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/bz_call_model.dart';
import 'package:bldrs/a_models/g_statistics/records/bz_follow_model.dart';
import 'package:bldrs/c_protocols/records_protocols/records_real_ops/flyer_records_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class BzRecordsRealOps {
  // -----------------------------------------------------------------------------

  const BzRecordsRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzCallModel?> createCallRecord({
    required BzCallModel model,
    required String bzID,
  }) async {

    final Map<String, dynamic>? _map = await Real.createDocInPath(
        pathWithoutDocName: RealPath.records_bzz_bzID_recordingCalls(
            bzID: bzID,
        ),
        map: model.toMap(),
    );

    if (_map == null){
      return null;
    }

    else {
      return model.copyWith(
        id: _map['id'],
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createFollowRecord({
    required BzFollowModel bzFollowModel,
    required String bzID,
  }) async {

    await Real.updateDocField(
        coll: RealColl.records,
        doc: '${RealDoc.records_bzz}/$bzID/${RealDoc.records_bzz_bzID_recordingFollows}',
        field: bzFollowModel.toPairKey(),
        value: bzFollowModel.toPairValue(),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzFollowModel?> readFollow({
    required String userID,
    required String bzID,
  }) async {

    final int? _time = await Real.readPath(
        path: '${RealPath.records_bzz_bzID_recordingFollows(bzID: bzID,)}/$userID',
    );

    if (_time == null){
      return null;
    }
    else {
      return BzFollowModel.decipherFollow(
          userID: userID,
          cipheredTime: _time,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzCounterModel> readBzCounter({
    required String bzID,
  }) async {
    BzCounterModel _output;

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: RealPath.records_bzz_bzID_counter(bzID: bzID),
    );

    if (_map == null){
      _output = BzCounterModel.createInitialModel(bzID);
    }
    else {
      _output = BzCounterModel.decipherCounterMap(
        map: _map,
        bzID: bzID,
      )!;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementBzCounter({
    required String bzID,
    required String field,
    required int increment,
  }) async {

    await Real.incrementPathFields(
      path: RealPath.records_bzz_bzID_counter(bzID: bzID),
      incrementationMap: {field: increment},
      isIncrementing: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> decrementsOnFlyerDeletion({
    required String bzID,
    required String flyerID,
    required int numberOfSlides,
  }) async {

    final FlyerCounterModel? _flyerCounterModel = await FlyerRecordsRealOps.readFlyerCounter(
      flyerID: flyerID,
      bzID: bzID,
    );

    await Real.incrementPathFields(
          path: RealPath.records_bzz_bzID_counter(bzID: bzID),
          incrementationMap: {
            BzCounterModel.field_allSlides: numberOfSlides,
            BzCounterModel.field_allReviews: _flyerCounterModel?.reviews ?? 0,
            BzCounterModel.field_allViews: _flyerCounterModel?.views ?? 0,
            BzCounterModel.field_allShares: _flyerCounterModel?.shares ?? 0,
            BzCounterModel.field_allSaves: _flyerCounterModel?.saves ?? 0,
          },
          isIncrementing: false, // DECREMENT
        );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFollow({
    required String userID,
    required String bzID,
  }) async {

    await Real.deletePath(
        pathWithDocName: '${RealPath.records_bzz_bzID_recordingFollows(bzID: bzID)}/$userID',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzRecords({
    required String bzID,
  }) async {
    await Real.deletePath(
      pathWithDocName: RealPath.records_bzz_bzID(
        bzID: bzID,
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
