import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/b_trigger_protocols.dart';
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
      parties: NoteParties(
        senderID: bzModel.id,
        senderImageURL: bzModel.logo,
        senderType: PartyType.bz,
        receiverID: bzModel.id,
        receiverType: PartyType.bz,
      ),
      title: '##Flyer has been updated',
      body: '##This Flyer has been updated',
      sentTime: DateTime.now(),
      sendFCM: false,
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzFlyersUpdates,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
      trigger: TriggerProtocols.createFlyerRefetchTrigger(
          flyerID: flyerID,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerIsVerifiedNoteToBz({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : START');

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: NoteParties.bldrsSenderID,
        senderImageURL: NoteParties.bldrsLogoStaticURL,
        senderType: PartyType.bldrs,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: 'Flyer has been verified',
      body: 'This Flyer is now public to be seen and searched by all users',
      sentTime: DateTime.now(),
      trigger: TriggerProtocols.createFlyerRefetchTrigger(
        flyerID: flyerID,
      ),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzVerifications,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
        context: context,
        note: _note
    );

    // blog('NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz : END');

  }
  // -----------------------------------------------------------------------------
}
