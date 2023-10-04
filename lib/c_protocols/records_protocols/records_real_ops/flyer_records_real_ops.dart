import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_save_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_share_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_view_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class FlyerRecordsRealOps {
  // -----------------------------------------------------------------------------

  const FlyerRecordsRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createViewRecord({
    required FlyerViewModel model,
    required String flyerID,
    required String bzID,
  }) async {

    final String? _key = model.toPairKey();

    if (_key != null){

      await Real.updateDocField(
          coll: RealColl.records,
          doc: '${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_recordingViews}',
          field: _key,
          value: model.toMap(),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createSaveRecord({
    required FlyerSaveModel model,
    required String flyerID,
    required String bzID,
  }) async {

      await Real.updateDocField(
          coll: RealColl.records,
          doc: '${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_recordingSaves}',
          field: model.userID,
          value: model.toMap(),
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerShareModel?> createShareRecord({
    required FlyerShareModel? model,
    required String flyerID,
    required String bzID,
  }) async {
    FlyerShareModel? _output;

    if (model != null){
      final Map<String, dynamic>? _map = await Real.createDocInPath(
          pathWithoutDocName: RealPath.records_flyers_bzID_flyerID_recordingShares(
              bzID: bzID,
              flyerID: flyerID,
          ),
          map: model.toMap(),
      );

      if (_map != null){
        _output = model.copyWith(
            id: _map['id'],
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerViewModel?> readView({
    required String flyerID,
    required String bzID,
    required String userID,
    required int index,
  }) async {
    FlyerViewModel? _output;

    final String? _key = FlyerViewModel.createID(
        userID: userID,
        index: index,
    );

    if (_key != null){

      final String _directory = RealPath.records_flyers_bzID_flyerID_recordingViews(
            bzID: bzID,
            flyerID: flyerID
        );

      final String _path = '$_directory/$_key';

      final Map<String, dynamic>? _map = await Real.readPath(
          path: _path,
      );

      if (_map != null){

        _output = FlyerViewModel.decipher(
            viewID: _key,
            map: _map,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerSaveModel?> readSave({
    required String flyerID,
    required String bzID,
    required String userID,
  }) async {

    final String _directory = RealPath.records_flyers_bzID_flyerID_recordingSaves(
        bzID: bzID,
        flyerID: flyerID
    );
    final String _path = '$_directory/$userID';

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: _path,
    );

    return FlyerSaveModel.decipher(
      map: _map,
      userID: userID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerCounterModel> readFlyerCounter({
    required String bzID,
    required String flyerID,
  }) async {
    FlyerCounterModel _output;

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: RealPath.records_flyers_bzID_flyerID_counter(
        bzID: bzID,
        flyerID: flyerID,
      ),
    );

    if (_map == null){
      _output = FlyerCounterModel.createInitialModel(flyerID);
    }
    else {
      _output = FlyerCounterModel.decipherCounterMap(
        map: _map,
        flyerID: flyerID,
      )!;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyerCounter({
    required String bzID,
    required String flyerID,
    required String field,
    required int increment,
  }) async {

    await Real.incrementPathFields(
      path: RealPath.records_flyers_bzID_flyerID_counter(
        bzID: bzID,
        flyerID: flyerID,
      ),
      incrementationMap: {field: increment},
      isIncrementing: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteSaveRecord({
    required String flyerID,
    required String bzID,
    required String userID,
  }) async {

    final String _directory = RealPath.records_flyers_bzID_flyerID_recordingSaves(
        bzID: bzID,
        flyerID: flyerID
    );
    final String _path = '$_directory/$userID';

    await Real.deletePath(
        pathWithDocName: _path,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllFlyerRecords({
    required String bzID,
    required String flyerID,
  }) async {

    await Real.deletePath(
      pathWithDocName: RealPath.records_flyers_bzID_flyerID(
        bzID: bzID,
        flyerID: flyerID,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzFlyersRecords({
    required String bzID,
  }) async {
    await Real.deletePath(
      pathWithDocName: RealPath.records_flyers_bzID(
        bzID: bzID,
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
