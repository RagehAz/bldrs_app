

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class WipeNoteProtocols {
// -----------------------------------------------------------------------------

  const WipeNoteProtocols();

// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.cancelSentAuthorshipInvitation : START');

    final NoteModel _updated = note.copyWith(
      response: NoteResponse.cancelled,
      responseTime: DateTime.now(),
    );

    await NoteFireOps.updateNote(
      context: context,
      newNoteModel: _updated,
    );

    blog('NoteProtocol.cancelSentAuthorshipInvitation : END');

  }
// ----------------------------------
  static Future<void> wipeNote({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    blog('NoteProtocol.deleteNoteEverywhereProtocol : START');

    /// FIRE DELETE
    await NoteFireOps.deleteNote(
      context: context,
      noteID: noteModel.id,
    );

    /// PRO DELETE
    NotesProvider.proDeleteNoteEverywhereIfExists(
      context: context,
      noteID: noteModel.id,
      notify: true,
    );

    blog('NoteProtocol.deleteNoteEverywhereProtocol : END');
  }
// -----------------------------------------------------------------------------

  /// SUPER DELETE ALL NOTES

// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> deleteAllBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('NoteProtocol.deleteAllBzReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      context: context,
      receiverID: bzID,
      receiverType: NoteReceiverType.bz,
    );

    blog('NoteProtocol.deleteAllBzReceivedNotes : END');

  }
// ----------------------------------
  static Future<void> wipeBzSentAuthorshipNotes({
    @required BuildContext context,
    @required String bzID,
  }) async {

    await NoteFireOps.deleteAllSentAuthorshipNotes(
        context: context,
        senderID: bzID,
    );

  }
// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> wipeUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) async {

    blog('NoteProtocol.deleteAllUserReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      context: context,
      receiverID: userID,
      receiverType: NoteReceiverType.user,
    );

    blog('NoteProtocol.deleteAllUserReceivedNotes : END');

  }
// ----------------------------------
}
