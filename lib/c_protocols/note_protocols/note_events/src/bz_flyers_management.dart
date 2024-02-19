part of note_events;
/// => TAMAM
class _NoteEventsOfBzFlyersManagement {
  // -----------------------------------------------------------------------------

  const _NoteEventsOfBzFlyersManagement();

  // -----------------------------------------------------------------------------

  /// FLYER RENOVATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    required BzModel? bzModel,
    required String? flyerID,
  }) async {

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : START');

    if (bzModel != null && flyerID != null) {

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: bzModel.authors?.first.userID,
      );

      final FlyerModel? _flyer = await FlyerProtocols.fetchFlyer(
        flyerID: flyerID,
      );

      if (_flyer != null) {

        final String? _title = await MainPhrasesJsonOps.translatePhid(
          phid: 'phid_flyer_has_been_updated',
          langCode: _userModel?.language,
        );

        final NoteModel _note = NoteModel(
          id: null,
          parties: NoteParties(
            senderID: bzModel.id,
            senderImageURL: bzModel.logoPath,
            senderType: PartyType.bz,
            receiverID: bzModel.id,
            receiverType: PartyType.bz,
          ),
          title: _title,
          body: _flyer.headline,
          sentTime: DateTime.now(),
          sendFCM: false,
          topic: TopicModel.bakeTopicID(
            topicID: TopicModel.bzFlyersUpdates,
            bzID: bzModel.id,
            receiverPartyType: PartyType.bz,
          ),
          function: NoteFunProtocols.createFlyerRefetchTrigger(
            flyerID: flyerID,
          ),
          navTo: TriggerModel(
            name: ScreenName.flyerPreview,
            argument: flyerID,
            done: const [],
          ),
        );

        await NoteProtocols.composeToOneReceiver(
          note: _note,
        );

      }

    }

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : END');

  }
  // -----------------------------------------------------------------------------

  /// FLYER VERIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerIsVerifiedNoteToBz({
    required String flyerID,
    required String bzID,
  }) async {

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : START');

    final BzModel? _bzModel = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: _bzModel?.authors?.first.userID,
    );

    final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_flyer_has_been_verified',
        langCode: _userModel?.language,
    );

    final String? _body = await MainPhrasesJsonOps.translatePhid(
      phid: 'phid_flyer_is_public_now_and_can_be_seen',
      langCode: _userModel?.language,
    );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: Standards.bldrsNotificationSenderID,
        senderImageURL: Standards.bldrsNotificationIconURL,
        senderType: PartyType.bldrs,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      function: NoteFunProtocols.createFlyerRefetchTrigger(
        flyerID: flyerID,
      ),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzVerifications,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: ScreenName.flyerPreview,
        argument: flyerID,
        done: const [],
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        note: _note
    );

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : END');

  }
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
          name: TabName.bid_MyBz_Notes,
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
