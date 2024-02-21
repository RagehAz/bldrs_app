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

  /// BZ FOLLOW

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserFollowedBz({
    required BzModel? bzModel,
    required UserModel? userModel,
  }) async {

    if (bzModel != null && userModel != null){

      final String? _bzName = _createBzNameString(bzModel: bzModel);
      final String _bzLangCode = await BzModel.getBzLangCode(bzModel);
      final String? _newFollowerLine = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_new_follower',
        langCode: _bzLangCode,
      ) ?? 'New follower';
      final String _title = '$_bzName $_newFollowerLine';

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: NoteParties(
          senderID: userModel.id,
          senderImageURL: userModel.picPath,
          senderType: PartyType.user,
          receiverID: bzModel.id,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: userModel.name,
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.generateBzTopicID(
          topicID: TopicModel.bzNewFollowers,
          bzID: bzModel.id,
        ),
        // function: null,
        navTo: TriggerModel(
          argument: userModel.id,
          name: ScreenName.userPreview,
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
          note: _note
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER SAVE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserSavedFlyer({
    required FlyerModel? flyerModel,
    required UserModel? userModel,
  }) async {

    if (flyerModel != null && userModel != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: flyerModel.bzID,
      );

      final String? _bzName = _createBzNameString(bzModel: _bzModel);
      final String _bzLangCode = await BzModel.getBzLangCode(_bzModel);
      final String? _newFollowerLine = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_flyer_got_saved',
        langCode: _bzLangCode,
      ) ?? 'Flyer got saved';
      final String _title = '$_bzName $_newFollowerLine';

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: NoteParties(
          senderID: userModel.id,
          senderImageURL: userModel.picPath,
          senderType: PartyType.user,
          receiverID: flyerModel.bzID,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: userModel.name,
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.generateBzTopicID(
          topicID: TopicModel.bzFlyersNewSaves,
          bzID: flyerModel.bzID,
        ),
        poster: PosterModel(
          type: PosterType.flyer,
          modelID: flyerModel.id,
          path: StoragePath.flyers_flyerID_poster(flyerModel.id),
        ),
        // function: null,
        navTo: TriggerModel(
          argument: userModel.id,
          name: ScreenName.userPreview,
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
          note: _note
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER SHARE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserSharedFlyer({
    required FlyerModel? flyerModel,
    required UserModel? userModel,
  }) async {

    if (flyerModel != null && userModel != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: flyerModel.bzID,
      );

      final String? _bzName = _createBzNameString(bzModel: _bzModel);
      final String _bzLangCode = await BzModel.getBzLangCode(_bzModel);
      final String? _newFollowerLine = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_flyer_got_shared',
        langCode: _bzLangCode,
      ) ?? 'Flyer got shared';
      final String _title = '$_bzName $_newFollowerLine';

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: NoteParties(
          senderID: userModel.id,
          senderImageURL: userModel.picPath,
          senderType: PartyType.user,
          receiverID: flyerModel.bzID,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: userModel.name,
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.generateBzTopicID(
          topicID: TopicModel.bzFlyersNewShares,
          bzID: flyerModel.bzID,
        ),
        poster: PosterModel(
          type: PosterType.flyer,
          modelID: flyerModel.id,
          path: StoragePath.flyers_flyerID_poster(flyerModel.id),
        ),
        // function: null,
        navTo: TriggerModel(
          argument: userModel.id,
          name: ScreenName.userPreview,
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
          note: _note
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// HELPERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _createBzNameString({
    required BzModel? bzModel,
  }){
    final String? _bzName = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: bzModel?.name,
        numberOfChars: 10,
    );
    return _bzName == null ? '' : '[$_bzName]';
  }
  // -----------------------------------------------------------------------------
}
