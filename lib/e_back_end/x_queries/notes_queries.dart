import 'dart:async';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTES QUERY

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel bzNotesPaginationQueryModel({
  required String? bzID,
}){

  return FireQueryModel(
    coll: FireColl.bzz,
    doc: bzID,
    subColl: FireSubColl.noteReceiver_receiver_notes,
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Stream<List<Map<String, dynamic>>>? bzUnseenNotesStream({
  required String? bzID,
}){

  final Stream<List<Map<String, dynamic>>>? _stream = Fire.streamColl(
    queryModel: FireQueryModel(
      coll: FireColl.bzz,
      doc: bzID,
      subColl: FireSubColl.noteReceiver_receiver_notes,
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: false),
      finders: const <FireFinder>[
        FireFinder(
          field: 'seen',
          comparison: FireComparison.equalTo,
          value: false,
        ),
      ],
    ),
  );

  return _stream;
}
// -----------------------------------------------------------------------------

/// USER NOTES QUERY

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel userNotesPaginationQueryModel(){

  return FireQueryModel(
    coll: FireColl.users,
    doc: Authing.getUserID(),
    subColl: FireSubColl.noteReceiver_receiver_notes,
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Stream<List<Map<String, dynamic>>>? userUnseenNotesStream(){

  return Fire.streamColl(
    queryModel: FireQueryModel(
      coll: FireColl.users,
      doc: Authing.getUserID(),
      subColl: FireSubColl.noteReceiver_receiver_notes,
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: false),
      finders: const <FireFinder>[
        FireFinder(
          field: 'seen',
          comparison: FireComparison.equalTo,
          value: false,
        ),
      ],
    ),
  );

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Stream<List<Map<String, dynamic>>?>? userNotesWithPendingReplies({
  required BuildContext context,
}){

  return Fire.streamColl(
    queryModel: FireQueryModel(
      coll: FireColl.users,
      doc: Authing.getUserID(),
      subColl: FireSubColl.noteReceiver_receiver_notes,
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: false),
      finders: const <FireFinder>[
        FireFinder(
          field: 'reply',
          comparison: FireComparison.equalTo,
          value: PollModel.pending,
        ),
      ],
    ),
  );

}
// --------------------
///
FireQueryModel userNotesWithPendingRepliesQueryModel() {
  return FireQueryModel(
    coll: FireColl.users,
    doc: Authing.getUserID(),
    subColl: FireSubColl.noteReceiver_receiver_notes,
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: false),
    finders: const <FireFinder>[
      FireFinder(
        field: 'topic',
        comparison: FireComparison.equalTo,
        value: TopicModel.userAuthorshipsInvitations,
      ),
    ],
  );
}
// -----------------------------------------------------------------------------

/// ALL NOTES QUERY

// --------------------
FireQueryModel allNotesPaginationQueryModel({
  required PartyType receiverPartyType,
  required String? receiverID,
}){

 return FireQueryModel(
   coll: FireColl.getPartyCollName(receiverPartyType),
   doc: receiverID,
   subColl: FireSubColl.noteReceiver_receiver_notes,
   orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
   limit: 7,
 );

}
// -----------------------------------------------------------------------------
