import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/c_protocols/record_protocols/real/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:filers/filers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stringer/stringer.dart';

class UserRecordRealOps {
  // -----------------------------------------------------------------------------

  const UserRecordRealOps();

  // -----------------------------------------------------------------------------

  /// USER SEARCHES

  // --------------------

  /// CREATE SEARCH

  // ----------
  static Future<RecordModel> createUserSearchRecord({
    @required String searchText,
  }) async {
    blog('UserRecordOps.createUserSearchRecord : START');

    final String _userID = Authing.getUserID();
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
  // -------------------

  /// READ SEARCHES

  // ----------
  ///
  // --------------------

  /// DELETE SEARCHES

  // ----------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllUserRecords({
    @required String userID,
  }) async {

    /// SEARCHES
    await Real.deleteDoc(
      coll: RealColl.recordingSearches,
      doc: userID,
    );

  }
  // -----------------------------------------------------------------------------
}
