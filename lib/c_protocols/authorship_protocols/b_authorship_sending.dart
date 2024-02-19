import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
/// => TAMAM
class AuthorshipSendingProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipSendingProtocols();

  // -----------------------------------------------------------------------------

    /// SEND REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendRequest({
    required BzModel? oldBz,
    required UserModel? userModelToSendTo,
  }) async {

    final NoteModel? noteModel = await NoteEvent.sendAuthorshipInvitationNote(
      bzModel: oldBz,
      userModelToSendTo: userModelToSendTo,
    );

    final List<PendingAuthor> _pendingAuthors = PendingAuthor.addNewPendingAuthor(
      pendingAuthors: oldBz?.pendingAuthors,
      noteID: noteModel?.id,
      userID: userModelToSendTo?.id,
    );

    final BzModel? _newBz = oldBz?.copyWith(
      pendingAuthors: _pendingAuthors,
    );

    await BzProtocols.renovateBz(
      oldBz: oldBz,
      newBz: _newBz,
      showWaitDialog: false,
      newLogo: null,
    );

  }
  // -----------------------------------------------------------------------------

  /// CANCEL REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelRequest({
    required BzModel bzModel,
    required String pendingUserID
  }) async {

    await Future.wait(<Future>[

      /// REMOVE PENDING AUTHOR & RENOVATE BZ
      BzProtocols.wipePendingAuthor(
        bzID: bzModel.id,
        pendingUserID: pendingUserID,
      ),

      /// RENOVATE REPLY OF SENT REQUEST
      _renovateReplyOfSentRequestToCancel(
        bzModel: bzModel,
        pendingUserID: pendingUserID,
      ),

      /// SEND HIM NEW NOTE OF CANCELLATION
      _sendAuthorshipCancellationNote(
        bzModel: bzModel,
        pendingUserID: pendingUserID,
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _renovateReplyOfSentRequestToCancel({
    required BzModel bzModel,
    required String pendingUserID,
  }) async {

    /// get pending author model
    final PendingAuthor? _pendingAuthorModel = PendingAuthor.getModelByUserID(
      pendingAuthors: bzModel.pendingAuthors,
      userID: pendingUserID,
    );

    /// to get the sent previously sent note to delete
    final NoteModel? _sentNote = await NoteProtocols.readNote(
      noteID: _pendingAuthorModel?.noteID,
      userID: _pendingAuthorModel?.userID,
    );

    await NoteProtocols.renovate(
      oldNote: _sentNote,
      newNote: _sentNote?.copyWith(
        poll: _sentNote.poll?.copyWith(
          reply: PollModel.cancel,
        ),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _sendAuthorshipCancellationNote({
    required BzModel bzModel,
    required String pendingUserID
  }) async {

    /// get that user to send him cancellation note
    final UserModel? userModelToSendTo = await UserProtocols.fetch(
      userID: pendingUserID,
    );

    await NoteEvent.sendAuthorshipCancellationNote(
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo,
    );

  }
  // -----------------------------------------------------------------------------
}
