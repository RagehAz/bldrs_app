import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteEventsOfBzFlyersManagement {
  // -----------------------------------------------------------------------------

  const NoteEventsOfBzFlyersManagement();

  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  ///
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) async {

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : START');

    final NoteModel _note = NoteModel(
      id: null,
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##Flyer has been updated',
      body: '##This Flyer has been updated',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: false,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.flyerUpdate,
        id: bzModel.id,
      ),
      trigger: TriggerModel.createFlyerUpdateTrigger(
          flyerID: flyerID
      ),
    );

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : END');

  }
  // --------------------
  ///
  static Future<void> sendFlyerIsVerifiedNoteToBz({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {

    blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : START');

    final NoteModel _note = NoteModel(
      id: null,
      senderID: NoteModel.bldrsSenderID,
      senderImageURL: NoteModel.bldrsLogoStaticURL,
      senderType: NoteSenderOrRecieverType.bldrs,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: 'Flyer has been verified',
      body: 'This Flyer is now public to be seen and searched by all users',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      // poster: PosterModel(
      //   id: flyerID,
      //   type: PosterType.flyer,
      //   url: null,
      // ),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      trigger: TriggerModel.createFlyerUpdateTrigger(
        flyerID: flyerID,
      ),
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.flyerVerification,
        id: bzID,
      ),
    );

    await NoteProtocols.compose(
        context: context,
        note: _note
    );

    blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : END');

  }
  // -----------------------------------------------------------------------------
}
