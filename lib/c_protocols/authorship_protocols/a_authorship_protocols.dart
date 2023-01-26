import 'package:bldrs/c_protocols/authorship_protocols/b_authorship_sending.dart';
import 'package:bldrs/c_protocols/authorship_protocols/d_authorship_responding.dart';
import 'package:bldrs/c_protocols/authorship_protocols/e_authorship_entry.dart';
/// => TAMAM
class AuthorshipProtocols {
  /// --------------------------------------------------------------------------

  const AuthorshipProtocols();

  // -----------------------------------------------------------------------------

  /// REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendRequest = AuthorshipSendingProtocols.sendRequest;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const cancelRequest = AuthorshipSendingProtocols.cancelRequest;
  // -----------------------------------------------------------------------------

  /// RESPONDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static const  respondToInvitation = AuthorshipRespondingProtocols.respond;
  // -----------------------------------------------------------------------------

  /// ENTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const addMeToBz = AuthorshipEntryProtocols.addMeToBz;
  // -----------------------------------------------------------------------------

  /// EXIT

  // --------------------
  /// DEPRECATED
  // static const removeMeFromBz = AuthorshipExitProtocols.removeMeFromBz;
  // // --------------------
  // // /// TESTED : WORKS PERFECT
  // static const deleteMyAuthorPic = AuthorshipExitProtocols.deleteMyAuthorPic;
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static const removeFlyerlessAuthor = AuthorshipExitProtocols.removeFlyerlessAuthor;
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static const removeBzTracesAfterDeletion = AuthorshipExitProtocols.removeBzTracesAfterDeletion;
  /// --------------------------------------------------------------------------
}
