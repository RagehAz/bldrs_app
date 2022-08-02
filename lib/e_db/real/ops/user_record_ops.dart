import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/e_db/real/ops/record_ops.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class UserRecordOps {
// -----------------------------------------------------------------------------

  UserRecordOps();

// -----------------------------------------------------------------------------

  /// USER SEARCHES

// ----------------------------------
  /// CREATION
// -------------------
  static Future<RecordModel> createUserSearchRecord({
    @required BuildContext context,
    @required String searchText,
  }) async {
    blog('UserRecordOps.createUserSearchRecord : START');

    final String _userID = AuthFireOps.superUserID();
    RecordModel _uploadedRecord;

    if (TextChecker.stringIsNotEmpty(searchText) == true && _userID != null){

      final RecordModel _record = RecordModel.createSearchRecord(
        userID: _userID,
        searchText: searchText,
      );

      _uploadedRecord = await RecordRealOps.createRecord(
        context: context,
        record: _record,
      );

    }

    blog('UserRecordOps.createUserSearchRecord : END');
    return _uploadedRecord;
  }
// ----------------------------------
/// READING
// -------------------

// ----------------------------------
/// DELETION
// -------------------
  static Future<void> deleteAllUserRecords({
    @required BuildContext context,
    @required String userID,
  }) async {

    /// SHARES
    await Real.deleteDoc(
      context: context,
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
