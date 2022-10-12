import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteEventsOfAuthorship {
  // -----------------------------------------------------------------------------

  const NoteEventsOfAuthorship();

  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  ///
  static Future<List<NoteModel>> paginateReceivedAuthorshipNotes({
    @required BuildContext context,
    @required String receiverID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (receiverID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        context: context,
        collName: FireColl.notes,
        startAfter: startAfter,
        limit: limit,
        addDocSnapshotToEachMap: true,
        addDocsIDs: true,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: <FireFinder>[
          FireFinder(
            field: 'receiverID',
            comparison: FireComparison.equalTo,
            value: receiverID,
          ),
          // FireFinder(
          //   field: 'type',
          //   comparison: FireComparison.equalTo,
          //   value: NoteModel.cipherNoteType(NoteType.authorship),
          // ),
        ],
      );

      if (Mapper.checkCanLoopList(_maps) == true){

        _notes = NoteModel.decipherNotes(
          maps: _maps,
          fromJSON: false,
        );

      }
    }

    return _notes;
  }
  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  ///
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : START');

    final Phrase _title = await PhraseProtocols.fetchPhid(
      context: context,
      phid: 'phid_authorship_note_title',
      lang: userModelToSendTo.language ?? 'en',
    );

    final Phrase _body = await PhraseProtocols.fetchPhid(
      context: context,
      phid: 'phid_authorship_note_body',
      lang: userModelToSendTo.language ?? 'en',
    );

    final NoteModel _note = NoteModel(
      id: null, // will be defined in composeNoteProtocol
      parties: NoteParties(
        senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
        senderImageURL: bzModel.logo,
        senderType: NotePartyType.bz,
        receiverID: userModelToSendTo.id,
        receiverType: NotePartyType.user,
      ),
      title: _title.value,
      body: _body.value,
      sentTime: DateTime.now(),
      poll: const PollModel(
        buttons: PollModel.acceptDeclineButtons,
        reply: null,
        replyTime: null,
      ),
      token: userModelToSendTo?.fcmToken?.token,
    );

    await NoteProtocols.composeToOne(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipInvitationNote : END');

  }
  // --------------------
  ///
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
        senderImageURL: senderModel.pic,
        senderType: NotePartyType.user,
        receiverID: bzID,
        receiverType: NotePartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorshipReply,
        id: bzID,
      ),
      trigger: TriggerModel.createAuthorshipAcceptanceTrigger(),
    );

    await NoteProtocols.composeToOne(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote : END');

  }
  // -----------------------------------------------------------------------------

  /// CANCELLING

  // --------------------
  ///
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.cancelSentAuthorshipInvitation : START');

    blog('cancelSentAuthorshipInvitation : should delete note');

    // final NoteModel _updated = note.copyWith(
    //   poll: NoteResponse.cancelled,
    //   responseTime: DateTime.now(),
    // );
    //
    // await NoteFireOps.updateNote(
    //   context: context,
    //   newNoteModel: _updated,
    // );

    blog('NoteProtocol.cancelSentAuthorshipInvitation : END');

  }
  // -----------------------------------------------------------------------------
}
