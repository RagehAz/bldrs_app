import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/bz_flyers_management_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events_of_authorship.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events_of_bz_team_management.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/main_phrases_protocols/main_phrases_json_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class NoteEvent {
  // -----------------------------------------------------------------------------

  const NoteEvent();

  // -----------------------------------------------------------------------------

  /// AUTHORSHIP REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipInvitationNote = NoteEventsOfAuthorship.sendAuthorshipInvitationNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipCancellationNote = NoteEventsOfAuthorship.sendAuthorshipCancellationNote;
  // -----------------------------------------------------------------------------

  /// AUTHORSHIP RESPONSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipAcceptanceNote = NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipDeclinationsNote = NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote;
  // -----------------------------------------------------------------------------

  /// Bz Team Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorRoleChangeNote = NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorDeletionNotes = NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendBzDeletionNoteToAllAuthors = NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const  sendNoBzContactAvailableNote = NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote;
  // -----------------------------------------------------------------------------

  /// Bz Flyers Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerUpdateNoteToItsBz = NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerIsVerifiedNoteToBz = NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz;
  // -----------------------------------------------------------------------------

  /// PROFILE DELETION

  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeUserReceivedNotes({
    required String userID,
  }) => NoteEventsOfProfileDeletion.wipeUserReceivedNotes(
    userID: userID,
  );
  */
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzReceivedNotes({
    required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzReceivedNotes(
    bzID: bzID,
  );
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzSentAuthorshipNotes({
    required String bzID,
  }) => NoteEventsOfProfileDeletion.wipeBzSentAuthorshipNotes(
    bzID: bzID,
  );
   */
  // -----------------------------------------------------------------------------

  /// FLYER INTERACTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerReceivedNewReviewByMe({
    required BuildContext context,
    required ReviewModel? reviewModel,
    required String? bzID,
  }) async {

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (reviewModel != null && _myUserModel != null && bzID != null){

      final bool _imAuthorOfThisBz = AuthorModel.checkUserIsAuthorInThisBz(
        bzID: bzID,
        userModel: _myUserModel,
      );

      final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_you_have_new_flyer_review',
        langCode: _myUserModel.language,
      );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: _myUserModel.id,
        senderImageURL: _myUserModel.picPath,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: reviewModel.text,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzFlyersNewReviews,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      sendFCM: !_imAuthorOfThisBz, // do not send if im author in this bz
      navTo: TriggerModel(
        name: ScreenName.flyerReviews,
        argument: ReviewModel.createFlyerIDReviewIDLinkPart(
          flyerID: reviewModel.flyerID,
          reviewID: reviewModel.id,
        ),
        done: const [],
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        note: _note
    );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerReviewReceivedBzReply({
    required ReviewModel? reviewModel,
    required BzModel? bzModel,
    // required String reviewCreatorID
  }) async {

    final AuthorModel? _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
        bz: bzModel,
        authorID: Authing.getUserID(),
    );

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: _myAuthorModel?.userID,
    );

    if (reviewModel !=null && _userModel != null && bzModel != null){

      final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_you_have_new_flyer_review',
        langCode: _userModel.language,
      );

      final NoteModel _note = NoteModel(
        id: null,
        parties: NoteParties(
          senderID: bzModel.id,
          senderImageURL: bzModel.logoPath,
          senderType: PartyType.bz,
          receiverID: reviewModel.userID,
          receiverType: PartyType.user,
        ),
        title: _title,
        body: reviewModel.reply,
        sentTime: DateTime.now(),
        topic: TopicModel.bakeTopicID(
          topicID: TopicModel.userReviewsReplies,
          bzID: bzModel.id,
          receiverPartyType: PartyType.user,
        ),
        navTo: TriggerModel(
          name: ScreenName.flyerReviews,
          argument: ReviewModel.createFlyerIDReviewIDLinkPart(
            flyerID: reviewModel.flyerID,
            reviewID: reviewModel.id,
          ),
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
          note: _note
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER INTERACTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzIsVerifiedNote({
    required BzModel? bzModel,
  }) async {

    // assert(bzModel != null, 'bzModel is null');

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: bzModel?.authors?.first.userID,
    );

    if (bzModel?.id != null && _userModel != null){

      final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_ur_bz_is_verified_now',
        langCode: _userModel.language,
      );

      final String? _body = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_you_may_publish_without_verification',
        langCode: _userModel.language,
      );

      final NoteModel _note = NoteModel(
        id: null,
        parties: NoteParties(
          senderID: Standards.bldrsNotificationSenderID,
          senderImageURL: Standards.bldrsNotificationIconURL,
          senderType: PartyType.bldrs,
          receiverID: bzModel!.id!,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: _body,
        sentTime: DateTime.now(),
        function: NoteFunProtocols.createDeleteAllBzFlyersLocally(
          bzID: bzModel.id!,
        ),
        topic: TopicModel.bakeTopicID(
          topicID: TopicModel.bzVerifications,
          bzID: bzModel.id,
          receiverPartyType: PartyType.bz,
        ),
        navTo: TriggerModel(
          name: TabName.bid_MyBz_Notes, /// WHICH_BZ_EXACTLY
          argument: bzModel.id,
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
          note: _note
      );

    }

  }
  // -----------------------------------------------------------------------------
}
