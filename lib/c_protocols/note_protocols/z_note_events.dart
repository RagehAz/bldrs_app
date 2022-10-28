import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/b_trigger_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events_of_authorship.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/bz_flyers_management_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events_of_bz_team_management.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:flutter/material.dart';

class NoteEvent {
  // -----------------------------------------------------------------------------

  const NoteEvent();

  // -----------------------------------------------------------------------------

  /// AUTHORSHIP REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> sendAuthorshipInvitationNote({
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
  static Future<void> sendAuthorshipCancellationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => NoteEventsOfAuthorship.sendAuthorshipCancellationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo
  );
  // -----------------------------------------------------------------------------

  /// AUTHORSHIP RESPONSES

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
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipDeclinationsNote({
    @required BuildContext context,
    @required String bzID,
  }) => NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote(
    context: context,
    bzID: bzID,
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
  ///
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
  ///
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
  ///
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
  ///
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
  /// TESTED : WORKS PERFECT
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
  /// DEPRECATED
  /*
  static Future<void> wipeUserReceivedNotes({
    @required String userID,
  }) => NoteEventsOfProfileDeletion.wipeUserReceivedNotes(
    userID: userID,
  );
  */
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzReceivedNotes({
    @required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzReceivedNotes(
    bzID: bzID,
  );
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzSentAuthorshipNotes({
    @required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzSentAuthorshipNotes(
    bzID: bzID,
  );
   */
  // -----------------------------------------------------------------------------

  /// FLYER INTERACTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerReceivedNewReviewByMe({
    @required BuildContext context,
    @required String text,
    @required String flyerID,
    @required String bzID,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    final bool _imAuthorOfThisBz = AuthorModel.checkUserIsAuthorInThisBz(
      bzID: bzID,
      userModel: _myUserModel,
    );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: _myUserModel.id,
        senderImageURL: _myUserModel.pic,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: '${_myUserModel.name} has written a review over your flyer',
      body: text,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzFlyersNewReviews,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      sendFCM: !_imAuthorOfThisBz, // do not send if im author in this bz
    );

    await NoteProtocols.composeToOneReceiver(
        context: context,
        note: _note
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerReviewReceivedBzReply({
    @required BuildContext context,
    @required String reply,
    @required BzModel bzModel,
    @required String reviewCreatorID
  }) async {

    final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
        bz: bzModel,
        authorID: AuthFireOps.superUserID(),
    );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: bzModel.id,
        senderImageURL: bzModel.logo,
        senderType: PartyType.bz,
        receiverID: reviewCreatorID,
        receiverType: PartyType.user,
      ),
      title: '${_myAuthorModel.name} replied on your flyer review',
      body: reply,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.userReviewsReplies,
        bzID: bzModel.id,
        receiverPartyType: PartyType.user,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        context: context,
        note: _note
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER INTERACTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzIsVerifiedNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    assert(bzModel != null, 'bzModel is null');

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: NoteParties.bldrsSenderID,
        senderImageURL: NoteParties.bldrsLogoStaticURL,
        senderType: PartyType.bldrs,
        receiverID: bzModel.id,
        receiverType: PartyType.bz,
      ),
      title: 'Your business account has been verified',
      body: 'You can now publish flyers directly without waiting its verification process, '
          'Any flyer you or your team publish will be automatically verified',
      sentTime: DateTime.now(),
      trigger: TriggerProtocols.createDeleteAllBzzFlyersLocally(
        bzID: bzModel.id,
      ),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzVerifications,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        context: context,
        note: _note
    );

  }
  // -----------------------------------------------------------------------------
}
