import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_trigger_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteEventsOfAuthorship {
  // -----------------------------------------------------------------------------

  const NoteEventsOfAuthorship();

  // -----------------------------------------------------------------------------

  /// REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : START');

    final Phrase _title = await PhraseProtocols.fetchPhid(
      phid: 'phid_authorship_note_title',
      lang: userModelToSendTo.language ?? 'en',
    );

    final Phrase _body = await PhraseProtocols.fetchPhid(
      phid: 'phid_authorship_note_body',
      lang: userModelToSendTo.language ?? 'en',
    );

    final NoteModel _note = NoteModel(
      id: null, // will be defined in composeNoteProtocol
      parties: NoteParties(
        senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
        senderImageURL: bzModel.logoPath,
        senderType: PartyType.bz,
        receiverID: userModelToSendTo.id,
        receiverType: PartyType.user,
      ),
      title: _title.value,
      body: _body.value,
      sentTime: DateTime.now(),
      poll: const PollModel(
        buttons: PollModel.acceptDeclineButtons,
        reply: PollModel.pending,
        replyTime: null,
      ),
      token: userModelToSendTo?.device?.token,
      topic: TopicModel.userAuthorshipsInvitations,
      dismissible: false,
      // poster: PosterModel(
      //   type: PosterType.bz,
      //   modelID: bzModel.id,
      //   url: bzPosterID,
      // ),
      // seen: false,
      // sendFCM: true,
      // sendNote: true,
      trigger: TriggerProtocols.createRefetchBzTrigger(
          bzID: bzModel.id,
      ),
    );

    final NoteModel _uploaded = await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : END');

    return _uploaded;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipCancellationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipCancellationNote : START');

    final Phrase _title = await PhraseProtocols.fetchPhid(
      phid: 'phid_invitation_request_has_been_cancelled',
      lang: userModelToSendTo.language ?? 'en',
    );

    final Phrase _body = await PhraseProtocols.fetchPhid(
      phid: 'phid_invitation_request_had_expired',
      lang: userModelToSendTo.language ?? 'en',
    );

    final NoteModel _note = NoteModel(
      id: null, // will be defined in composeNoteProtocol
      parties: NoteParties(
        senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
        senderImageURL: bzModel.logoPath,
        senderType: PartyType.bz,
        receiverID: userModelToSendTo.id,
        receiverType: PartyType.user,
      ),
      title: _title.value,
      body: _body.value,
      sentTime: DateTime.now(),
      // poll: null,
      token: userModelToSendTo?.device?.token,
      topic: TopicModel.userAuthorshipsInvitations,
      // dismissible: true,
      // poster: PosterModel(
      //   type: PosterType.bz,
      //   modelID: bzModel.id,
      //   url: bzPosterID,
      // ),
      // seen: false,
      // sendFCM: true,
      // sendNote: true,
      // trigger: TriggerProtocols.createRefetchBzTrigger( /// no need
      //   bzID: bzModel.id,
      // ),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipCancellationNote : END');

  }
  // -----------------------------------------------------------------------------

  /// RESPONSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote : START');

    final UserModel senderModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final String _title = '##${senderModel.name} accepted The invitation request';

    final String _body = '##${senderModel.name} has become a part of the team now.';

    final NoteModel _note =  NoteModel(
      id: null,
      parties: NoteParties(
        senderID: senderModel.id,
        senderImageURL: senderModel.picPath,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzAuthorshipsInvitations,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      // trigger: TriggerProtocols.createAuthorshipAcceptanceTrigger(),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipDeclinationsNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote : START');

    final UserModel senderModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final String _title = '##${senderModel.name} declined The invitation request';

    final String _body = '##${senderModel.name} was not added as a team member in this account';

    final NoteModel _note =  NoteModel(
      id: null,
      parties: NoteParties(
        senderID: senderModel.id,
        senderImageURL: senderModel.picPath,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzAuthorshipsInvitations,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      trigger: TriggerProtocols.createDeletePendingAuthorTrigger(
        userID: senderModel.id,
        bzID: bzID,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote : END');

  }
  // -----------------------------------------------------------------------------
}
