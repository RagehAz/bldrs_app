import 'dart:async';

import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // finders: <FireFinder>[
    //
    //   FireFinder(
    //     field: 'receiverID',
    //     comparison: FireComparison.equalTo,
    //     value: bzID,
    //   ),
    //
    // ],
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

/// USER NOTES QUERY

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel getUserNotesPaginationQueryModel({
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.users,
      bDocName: AuthFireOps.superUserID(),
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    // finders: <FireFinder>[
    //   FireFinder(
    //     field: 'receiverID',
    //     comparison: FireComparison.equalTo,
    //     value: AuthFireOps.superUserID(),
    //   ),
    // ],
    onDataChanged: onDataChanged,
  );

}
// --------------------
///
Stream<QuerySnapshot<Object>> getUserUnseenNotesStream({
  @required BuildContext context,
}){

  return Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.getSuperCollRef(
          aCollName: FireColl.users,
          bDocName: AuthFireOps.superUserID(),
          cSubCollName: FireSubColl.noteReceiver_receiver_notes,
        ),
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: const <FireFinder>[

          // FireFinder(
          //   field: 'receiverID',
          //   comparison: FireComparison.equalTo,
          //   value: _userModel.id,
          // ),

          FireFinder(
            field: 'seen',
            comparison: FireComparison.equalTo,
            value: false,
          ),

        ],
        // onDataChanged: (List<Map<String, dynamic>> maps){
        //   blog('_userUnseenReceivedNotesStream : onDataChanged : ${maps.length} maps');
        // }
    ),
  );

}
// -----------------------------------------------------------------------------
