import 'dart:async';

import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTES QUERY

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel bzNotesPaginationQueryModel({
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
    idFieldName: 'id',
    onDataChanged: onDataChanged,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Stream<QuerySnapshot<Object>> bzUnseenNotesStream({
  @required String bzID,
}){

  final Stream<QuerySnapshot<Object>> _stream  = Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.getSuperCollRef(
          aCollName: FireColl.bzz,
          bDocName: bzID,
          cSubCollName: FireSubColl.noteReceiver_receiver_notes,
        ),
        idFieldName: 'id',
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: const <FireFinder>[

          FireFinder(
            field: 'seen',
            comparison: FireComparison.equalTo,
            value: false,
          ),

        ],
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('bzUnseenNotesStream : onDataChanged : ${maps.length} maps');
        }
    ),
  );

  return _stream;
}
// -----------------------------------------------------------------------------

/// USER NOTES QUERY

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel userNotesPaginationQueryModel({
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.users,
      bDocName: AuthFireOps.superUserID(),
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    idFieldName: 'id',
    limit: 7,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Stream<QuerySnapshot<Object>> userUnseenNotesStream({
  @required BuildContext context,
}){

  return Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.getSuperCollRef(
          aCollName: FireColl.users,
          bDocName: AuthFireOps.superUserID(),
          cSubCollName: FireSubColl.noteReceiver_receiver_notes,
        ),
        idFieldName: 'id',
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: const <FireFinder>[

          FireFinder(
            field: 'seen',
            comparison: FireComparison.equalTo,
            value: false,
          ),

        ],
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('userUnseenNotesStream : onDataChanged : ${maps.length} maps');
        }
    ),
  );

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Stream<QuerySnapshot<Object>> userNotesWithPendingReplies({
  @required BuildContext context,
}){

  return Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.getSuperCollRef(
          aCollName: FireColl.users,
          bDocName: AuthFireOps.superUserID(),
          cSubCollName: FireSubColl.noteReceiver_receiver_notes,
        ),
        idFieldName: 'id',
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: const <FireFinder>[

          FireFinder(
            field: 'reply',
            comparison: FireComparison.equalTo,
            value: PollModel.pending,
          ),

        ],
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('userUnseenNotesStream : onDataChanged : ${maps.length} maps');
        }
    ),
  );

}

FireQueryModel userNotesWithPendingRepliesQueryModel(){
  return FireQueryModel(
      collRef: Fire.getSuperCollRef(
        aCollName: FireColl.users,
        bDocName: AuthFireOps.superUserID(),
        cSubCollName: FireSubColl.noteReceiver_receiver_notes,
      ),
      idFieldName: 'id',
      limit: 10,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
      finders: const <FireFinder>[

        FireFinder(
          field: 'topic',
          comparison: FireComparison.equalTo,
          value: TopicModel.userAuthorshipsInvitations,
        ),

      ],
      onDataChanged: (List<Map<String, dynamic>> maps){
        blog('userUnseenNotesStream : onDataChanged : ${maps.length} maps');
      }
  );
}

// -----------------------------------------------------------------------------
