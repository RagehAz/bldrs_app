import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/c_controllers/authorships_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// ------------------------------------------
FireQueryModel userReceivedNotesPaginationQueryParameters({
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    finders: <FireFinder>[
      FireFinder(
        field: 'receiverID',
        comparison: FireComparison.equalTo,
        value: AuthFireOps.superUserID(),
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

  await BottomDialog.showButtonsBottomDialog(
    context: context,
    draggable: true,
    numberOfWidgets: 1,
    title: 'Options',
    buttonHeight: 50,
    builder: (_, PhraseProvider pro){

      return <Widget>[

        BottomDialog.wideButton(
          context: context,
          verse: 'Delete',
          height: 50,
          onTap: () async {

            await NoteProtocols.wipeNote(
              context: context,
              noteModel: noteModel,
            );

            Nav.goBack(
              context: context,
              invoker: 'onShowNoteOptions',
            );

          }
        ),

      ];

    }
  );

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

    final BzModel _bzModel = await BzProtocols.fetchBz(
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
