import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class AuthorshipSendingProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipSendingProtocols();

  // -----------------------------------------------------------------------------

    /// SEND REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    final NoteModel noteModel = await NoteEvent.sendAuthorshipInvitationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo,
    );

    final List<PendingAuthor> _pendingAuthors = PendingAuthor.addNewPendingAuthor(
      pendingAuthors: bzModel.pendingAuthors,
      noteID: noteModel.id,
      userID: userModelToSendTo.id,
    );

    final BzModel _updatedBzModel = bzModel.copyWith(
      pendingAuthors: _pendingAuthors,
    );

    await BzProtocols.renovateBz(
      context: context,
      oldBzModel: bzModel,
      newBz: _updatedBzModel,
      showWaitDialog: false,
      navigateToBzInfoPageOnEnd: false,
      newLogo: null,
    );

  }
  // -----------------------------------------------------------------------------

  /// CANCEL REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String pendingUserID
  }) async {

    await Future.wait(<Future>[

      /// REMOVE PENDING AUTHOR & RENOVATE BZ
      BzProtocols.wipePendingAuthor(
        context: context,
        bzID: bzModel.id,
        pendingUserID: pendingUserID,
      ),

      /// RENOVATE REPLY OF SENT REQUEST
      _renovateReplyOfSentRequestToCancel(
        context: context,
        bzModel: bzModel,
        pendingUserID: pendingUserID,
      ),

      /// SEND HIM NEW NOTE OF CANCELLATION
      _sendAuthorshipCancellationNote(
        context: context,
        bzModel: bzModel,
        pendingUserID: pendingUserID,
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _renovateReplyOfSentRequestToCancel({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String pendingUserID,
  }) async {

    /// get pending author model
    final PendingAuthor _pendingAuthorModel = PendingAuthor.getModelByUserID(
      pendingAuthors: bzModel.pendingAuthors,
      userID: pendingUserID,
    );

    /// to get the sent previously sent note to delete
    final NoteModel _sentNote = await NoteProtocols.readNote(
      noteID: _pendingAuthorModel.noteID,
      userID: _pendingAuthorModel.userID,
    );

    await NoteProtocols.renovate(
      context: context,
      oldNote: _sentNote,
      newNote: _sentNote.copyWith(
        poll: _sentNote.poll.copyWith(
          reply: PollModel.cancel,
        ),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _sendAuthorshipCancellationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String pendingUserID
  }) async {

    /// get that user to send him cancellation note
    final UserModel userModelToSendTo = await UserProtocols.fetch(
      context: context,
      userID: pendingUserID,
    );

    await NoteEvent.sendAuthorshipCancellationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo,
    );

  }
  // -----------------------------------------------------------------------------
}
