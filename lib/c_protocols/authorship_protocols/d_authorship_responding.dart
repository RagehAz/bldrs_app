import 'dart:async';

import 'package:authing/authing.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
/// => TAMAM
class AuthorshipRespondingProtocols{
  // -----------------------------------------------------------------------------

  const AuthorshipRespondingProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> respond({
    @required BuildContext context,
    @required String reply,
    @required NoteModel noteModel,
  }) async {

    await NoteFireOps.markNoteAsSeen(
        noteModel: noteModel
    );

    final BzModel _bzModel = await BzProtocols.refetch(
      context: context,
      bzID: noteModel.parties.senderID,
    );

    final bool _imPendingAuthor = PendingAuthor.checkIsPendingAuthor(
        bzModel: _bzModel,
        userID: Authing.getUserID(),
    );

    /// INVITATION HAS BEEN CANCELLED
    if (_imPendingAuthor == false){

      await Future.wait(<Future>[

      /// SOME HACK BUT THIS SHOULD NEVER BE
        NoteProtocols.renovate(
          context: context,
          oldNote: noteModel,
          newNote: noteModel.copyWith(
            poll: noteModel.poll.copyWith(
              reply: PollModel.expired,
              replyTime: DateTime.now(),
            ),
          ),
        ),

        CenterDialog.showCenterDialog(
          context: context,
          titleVerse: const Verse(
            id: 'phid_invitation_request_had_expired',
            translate: true,
          ),
        ),

      ]);

    }

    /// INVITATION IS STILL AVAILABLE
    else {

      /// ACCEPT AUTHORSHIP
      if (reply == PollModel.accept){
        await _onAcceptInvitation(
          context: context,
          noteModel: noteModel,
          bzModel: _bzModel,
        );
      }

      /// DECLINE AUTHORSHIP
      else if (reply == PollModel.decline){
        await _onDeclineInvitation(
          context: context,
          noteModel: noteModel,
        );
      }

      else {
        blog('respondToAuthorshipNote : response : $reply');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// ACCEPT

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onAcceptInvitation({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required BzModel bzModel,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        id: 'phid_accept_invitation_?',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_accept_author_invitation_description',
        translate: true,
      ),
      boolDialog: true,
    );

    if (_result == true){

      blog('_acceptAuthorshipInvitation : accepted ');

      pushWaitDialog(
        context: context,
        verse: Verse(
          id: 'phid_adding_you_to_bz',
          translate: true,
          variables: bzModel.name,
        ),
      );

      await _acceptRequest(
        context: context,
        bzModel: bzModel,
        noteModel: noteModel,
      );

      await WaitDialog.closeWaitDialog(context);

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: Verse(
          id: 'phid_great_!',
          translate: true,
          variables: bzModel.name,
        ),
        bodyVerse: const Verse(
          id: 'phid_you_can_control_this_bz',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          id: 'phid_great_!',
          translate: true,
        ),
      );

      await _goToAuthorEditor(
        context: context,
        bzID: bzModel.id,
      );

      /// NOTE : a system reboot is required at that point
      /// to allow home screen re-init my bzz notes stream to include this bz
      /// and listen to its live notes
      await BldrsNav.goRebootToInitNewBzScreen(
        context: context,
        bzID: bzModel.id,
      );

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _acceptRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required NoteModel noteModel,
  }) async {

    final bool _imPendingAuthor = PendingAuthor.checkIsPendingAuthor(
        bzModel: bzModel,
        userID: Authing.getUserID(),
    );

    assert(
    _imPendingAuthor == true,
    'i am not a pending author and can not add myself to bz ${bzModel.id}'
    );

    await AuthorshipProtocols.addMeToBz(
      context: context,
      bzID: bzModel.id,
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
  // --------------------
  /// TASK : TEST ME
  static Future<void> _goToAuthorEditor({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final BzModel _bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: bzID,
    );

    final AuthorModel _authorModel = AuthorModel.getAuthorFromAuthorsByID(
      authors: _bzModel.authors,
      authorID: Authing.getUserID(),
    );

    await Nav.goToNewScreen(
      context: context,
      screen: AuthorEditorScreen(
          author: _authorModel,
          bzModel: _bzModel,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// DECLINE

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onDeclineInvitation({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    blog('_declineAuthorshipInvitation : decline ');

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        id: 'phid_decline_invitation_?',
        translate: true,
      ),
      bodyVerse: const Verse(
        id: 'phid_decline_invitation_description',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_decline',
        translate: true,
      ),
      boolDialog: true,
    );

    if (_result == true){

      await _declineRequest(
        context: context,
        noteModel:  noteModel,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _declineRequest({
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

    await NoteEvent.sendAuthorshipDeclinationsNote(
      context: context,
      bzID: noteModel.parties.senderID,
    );

  }
  // -----------------------------------------------------------------------------
}
