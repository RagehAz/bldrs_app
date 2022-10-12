import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as fireDB;

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
        userID: AuthFireOps.superUserID(),
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
      userID: AuthFireOps.superUserID(),
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
      userID: AuthFireOps.superUserID(),
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
  /// TESTED : WORKS PERFECT
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

    blog('BzRecordOps.incrementBzCounter : START');

    int _value;
    if (incrementThis == null){
      _value = increaseOne == true ? 1 : -1;
    }
    else {
      _value = incrementThis;
    }

    await Real.updateDocField(
      collName: RealColl.countingBzz,
      docName: bzID,
      fieldName: field,
      value: fireDB.ServerValue.increment(_value),
    );

    Map<String, dynamic> _map = await Real.readDocOnce(
      collName: RealColl.countingBzz,
      docName: bzID,
    );

    _map = Mapper.insertPairInMap(
      map: _map,
      key: 'bzID',
      value: bzID,
    );

    final BzCounterModel _model = BzCounterModel.decipherCounterMap(_map);

    blog('BzRecordOps.incrementBzCounter : END');

    return _model;
  }
  // --------------------
  /// READING
  // ---------
  static Future<BzCounterModel> readBzCounters({
    @required String bzID,
  }) async {

    final Map<String, dynamic> _map = await Real.readDocOnce(
      collName: RealColl.countingBzz,
      docName: bzID,
    );

    final BzCounterModel _bzCounters = BzCounterModel.decipherCounterMap(_map);

    return _bzCounters;
  }
  // --------------------
  /// DELETION
  // ---------
  static Future<void> deleteAllBzCountersAndRecords({
    @required String bzID,
  }) async {

    /// FOLLOWS
    await Real.deleteDoc(
      collName: RealColl.recordingFollows,
      docName: bzID,
    );

    /// CALLS
    await Real.deleteDoc(
      collName: RealColl.recordingCalls,
      docName: bzID,
    );

    /// BZ COUNTERS
    await Real.deleteDoc(
      collName: RealColl.countingBzz,
      docName: bzID,
    );

  }
  // -----------------------------------------------------------------------------
}
