import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/main_phrases_protocols/main_phrases_json_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class NoteEventsOfAuthorship {
  // -----------------------------------------------------------------------------

  const NoteEventsOfAuthorship();

  // -----------------------------------------------------------------------------

  /// REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel?> sendAuthorshipInvitationNote({
    required BzModel? bzModel,
    required UserModel? userModelToSendTo,
  }) async {

    NoteModel? _uploaded;

    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : START');

    if (bzModel != null && userModelToSendTo != null){

      final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_you_are_invited_to_become_author',
        langCode: userModelToSendTo.language,
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
        title: _title,
        body: bzModel.name,
        sentTime: DateTime.now(),
        poll: const PollModel(
          buttons: PollModel.acceptDeclineButtons,
          reply: PollModel.pending,
          replyTime: null,
        ),
        token: userModelToSendTo.device?.token,
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
        function: NoteFunProtocols.createRefetchBzTrigger(
          bzID: bzModel.id,
        ),
        navTo: const TriggerModel(
          name: TabName.bid_My_Notes,
          argument: null,
          done: [],
        ),
      );

      _uploaded = await NoteProtocols.composeToOneReceiver(
        note: _note,
      );

    }


    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : END');

    return _uploaded;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipCancellationNote({
    required BzModel? bzModel,
    required UserModel? userModelToSendTo,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipCancellationNote : START');

    if (bzModel != null && userModelToSendTo != null) {

      final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_membership_invitation_is_cancelled',
        langCode: userModelToSendTo.language,
      );

      final NoteModel _note = NoteModel(
        id: null,
        // will be defined in composeNoteProtocol
        parties: NoteParties(
          senderID: bzModel.id,

          /// HAS TO BE BZ ID NOT AUTHOR ID
          senderImageURL: bzModel.logoPath,
          senderType: PartyType.bz,
          receiverID: userModelToSendTo.id,
          receiverType: PartyType.user,
        ),
        title: _title,
        body: bzModel.name,
        sentTime: DateTime.now(),
        // poll: null,
        token: userModelToSendTo.device?.token,
        topic: TopicModel.userAuthorshipsInvitations,
        navTo: const TriggerModel(
          name: TabName.bid_My_Notes,
          argument: null,
          done: [],
        ),
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
        note: _note,
      );

    }

    blog('NoteEventsOfAuthorship.sendAuthorshipCancellationNote : END');

  }
  // -----------------------------------------------------------------------------

  /// RESPONSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    required BuildContext context,
    required String? bzID,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote : START');

    final UserModel? senderModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_membership_invitation_is_accepted',
        langCode: senderModel?.language,
    );

    final NoteModel _note =  NoteModel(
      id: null,
      parties: NoteParties(
        senderID: senderModel?.id,
        senderImageURL: senderModel?.picPath,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: senderModel?.name,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzAuthorshipsInvitations,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: TabName.bid_MyBz_Notes, /// WHICH_BZ_EXACTLY
        argument: bzID,
        done: const [],
      ),
      // trigger: TriggerProtocols.createAuthorshipAcceptanceTrigger(),
    );

    await NoteProtocols.composeToOneReceiver(
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipDeclinationsNote({
    required BuildContext context,
    required String? bzID,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote : START');

    final UserModel? senderModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final String? _title = await MainPhrasesJsonOps.translatePhid(
        phid: 'phid_membership_invitation_is_declined',
        langCode: senderModel?.language,
    );

    final NoteModel _note =  NoteModel(
      id: null,
      parties: NoteParties(
        senderID: senderModel?.id,
        senderImageURL: senderModel?.picPath,
        senderType: PartyType.user,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: senderModel?.name,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzAuthorshipsInvitations,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      function: NoteFunProtocols.createDeletePendingAuthorTrigger(
        userID: senderModel?.id,
        bzID: bzID,
      ),
      navTo: TriggerModel(
        name: TabName.bid_MyBz_Notes, /// WHICH_BZ_EXACTLY
        argument: bzID,
        done: const [],
      ),
    );

    await NoteProtocols.composeToOneReceiver(
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote : END');

  }
  // -----------------------------------------------------------------------------
}
