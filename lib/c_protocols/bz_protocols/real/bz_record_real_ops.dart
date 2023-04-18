import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/record_protocols/real/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:filers/filers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class BzRecordRealOps {
  // -----------------------------------------------------------------------------

  const BzRecordRealOps();

  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// FOLLOWS CREATION
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<void> followBz({
    @required String bzID,
  }) async {
    blog('BzRecordOps.followBz : START');

    final RecordModel _record = RecordModel.createFollowRecord(
        userID: OfficialAuthing.getUserID(),
        bzID: bzID
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        record: _record,
      ),

      BzRecordRealOps.incrementBzCounter(
        bzID: bzID,
        field: 'follows',
        increaseOne: true,
      ),

    ]);

    blog('BzRecordOps.followBz : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unfollowBz({
    @required String bzID,
  }) async {
    blog('BzRecordOps.unfollowBz : START');

    final RecordModel _record = RecordModel.createUnfollowRecord(
      userID: OfficialAuthing.getUserID(),
      bzID: bzID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        record: _record,
      ),

      BzRecordRealOps.incrementBzCounter(
        bzID: bzID,
        field: 'follows',
        increaseOne: false,
      ),

    ]);

    blog('BzRecordOps.unfollowBz : END');
  }
  // --------------------
  /// CALLS CREATION
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<void> callBz({
    @required String bzID,
    @required ContactModel contact,
  }) async {
    blog('BzRecordOps.callBz : START');

    final RecordModel _record = RecordModel.createCallRecord(
      userID: OfficialAuthing.getUserID(),
      bzID: bzID,
      contact: contact,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        record: _record,
      ),

      BzRecordRealOps.incrementBzCounter(
        bzID: bzID,
        field: 'calls',
        increaseOne: true,
      ),

    ]);

    blog('BzRecordOps.callBz : END');
  }
  // -----------------------------------------------------------------------------

  /// BZ COUNTERS

  // --------------------
  /// CREATION - UPDATING
  // ---------
  /// TASK : TEST ME
  static Future<BzCounterModel> incrementBzCounter({
    @required String bzID,
    @required String field,
    bool increaseOne, // or decrease one
    int incrementThis,
  }) async {

    assert (
    increaseOne != null || incrementThis != null,
    'incrementBzCounter :YOU FORGOT TO ASSIGN INCREMENTATION VALUE MAN',
    );

    // blog('BzRecordOps.incrementBzCounter : START');

    int _value;
    if (incrementThis == null){
      _value = increaseOne == true ? 1 : -1;
    }
    else {
      _value = incrementThis;
    }

    Map<String, dynamic> _map = await OfficialReal.readDocOnce(
      coll: RealColl.countingBzz,
      doc: bzID,
    );

    if (_value != 0){

      await OfficialReal.updateDocField(
        coll: RealColl.countingBzz,
        doc: bzID,
        field: field,
        value: ServerValue.increment(_value),
      );

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'bzID',
        value: bzID,
      );

    }

    final BzCounterModel _model = BzCounterModel.decipherCounterMap(_map);

    // blog('BzRecordOps.incrementBzCounter : END');

    return _model;
  }
  // --------------------
  /// READING
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<BzCounterModel> readBzCounters({
    @required String bzID,
  }) async {

    final Map<String, dynamic> _map = await OfficialReal.readDocOnce(
      coll: RealColl.countingBzz,
      doc: bzID,
    );

    final BzCounterModel _bzCounters = BzCounterModel.decipherCounterMap(_map);

    return _bzCounters;
  }
  // --------------------
  /// DELETION
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzCountersAndRecords({
    @required String bzID,
  }) async {

    /// FOLLOWS
    await OfficialReal.deleteDoc(
      coll: RealColl.recordingFollows,
      doc: bzID,
    );

    /// CALLS
    await OfficialReal.deleteDoc(
      coll: RealColl.recordingCalls,
      doc: bzID,
    );

    /// BZ COUNTERS
    await OfficialReal.deleteDoc(
      coll: RealColl.countingBzz,
      doc: bzID,
    );

  }
  // -----------------------------------------------------------------------------
}
