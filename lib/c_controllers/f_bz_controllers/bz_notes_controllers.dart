import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// ------------------------------------------
/// TESTED : WORKS PERFECT
QueryModel bzReceivedNotesPaginationQueryParameters({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return QueryModel(
    collName: FireColl.notes,
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    finders: <FireFinder>[

      FireFinder(
        field: 'receiverID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

    ],
    onDataChanged: onDataChanged,
  );

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// ------------------------------------------
/// TESTED : WORKS PERFECT
void decrementBzObeliskUnseenNotesNumber({
  @required NotesProvider notesProvider,
  @required int markedNotesLength,
  @required String bzID,
}){

  if (markedNotesLength > 0){

    /// MARK ON PROVIDER
    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
      notify: false,
      isIncrementing: false,
    );
    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
      notify: false,
      isIncrementing: false,
    );

  }

}
// ------------------------------------------
