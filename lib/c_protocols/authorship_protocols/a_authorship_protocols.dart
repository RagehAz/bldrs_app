import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
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

  /// SENDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => AuthorShipSendingProtocols.sendRequest(
    context: context,
    bzModel: bzModel,
    userModelToSendTo: userModelToSendTo,
  );
  // -----------------------------------------------------------------------------

  /// RECEIVING

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// RESPONDING

  // --------------------
  ///
  static Future<void> acceptRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required NoteModel noteModel,
  }) => AuthorshipRespondingProtocols.acceptRequest(
    context: context,
    bzModel: bzModel,
    noteModel: noteModel,
  );
  // --------------------
  ///
  static Future<void> declineRequest({
    @required BuildContext context,
    @required NoteModel noteModel,
}) => AuthorshipRespondingProtocols.declineRequest(
    context: context,
    noteModel: noteModel,
  );
  // -----------------------------------------------------------------------------

  /// ENTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeAsNewAuthorToABzProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
  }) => AuthorshipEntryProtocols.addMeAsNewAuthorToABzProtocol(
    context: context,
    oldBzModel: oldBzModel,
  );
  // -----------------------------------------------------------------------------

  /// EXIT

  // --------------------
  ///
  static Future<void> removeMeFromBzProtocol({
    @required BuildContext context,
    @required BzModel streamedBzModelWithoutMyID,
  }) => AuthorshipExitProtocols.removeMeFromBzProtocol(
      context: context,
      streamedBzModelWithoutMyID: streamedBzModelWithoutMyID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMyAuthorPicProtocol({
    @required BuildContext context,
    @required String bzID,
  }) => AuthorshipExitProtocols.deleteMyAuthorPicProtocol(
      context: context,
      bzID: bzID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeFlyerlessAuthorProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel author,
  }) => AuthorshipExitProtocols.removeFlyerlessAuthorProtocol(
    context: context,
    bzModel: bzModel,
    author: author,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> authorBzExitAfterBzDeletionProtocol({
    @required BuildContext context,
    @required String bzID,
  }) => AuthorshipExitProtocols.authorBzExitAfterBzDeletionProtocol(
    context: context,
    bzID: bzID,
  );
  /// --------------------------------------------------------------------------
}
