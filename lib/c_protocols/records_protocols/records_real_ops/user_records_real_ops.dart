import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/g_statistics/counters/user_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/user_record_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class UserRecordsRealOps {
  // -----------------------------------------------------------------------------

  const UserRecordsRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserRecordModel?> createUserRecord({
    required UserRecordModel? record,
  }) async {
    UserRecordModel? _output;

    if (record?.userID != null && record?.time != null){

      final String? _path = RealPath.records_users_userID_records_date(
        userID: record!.userID,
        time: record.time!,
      );

      if (_path != null){

        Map<String, dynamic>? _map = await Real.createDocInPath(
          pathWithoutDocName: _path,
          map: record.toMap(),
        );

        if (_map != null){

          _map = Mapper.insertPairInMap(
              key: 'userID',
              value: record.userID,
              overrideExisting: true,
              map: _map,
          );

          _output = record.copyWith(
            id: _map['id'],
          );

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserRecordModel>> readAllUserRecords({
    required String userID,
  }) async {

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: RealPath.records_users_userID_records(userID: userID),
    );

    return UserRecordModel.decipherAllUserRecordsMap(
      map: _map,
      userID: userID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserCounterModel> readUserCounter({
    required String userID,
  }) async {
    UserCounterModel _output;

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: RealPath.records_users_userID_counter(userID: userID),
    );

    if (_map == null){
      _output = UserCounterModel.createInitialModel(userID);
    }
    else {
      _output = UserCounterModel.decipherUserCounter(
        map: _map,
        userID: userID,
      )!;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementUserCounter({
    required String userID,
    required int increment,
    required String field,
  }) async {

    await Real.incrementPathFields(
      path: RealPath.records_users_userID_counter(
          userID: userID
      ),
      incrementationMap: {field: increment},
      isIncrementing: true,
    );

  }
  // -----------------------------------------------------------------------------
}
