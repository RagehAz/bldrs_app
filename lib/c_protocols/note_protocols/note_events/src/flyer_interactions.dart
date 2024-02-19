part of note_events;

class _NoteEventsOfFlyerInteractions {
  // -----------------------------------------------------------------------------

  const _NoteEventsOfFlyerInteractions();

  // -----------------------------------------------------------------------------

  /// AUTHORSHIP RESPONSES

  // -----------------------------------------------------------------------------

  /// FLYER REVIEWS

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
}
