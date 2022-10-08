import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/authorship.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/bz_flyers_management.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/bz_team_management.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/profile_deletion.dart';
import 'package:flutter/material.dart';

class NoteEvent {
  // -----------------------------------------------------------------------------

  const NoteEvent();

  // -----------------------------------------------------------------------------

  /// AUTHORSHIP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => NoteEventsOfAuthorship.sendAuthorshipInvitationNote(
    context: context,
    bzModel: bzModel,
    userModelToSendTo: userModelToSendTo,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) => NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote(
    context: context,
    bzID: bzID,
  );
  // --------------------
  ///
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) => NoteEventsOfAuthorship.cancelSentAuthorshipInvitation(
    context: context,
    note: note,
  );
  // -----------------------------------------------------------------------------

  /// Bz Team Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) => NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote(
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
  }) => NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes(
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
  }) => NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors(
    context: context,
    bzModel: bzModel,
    includeMyself: includeMyself,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) => NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote(
    context: context,
    bzModel: bzModel,
  );
  // -----------------------------------------------------------------------------

  /// Bz Flyers Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) => NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz(
    context: context,
    bzModel: bzModel,
    flyerID: flyerID,
  );
  // --------------------
  ///
  static Future<void> sendFlyerIsVerifiedNoteToBz({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) => NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz(
    context: context,
    flyerID: flyerID,
    bzID: bzID,
  );
  // -----------------------------------------------------------------------------

  /// PROFILE DELETION

  // --------------------
  ///
  static Future<void> wipeUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) => NoteEventsOfProfileDeletion.wipeUserReceivedNotes(
    context: context,
    userID: userID,
  );
  // --------------------
  ///
  static Future<void> wipeBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzReceivedNotes(
    context: context,
    bzID: bzID,
  );
  // --------------------
  ///
  static Future<void> wipeBzSentAuthorshipNotes({
    @required BuildContext context,
    @required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzSentAuthorshipNotes(
    context: context,
    bzID: bzID,
  );
  // -----------------------------------------------------------------------------
}
