import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class AuthorshipRespondingProtocols{
  // -----------------------------------------------------------------------------

  const AuthorshipRespondingProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> respond({
    required String reply,
    required NoteModel noteModel,
  }) async {

    await NoteFireOps.markNoteAsSeen(
        noteModel: noteModel
    );

    final BzModel? _bzModel = await BzProtocols.refetch(
      bzID: noteModel.parties?.senderID,
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
          oldNote: noteModel,
          newNote: noteModel.copyWith(
            poll: noteModel.poll?.copyWith(
              reply: PollModel.expired,
              replyTime: DateTime.now(),
            ),
          ),
        ),

        BldrsCenterDialog.showCenterDialog(
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
          noteModel: noteModel,
          bzModel: _bzModel,
        );
      }

      /// DECLINE AUTHORSHIP
      else if (reply == PollModel.decline){
        await _onDeclineInvitation(
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
    required NoteModel noteModel,
    required BzModel? bzModel,
  }) async {

    final bool _result = await BldrsCenterDialog.showCenterDialog(
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

      WaitDialog.showUnawaitedWaitDialog(
        verse: Verse(
          id: 'phid_adding_you_to_bz',
          translate: true,
          variables: bzModel?.name,
        ),
      );

      await _acceptRequest(
        bzModel: bzModel,
        noteModel: noteModel,
      );

      await WaitDialog.closeWaitDialog();

      await BldrsCenterDialog.showCenterDialog(
        titleVerse: Verse(
          id: 'phid_great_!',
          translate: true,
          variables: bzModel?.name,
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

      await goToAuthorEditor(
        bzID: bzModel?.id,
      );

      /// NOTE : a system reboot is required at that point
      /// to allow home screen re-init my bzz notes stream to include this bz
      /// and listen to its live notes
      await Routing.restartToAfterHomeRoute(
        routeName: TabName.bid_MyBz_Info,
        arguments: bzModel?.id,
      );

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _acceptRequest({
    required BzModel? bzModel,
    required NoteModel? noteModel,
  }) async {

    final bool _imPendingAuthor = PendingAuthor.checkIsPendingAuthor(
        bzModel: bzModel,
        userID: Authing.getUserID(),
    );

    assert(
    _imPendingAuthor == true,
    'i am not a pending author and can not add myself to bz ${bzModel?.id}'
    );

    await AuthorshipProtocols.addMeToBz(
      bzID: bzModel?.id,
    );

    final NoteModel? _updatedNote = noteModel?.copyWith(
      poll: noteModel.poll?.copyWith(
        reply: PollModel.accept,
        replyTime: DateTime.now(),
      ),
    );

    /// MODIFY NOTE RESPONSE
    await NoteProtocols.renovate(
      oldNote: noteModel,
      newNote: _updatedNote,
    );

    await NoteEvent.sendAuthorshipAcceptanceNote(
      context: getMainContext(),
      bzID: noteModel?.parties?.senderID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> goToAuthorEditor({
    required String? bzID,
    AuthorModel? author,
  }) async {

    BzModel? _bzModel = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    if (Authing.getUserID() != null && _bzModel?.authors != null) {

      final AuthorModel? _authorModel = AuthorModel.getAuthorFromAuthorsByID(
        authors: _bzModel?.authors,
        authorID: author?.userID ?? Authing.getUserID()!,
      );

      final BzModel? _bz = await BldrsNav.goToNewScreen(
        screen: AuthorEditorScreen(
          author: _authorModel!,
          bzModel: _bzModel!,
        ),
      );

      if (_bz != null){
        _bzModel = _bz;
      }

    }

    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// DECLINE

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onDeclineInvitation({
    required NoteModel noteModel,
  }) async {
    blog('_declineAuthorshipInvitation : decline ');

    final bool _result = await BldrsCenterDialog.showCenterDialog(
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
        noteModel:  noteModel,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _declineRequest({
    required NoteModel noteModel,
  }) async {

    final NoteModel _updatedNote = noteModel.copyWith(
      poll: noteModel.poll?.copyWith(
        reply: PollModel.decline,
        replyTime: DateTime.now(),
      ),
    );

    await NoteProtocols.renovate(
      oldNote: noteModel,
      newNote: _updatedNote,
    );

    await NoteEvent.sendAuthorshipDeclinationsNote(
      context: getMainContext(),
      bzID: noteModel.parties?.senderID,
    );

  }
  // -----------------------------------------------------------------------------
}
