import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/x_dashboard/notes_creator/draft_note.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEND

// --------------------
///
Future<bool> _preCheckCanSendNote({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  bool _canSend = false;

  final bool _formIsValid = draftNote.formKey.currentState.validate();

  if (
      _formIsValid == true
      &&
      draftNote.receiversModels.value.isNotEmpty == true
  ){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Send ?'),
      bodyVerse: Verse.plain('Do you want to confirm sending this notification to '
          '${draftNote.receiversModels.value.length} ${NoteModel.getNoteCollName(draftNote.noteNotifier.value)} '),
      boolDialog: true,
    );

    if (_continue == true){

      _canSend = true;

    }

  }

  return _canSend;
}
// --------------------
///
Future<void> onSendNote({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  final bool _canSend = await _preCheckCanSendNote(
    context: context,
    draftNote: draftNote,
  );

  if (_canSend == true){

    unawaited(WaitDialog.showWaitDialog(context: context));

    /// IF ONE RECEIVER
    if (draftNote.receiversModels.value.length == 1){

      /// IF USER
      if (draftNote.noteNotifier.value.parties.receiverType == PartyType.user){
        await _sendNoteToOneUser(
          context: context,
          draftNote: draftNote,
        );
      }

      /// IF BZ
      else {
        await _sendNoteToOneBz(
            context: context,
            draftNote: draftNote
        );
      }


    }

    /// IF MANY RECEIVERS
    else {

      /// IF USERS
      if (draftNote.noteNotifier.value.parties.receiverType == PartyType.user){
        await _sendNoteToMultipleUsers(
            context: context,
            draftNote: draftNote
        );
      }

      /// IF BZZ
      else {
        await _sendNoteToMultipleBzz(
            context: context,
            draftNote: draftNote
        );
      }

    }

    await WaitDialog.closeWaitDialog(context);

    await Scrollers.scrollToTop(
      controller: draftNote.scrollController,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstVerse: Verse.plain('Note Sent'),
      secondVerse: Verse.plain('Alf Mabrouk ya5oya'),
      milliseconds: 200,
    ));

  }

}

// -----------------------------------------------------------------------------

/// TO USER

// --------------------
///
Future<void> _sendNoteToOneUser({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  final List<String> _receiversIDs = NoteParties.getReceiversIDs(
    receiversModels: draftNote.receiversModels.value,
    partyType: draftNote.noteNotifier.value.parties.receiverType,
  );

  await NoteProtocols.composeToOne(
    context: context,
    note: NoteProtocols.adjustReceiverID(
      receiverID: _receiversIDs.first,
      note: draftNote.noteNotifier.value,
    ),
    // uploadPoster: true,
  );

}
// -----------------------------------------------------------------------------

/// TO BZ

// --------------------
///
Future<void> _sendNoteToOneBz({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

}
// -----------------------------------------------------------------------------

/// TO USERS

// --------------------
///
Future<void> _sendNoteToMultipleUsers({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

}
// -----------------------------------------------------------------------------

/// TO BZZ

// --------------------
///
Future<void> _sendNoteToMultipleBzz({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  // await NoteProtocols.composeToMultiple(
  //   context: context,
  //   note: draftNote.noteNotifier.value,
  //   receiversIDs: NoteParties.getReceiversIDs(
  //     receiversModels: draftNote.receiversModels.value,
  //     partyType: draftNote.noteNotifier.value.parties.receiverType,
  //   ),
  // );

}
// -----------------------------------------------------------------------------
