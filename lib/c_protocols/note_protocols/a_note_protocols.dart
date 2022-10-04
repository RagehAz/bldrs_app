import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/note_protocols/compose_notes.dart';
import 'package:bldrs/c_protocols/note_protocols/renovate_notes.dart';
import 'package:bldrs/c_protocols/note_protocols/wipe_notes.dart';
import 'package:flutter/material.dart';

class NoteProtocols {
  // -----------------------------------------------------------------------------

  const NoteProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => ComposeNoteProtocols.sendAuthorshipInvitationNote(
    context: context,
    bzModel: bzModel,
    userModelToSendTo: userModelToSendTo,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) => ComposeNoteProtocols.sendAuthorshipAcceptanceNote(
    context: context,
    bzID: bzID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) => ComposeNoteProtocols.sendAuthorRoleChangeNote(
    context: context,
    bzID: bzID,
    author: author,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
    @required bool sendToUserAuthorExitNote,
  }) => ComposeNoteProtocols.sendAuthorDeletionNotes(
    context: context,
    bzModel: bzModel,
    deletedAuthor: deletedAuthor,
    sendToUserAuthorExitNote: sendToUserAuthorExitNote,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool includeMyself,
  }) => ComposeNoteProtocols.sendBzDeletionNoteToAllAuthors(
    context: context,
    bzModel: bzModel,
    includeMyself: includeMyself,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) => ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz(
    context: context,
    bzModel: bzModel,
    flyerID: flyerID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) => ComposeNoteProtocols.sendNoBzContactAvailableNote(
    context: context,
    bzModel: bzModel,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required NoteResponse response,
  }) => RenovateNoteProtocols.modifyNoteResponse(
    context: context,
    noteModel: noteModel,
    response: response,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) => WipeNoteProtocols.cancelSentAuthorshipInvitation(
      context: context,
      note: note
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeNote({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) => WipeNoteProtocols.wipeNote(
      context: context,
      noteModel: noteModel
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) => WipeNoteProtocols.deleteAllBzReceivedNotes(
    context: context,
    bzID: bzID,
  );
  // --------------------
  ///
  static Future<void> wipeBzSentAuthorshipNotes({
    @required BuildContext context,
    @required String bzID,
  }) => WipeNoteProtocols.wipeBzSentAuthorshipNotes(
      context: context,
      bzID: bzID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) => WipeNoteProtocols.wipeUserReceivedNotes(
      context: context,
      userID: userID
  );
  // --------------------
}
