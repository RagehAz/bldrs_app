import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// --------------------
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

// --------------------
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 1,
      titleVerse: const Verse(
        text: 'phid_options',
        translate: true,
      ),
      buttonHeight: 50,
      builder: (_){

        return <Widget>[

          BottomDialog.wideButton(
              context: context,
              verse: const Verse(
                text: 'phid_delete',
                translate: true,
              ),
              height: 50,
              onTap: () async {

                await NoteProtocols.wipeNote(
                  context: context,
                  noteModel: noteModel,
                );

                await Nav.goBack(
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

// --------------------
/*
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
*/
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// --------------------
Future<void> onNoteButtonTap({
  @required BuildContext context,
  @required NoteResponse response,
  @required NoteModel noteModel,
}) async {

  /// AUTHORSHIP NOTES
  if (noteModel.type == NoteType.authorship){

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

/// AUTHORSHIP NOTE RESPONSES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> respondToAuthorshipNote({
  @required BuildContext context,
  @required NoteResponse response,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  // NOTE : USER RESPONSE TO AUTHORSHIP INVITATION

  await NoteFireOps.markNoteAsSeen(
      context: context,
      noteModel: noteModel
  );

  /// ACCEPT AUTHORSHIP
  if (response == NoteResponse.accepted){
    await _acceptAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
      bzModel: bzModel,
    );
  }

  /// DECLINE AUTHORSHIP
  else if (response == NoteResponse.declined){
    await _declineAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
    );
  }

  else {
    blog('respondToAuthorshipNote : response : $response');
  }

}
// -----------------------------------------------------------------------------

/// ACCEPT AUTHORSHIP INVITATION

// -------------------
/// TESTED :
Future<void> _acceptAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_accept_invitation_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'This will add you as an Author for this business account',
      text: 'phid_accept_author_invitation_description',
      translate: true,
    ),
    boolDialog: true,
  );

  if (_result == true){

    blog('_acceptAuthorshipInvitation : accepted ');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: Verse(
        text: "##Adding you to '${bzModel.name}' business account",
        translate: true,
        variables: bzModel.name,
      ),
    ));

    await AuthorProtocols.addMeAsNewAuthorToABzProtocol(
      context: context,
      oldBzModel: bzModel,
    );

    /// MODIFY NOTE RESPONSE
    await NoteProtocols.modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: NoteResponse.accepted,
    );

    await NoteProtocols.sendAuthorshipAcceptanceNote(
      context: context,
      bzID: noteModel.senderID,
    );

    await WaitDialog.closeWaitDialog(context);

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse(
        pseudo: 'You have become an Author in ${bzModel.name}',
        text: 'phid_you_became_author_in_bz',
        translate: true,
        variables: bzModel.name,
      ),
      bodyVerse: const Verse(
        pseudo: 'You can control the business account, publish flyers,'
            ' reply to costumers on behalf of the business and more.\n'
            'a system reboot is required',
        text: 'phid_became_author_in_bz_description',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_great',
        translate: true,
      ),
    );

    /// NOTE : a system reboot is required at that point
    /// to allow home screen re-init my bzz notes stream to include this bz
    /// and listen to its live notes
    await Nav.goRebootToInitNewBzScreen(
      context: context,
      bzID: bzModel.id,
    );

  }

}
// -----------------------------------------------------------------------------

/// DECLINE AUTHORSHIP INVITATION

// -------------------
/// TESTED :
Future<void> _declineAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {
  blog('_declineAuthorshipInvitation : decline ');

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      pseudo: 'Decline invitation ?',
      text: 'phid_decline_invitation_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'This will reject the invitation and you will not be added as an author.',
      text: 'phid_decline_invitation_description',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      text: 'phid_decline_invitation',
      translate: true,
    ),
    boolDialog: true,
  );

  if (_result == true){

    await NoteProtocols.modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: NoteResponse.declined,
    );

  }

}
// -------------------
/*
/// TESTED : WORKS PERFECT
Future<void> _modifyNoteResponse({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required NoteResponse response,
}) async {

  final NoteModel _newNoteModel = noteModel.copyWith(
    response: response,
    responseTime: DateTime.now(),
  );

  await NoteFireOps.updateNote(
    context: context,
    newNoteModel: _newNoteModel,
  );

}
 */
// -----------------------------------------------------------------------------
