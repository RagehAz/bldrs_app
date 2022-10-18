import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class AuthorshipSendingProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipSendingProtocols();

  // -----------------------------------------------------------------------------

    /// SEND REQUEST

  // --------------------
  ///
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
        newBzModel: _updatedBzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
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

    /// remove this user from the pending authors list to update bz
    final List<PendingAuthor> _updatedPendingUsers = PendingAuthor.removePendingAuthor(
        pendingAuthors: bzModel.pendingAuthors,
        userID: pendingUserID,
    );

    /// update bz model to renovate
    final BzModel _updatedBzModel = bzModel.copyWith(
      pendingAuthors: _updatedPendingUsers,
    );

    /// get that user to send him cancellation note
    final UserModel userModelToSendTo = await UserProtocols.fetchUser(
        context: context,
        userID: pendingUserID,
    );

    await Future.wait(<Future>[

      /// RENOVATE BZ
      BzProtocols.renovateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
      ),

      /// DELETE THAT AUTHORSHIP INVITATION NOTE SENT EARLIER
      NoteProtocols.wipeNote(
          context: context,
          note: _sentNote,
      ),

      /// SEND HIM NEW NOTE OF CANCELLATION
      NoteEvent.sendAuthorshipCancellationNote(
          context: context,
          bzModel: bzModel,
          userModelToSendTo: userModelToSendTo,
      ),

    ]);

  }
  // -----------------------------------------------------------------------------
}
