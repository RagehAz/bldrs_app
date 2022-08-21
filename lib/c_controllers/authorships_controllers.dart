import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY MODEL

// ------------------------------------------
/// TESTED : WORKS PERFECT
FireQueryModel bzSentPendingAuthorshipNotesStreamQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
    limit: 50,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      FireFinder(
        field: 'noteType',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherNoteType(NoteType.authorship),
      ),

      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.pending),
      ),

    ],
  );

}
// ------------------------------------------
/// TESTED : NOT YET
FireQueryModel bzSentDeclinedAndCancelledNotesPaginatorQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      FireFinder(
        field: 'noteType',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherNoteType(NoteType.authorship),
      ),

      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.declined),
      ),

      /// TASK : ??? will this work ?
      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.cancelled),
      ),

    ],
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// -------------------------------
/// TESTED : SENDS GOOD : need translations
Future<void> onSendAuthorshipInvitation({
  @required BuildContext context,
  @required UserModel selectedUser,
  @required BzModel bzModel,
}) async {

  final bool _result = await Dialogz.userDialog(
    context: context,
    title: 'Send Invitation ?',
    body: 'confirm sending invitation to ${selectedUser.name} to become an author of ${bzModel.name} account',
    userModel: selectedUser,
  );

  if (_result == true){

    await NoteProtocols.sendAuthorshipInvitationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: selectedUser,
    );

    // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // await _notesProvider.addNewPendingSentAuthorshipNote(
    //   context: context,
    //   note: _note,
    //   notify: true,
    // );

    unawaited(
        TopDialog.showTopDialog(
          context: context,
          firstLine: 'Invitation Sent',
          secondLine: 'Account authorship invitation has been sent to ${selectedUser.name} successfully',
          color: Colorz.green255,
          textColor: Colorz.white255,
        ));

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSentAuthorshipInvitation ({
  @required BuildContext context,
  @required NoteModel note,
}) async {

  if (note != null){

    final UserModel _receiverModel = await UserProtocols.fetchUser(
        context: context,
        userID: note.receiverID
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Cancel Invitation ?',
      body: '${_receiverModel.name} will be notified with cancelling this invitation',
      boolDialog: true,
      confirmButtonText: 'Yes, Cancel Invitation',
    );

    if (_result == true){

      await NoteProtocols.cancelSentAuthorshipInvitation(
          context: context,
          note: note,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Invitation request has been cancelled',
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// ------------------------------------------
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
// ------------------------------------------

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
    title: 'Accept invitation ?',
    body: 'This will add you as an Author for this business account',
    boolDialog: true,
  );

  if (_result == true){

    blog('_acceptAuthorshipInvitation : accepted ');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: "Adding you to '${bzModel.name}' business account",
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

    WaitDialog.closeWaitDialog(context);

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'You have become an Author in ${bzModel.name}',
      body: 'You can control the business account, publish flyers,'
          ' reply to costumers on behalf of the business and more.\n'
          'a system reboot is required',
      confirmButtonText: 'Great',
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
// ------------------------------------------

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
    title: 'Decline invitation ?',
    body: 'This will reject the invitation and you will not be added as an author.',
    confirmButtonText: 'Decline Invitation',
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
// ------------------------------------------
