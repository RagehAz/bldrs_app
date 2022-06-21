import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/authorships_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// ------------------------------------------
QueryModel userReceivedNotesPaginationQueryParameters({
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
        value: superUserID(),
      ),
    ],
    onDataChanged: onDataChanged,
  );

}
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// ------------------------------------------
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  blog('note options');

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// ------------------------------------------
// void decrementUserObelisksNotesNumber({
//   @required NotesProvider notesProvider,
//   @required int markedNotesLength,
//   @required bool notify,
// }){
//
//   blog('decrementUserObelisksNotesNumber : receiving $markedNotesLength notes');
//
//   if (markedNotesLength > 0){
//
//     final int _mainValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
//     );
//
//     final int _mainUpdated = NavModel.updateObeliskNumber(
//       oldNumber: _mainValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementUserObelisksNotesNumber',
//       value: _mainUpdated,
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
//       notify: false,
//     );
//
//     final int _userNotesTabValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getUserTabNavID(UserTab.notifications),
//     );
//
//     final int _userNotesTabValueUpdated = NavModel.updateObeliskNumber(
//       oldNumber: _userNotesTabValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementUserObelisksNotesNumber',
//       value: _userNotesTabValueUpdated,
//       navModelID: NavModel.getUserTabNavID(UserTab.notifications),
//       notify: notify,
//     );
//
//   }
//
// }
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// ------------------------------------------
Future<void> onNoteButtonTap({
  @required BuildContext context,
  @required NoteResponse response,
  @required NoteModel noteModel,
}) async {

  /// AUTHORSHIP NOTES
  if (noteModel.noteType == NoteType.authorship){

    final BzModel _bzModel = await BzzProvider.proFetchBzModel(
      context: context,
      bzID: noteModel.senderID,
    );

    await respondToAuthorshipNote(
      context: context,
      response: response,
      noteModel: noteModel,
      bzModel: _bzModel,
    );

  }

}
// -----------------------------------------------------------------------------
