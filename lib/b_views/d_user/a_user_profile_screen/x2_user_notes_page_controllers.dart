import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel userReceivedNotesPaginationQueryParameters({
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.users,
      bDocName: AuthFireOps.superUserID(),
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
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
/// TESTED : WORKS PERFECT
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
                  note: noteModel,
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
  @required String response,
  @required NoteModel noteModel,
}) async {

  blog('onNoteButtonTap : SSSSSSSSSSSSSSS : response : $response');

  final NoteModel _updated = noteModel.copyWith(
    poll: noteModel.poll.copyWith(
      reply: response,
      replyTime: DateTime.now(),
    ),
  );

  await NoteProtocols.renovate(
    context: context,
    newNote: _updated,
    oldNote: noteModel,
  );

  // /// AUTHORSHIP NOTES
  // if (noteModel.type == NoteType.authorship){
  //
  //   final BzModel _bzModel = await BzProtocols.fetchBz(
  //     context: context,
  //     bzID: noteModel.senderID,
  //   );
  //
  //   await respondToAuthorshipNote(
  //     context: context,
  //     response: response,
  //     noteModel: noteModel,
  //     bzModel: _bzModel,
  //   );
  //
  // }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// --------------------
///
Future<void> respondToAuthorshipNote({
  @required BuildContext context,
  @required String reply,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  // NOTE : USER RESPONSE TO AUTHORSHIP INVITATION

  await NoteFireOps.markNoteAsSeen(
      noteModel: noteModel
  );

  /// ACCEPT AUTHORSHIP
  if (reply == PollModel.accept){
    await _acceptAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
      bzModel: bzModel,
    );
  }

  /// DECLINE AUTHORSHIP
  else if (reply == PollModel.decline){
    await _declineAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
    );
  }

  else {
    blog('respondToAuthorshipNote : response : $reply');
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
    await NoteProtocols.renovate(
      context: context,
      oldNote: noteModel,
      newNote: noteModel.copyWith(
        poll: noteModel.poll.copyWith(
          reply: PollModel.accept,
          replyTime: DateTime.now(),
        ),
      ),
    );

    await NoteEvent.sendAuthorshipAcceptanceNote(
      context: context,
      bzID: noteModel.parties.senderID,
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

    await NoteProtocols.renovate(
      context: context,
      oldNote: noteModel,
      newNote: noteModel.copyWith(
        poll: noteModel.poll.copyWith(
          reply: PollModel.decline,
          replyTime: DateTime.now(),
        ),
      ),
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
