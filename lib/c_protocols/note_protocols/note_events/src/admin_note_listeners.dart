part of note_events;
/// => TAMAM
class _AdminListeners {
  // -----------------------------------------------------------------------------

  const _AdminListeners();

  // -----------------------------------------------------------------------------

  /// ON CREATE USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onCreateAnonymousUser({
    required UserModel? userModel,
  }) async {

    if (userModel != null){

      final ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: userModel.zone,
        invoker: 'onCreateAnonymousUser',
      );
      final Verse? _inZone = ZoneModel.generateInZoneVerse(
          zoneModel: _completeZone
      );

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: const NoteParties(
          senderID: Standards.bldrsNotificationSenderID,
          senderImageURL: Standards.bldrsNotificationIconURL,
          senderType: PartyType.bldrs,
          receiverID: null,
          receiverType: null,
        ),
        title: 'New person',
        body: Verse.bakeVerseToString(verse: _inZone),
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.newAnonymousUser,
        // function: null,
        navTo: null,
      );

      await CloudFunction.call(
          functionName: CloudFunction.callSendFCMToTopic,
          mapToPass: _note.toMap(toJSON: true),
          onFinish: (dynamic result){
            blog('NoteFireOps.createNote : FCM SENT : $result');
          }
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserSignUp({
    required UserModel? userModel,
  }) async {

    if (userModel != null){


      final ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: userModel.zone,
        invoker: 'onCreateAnonymousUser',
      );
      final Verse? _inZone = ZoneModel.generateInZoneVerse(
          zoneModel: _completeZone
      );

      final String? _imageURL = await Storage.createURLByPath(
        path: userModel.picPath,
      );

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: NoteParties(
          senderID: Standards.bldrsNotificationSenderID,
          senderImageURL: _imageURL ?? Standards.bldrsNotificationIconURL,
          senderType: PartyType.bldrs,
          receiverID: null,
          receiverType: null,
        ),
        title: '${userModel.name} joined Bldrs.net',
        body: Verse.bakeVerseToString(verse: _inZone),
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.newUserSignUp,
        // function: null,
        navTo: TriggerModel(
          name: ScreenName.userPreview,
          argument: userModel.id,
          done: const [],
        ),
      );

      await CloudFunction.call(
          functionName: CloudFunction.callSendFCMToTopic,
          mapToPass: _note.toMap(toJSON: true),
          onFinish: (dynamic result){
            blog('NoteFireOps.createNote : FCM SENT : $result');
          }
      );

    }

  }
  // -----------------------------------------------------------------------------

    /// ON CREATE BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzCreated({
    required BzModel? bzModel,
  }) async {

    if (bzModel != null){

      final String? _imageURL = await Storage.createURLByPath(
        path: bzModel.logoPath,
      );

      final NoteModel _note = NoteModel(
        id: Numeric.createUniqueID().toString(),
        parties: NoteParties(
          senderID: Standards.bldrsNotificationSenderID,
          senderImageURL: _imageURL ?? Standards.bldrsNotificationIconURL,
          senderType: PartyType.bldrs,
          receiverID: null,
          receiverType: null,
        ),
        title: 'New Business Account',
        body: bzModel.name,
        sentTime: DateTime.now(),
        // sendFCM: true,
        topic: TopicModel.newBzCreated,
        // function: null,
        navTo: TriggerModel(
          name: ScreenName.bzPreview,
          argument: bzModel.id,
          done: const [],
        ),
      );

      await CloudFunction.call(
          functionName: CloudFunction.callSendFCMToTopic,
          mapToPass: _note.toMap(toJSON: true),
          onFinish: (dynamic result){
            blog('NoteFireOps.createNote : FCM SENT : $result');
          }
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// ON CREATE FLYER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onFlyerCreated({
    required FlyerModel flyerModel,
  }) async {

    final String? _imageURL = await Storage.createURLByPath(
      path: flyerModel.slides?.firstOrNull?.frontPicPath,
    );

    final BzModel? _bzModel = await BzProtocols.fetchBz(
      bzID: flyerModel.bzID,
    );

    final String? _bzName = _bzModel?.name;
    final List<String> _phids = getWords(flyerModel.phids ?? []);
    String? _keywords = Pathing.combinePathNodes(_phids);
    _keywords = TextMod.modifyAllCharactersWith(characterToReplace: '/', replacement: ', ', input: _keywords);

    final NoteModel _note = NoteModel(
      id: Numeric.createUniqueID().toString(),
      parties: NoteParties(
        senderID: Standards.bldrsNotificationSenderID,
        senderImageURL: _imageURL ?? Standards.bldrsNotificationIconURL,
        senderType: PartyType.bldrs,
        receiverID: null,
        receiverType: null,
      ),
      title: 'New Flyer By $_bzName',
      body: _keywords,
      sentTime: DateTime.now(),
      // sendFCM: true,
      topic: TopicModel.newBzCreated,
      // function: null,
      navTo: TriggerModel(
        name: ScreenName.flyerPreview,
        argument: flyerModel.id,
        done: const [],
      ),
    );

    await CloudFunction.call(
        functionName: CloudFunction.callSendFCMToTopic,
        mapToPass: _note.toMap(toJSON: true),
        onFinish: (dynamic result){
          blog('NoteFireOps.createNote : FCM SENT : $result');
        }
    );

  }
  // -----------------------------------------------------------------------------
}
