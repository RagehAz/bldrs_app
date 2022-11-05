import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/record_protocols/real/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class UserRecordRealOps {
  // -----------------------------------------------------------------------------

  const UserRecordRealOps();

  // -----------------------------------------------------------------------------

  /// USER SEARCHES

  // --------------------
  /// CREATION
  // ----------
  static Future<RecordModel> createUserSearchRecord({
    @required String searchText,
  }) async {
    blog('UserRecordOps.createUserSearchRecord : START');

    final String _userID = AuthFireOps.superUserID();
    RecordModel _uploadedRecord;

    if (TextCheck.isEmpty(searchText) == false && _userID != null){

      final RecordModel _record = RecordModel.createSearchRecord(
        userID: _userID,
        searchText: searchText,
      );

      _uploadedRecord = await RecordRealOps.createRecord(
        record: _record,
      );

    }

    blog('UserRecordOps.createUserSearchRecord : END');
    return _uploadedRecord;
  }
  // --------------------
  /// READING
  // ----------
  ///
  // --------------------
  /// DELETION
  // ----------
  static Future<void> deleteAllUserRecords({
    @required String userID,
  }) async {

    /// SHARES
    await Real.deleteDoc(
      collName: RealColl.recordingSearches,
      docName: userID,
    );

    /// PLAN : USER COUNTERS DELETION IS HERE
    // /// USER COUNTERS
    // await Real.deleteDoc(
    //   context: context,
    //   collName: RealColl.userCounters,
    //   docName: userID,
    // );

  }
  // -----------------------------------------------------------------------------
}
