import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/ops/record_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class BzRecordOps {
// -----------------------------------------------------------------------------

  BzRecordOps();

// -----------------------------------------------------------------------------

  /// CREATION

// ----------------------------------
  /// FOLLOWS CREATION
// -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> followBz({
    @required BuildContext context,
    @required String bzID,
  }) async {
    blog('BzRecordOps.followBz : START');

    final RecordModel _record = RecordModel.createFollowRecord(
        userID: AuthFireOps.superUserID(),
        bzID: bzID
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'follows',
        increaseOne: true,
      ),

    ]);


    blog('BzRecordOps.followBz : END');
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unfollowBz({
    @required BuildContext context,
    @required String bzID,
  }) async {
    blog('BzRecordOps.unfollowBz : START');

    final RecordModel _record = RecordModel.createUnfollowRecord(
      userID: AuthFireOps.superUserID(),
      bzID: bzID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'follows',
        increaseOne: false,
      ),

    ]);

    blog('BzRecordOps.unfollowBz : END');
  }
// ----------------------------------
  /// CALLS CREATION
// -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> callBz({
    @required BuildContext context,
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

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'calls',
        increaseOne: true,
      ),

    ]);

    blog('BzRecordOps.callBz : END');
  }
// -----------------------------------------------------------------------------

  /// READ COUNTERS

// ----------------------------------
  static Future<BzCounterModel> readBzCounters({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final Map<String, dynamic> _map = await Real.readDocOnce(
      context: context,
      collName: 'bzzCounters',
      docName: bzID,
    );

    final BzCounterModel _bzCounters = BzCounterModel.decipherCounterMap(_map);

    return _bzCounters;
  }
// -----------------------------------------------------------------------------
}
