import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTES QUERY

// --------------------
///
FireQueryModel getBzNotesQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.bzz,
      bDocName: bzID,
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    finders: <FireFinder>[

      FireFinder(
        field: 'receiverID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

    ],
    onDataChanged: onDataChanged,
  );

}
// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY MODEL

// --------------------
/// DEPRECATED
/*
FireQueryModel bzSentPendingAuthorshipNotesStreamQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.bzz,
      bDocName: bzID,
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    limit: 50,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      // FireFinder(
      //   field: 'noteType',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherNoteType(NoteType.authorship),
      // ),

      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.pending,
      ),

    ],
  );

}
 */
// --------------------
/// DEPRECATED
/*
FireQueryModel bzSentDeclinedAndCancelledNotesPaginatorQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(aCollName: FireColl.notes),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      // FireFinder(
      //   field: 'noteType',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherNoteType(NoteType.authorship),
      // ),

      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.decline,
      ),

      // /// TASK : ??? will this work ?
      // FireFinder(
      //   field: 'response',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherResponse(NoteResponse.cancelled),
      // ),

    ],
  );

}
 */
// -----------------------------------------------------------------------------
