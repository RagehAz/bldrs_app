part of note_events;
/// => TAMAM
class _NoteEventsOfUserOps {
  // -----------------------------------------------------------------------------

  const _NoteEventsOfUserOps();

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
        sendFCM: false,
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
        sendFCM: false,
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
}
