

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:flutter/material.dart';

class AuthorshipRespondingProtocols{
  // -----------------------------------------------------------------------------

  const AuthorshipRespondingProtocols();

  // -----------------------------------------------------------------------------

  /// ACCEPT

  // --------------------
  ///
  static Future<void> acceptRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required NoteModel noteModel,
  }) async {

    await AuthorshipProtocols.addMeAsNewAuthorToABzProtocol(
      context: context,
      oldBzModel: bzModel,
    );

    final NoteModel _updatedNote = noteModel.copyWith(
      poll: noteModel.poll.copyWith(
        reply: PollModel.accept,
        replyTime: DateTime.now(),
      ),
    );

    /// MODIFY NOTE RESPONSE
    await NoteProtocols.renovate(
      context: context,
      oldNote: noteModel,
      newNote: _updatedNote,
    );

    await NoteEvent.sendAuthorshipAcceptanceNote(
      context: context,
      bzID: noteModel.parties.senderID,
    );

  }
  // -----------------------------------------------------------------------------

  /// DECLINE

  // --------------------
  ///
  static Future<void> declineRequest({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    final NoteModel _updatedNote = noteModel.copyWith(
      poll: noteModel.poll.copyWith(
        reply: PollModel.decline,
        replyTime: DateTime.now(),
      ),
    );

    await NoteProtocols.renovate(
      context: context,
      oldNote: noteModel,
      newNote: _updatedNote,
    );

  }
  // -----------------------------------------------------------------------------
}
