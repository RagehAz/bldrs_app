import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/b_authorship_sending.dart';
import 'package:bldrs/c_protocols/authorship_protocols/d_authorship_responding.dart';
import 'package:bldrs/c_protocols/authorship_protocols/e_authorship_entry.dart';
import 'package:bldrs/c_protocols/authorship_protocols/f_authorship_exit.dart';
import 'package:flutter/material.dart';

class AuthorshipProtocols {
  /// --------------------------------------------------------------------------

  const AuthorshipProtocols();

  // -----------------------------------------------------------------------------

  /// REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => AuthorshipSendingProtocols.sendRequest(
    context: context,
    bzModel: bzModel,
    userModelToSendTo: userModelToSendTo,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String pendingUserID,
  }) => AuthorshipSendingProtocols.cancelRequest(
    context: context,
    bzModel: bzModel,
    pendingUserID: pendingUserID,
  );
  // -----------------------------------------------------------------------------

  /// RECEIVING

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// RESPONDING

  // --------------------
  static Future<void> respondToInvitation({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required String reply,
  }) => AuthorshipRespondingProtocols.respond(
    reply: reply,
    context: context,
    noteModel: noteModel,
  );
  // -----------------------------------------------------------------------------

  /// ENTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeToBz({
    @required BuildContext context,
    @required String bzID,
  }) => AuthorshipEntryProtocols.addMeToBz(
    context: context,
    bzID: bzID,
  );
  // -----------------------------------------------------------------------------

  /// EXIT

  // --------------------
  ///
  static Future<void> removeMeFromBz({
    @required BuildContext context,
    @required BzModel streamedBzModelWithoutMyID,
  }) => AuthorshipExitProtocols.removeMeFromBz(
      context: context,
      streamedBzModelWithoutMyID: streamedBzModelWithoutMyID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMyAuthorPic({
    @required BuildContext context,
    @required String bzID,
  }) => AuthorshipExitProtocols.deleteMyAuthorPic(
      context: context,
      bzID: bzID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeFlyerlessAuthor({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel author,
  }) => AuthorshipExitProtocols.removeFlyerlessAuthor(
    context: context,
    bzModel: bzModel,
    author: author,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeBzTracesAfterDeletion({
    @required BuildContext context,
    @required String bzID,
  }) => AuthorshipExitProtocols.removeBzTracesAfterDeletion(
    context: context,
    bzID: bzID,
  );
  /// --------------------------------------------------------------------------
}
