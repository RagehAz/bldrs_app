import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteEventsOfProfileDeletion {
  // -----------------------------------------------------------------------------

  const NoteEventsOfProfileDeletion();

  // -----------------------------------------------------------------------------

  /// USER DELETION

  // --------------------
  ///
  static Future<void> wipeUserReceivedNotes({
    @required String userID,
  }) async {

    blog('NoteProtocol.deleteAllUserReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      receiverID: userID,
      receiverType: NotePartyType.user,
    );

    blog('NoteProtocol.deleteAllUserReceivedNotes : END');

  }
  // -----------------------------------------------------------------------------

  /// BZ DELETION

  // --------------------
  ///
  static Future<void> wipeBzReceivedNotes({
    @required String bzID,
  }) async {

    blog('NoteProtocol.deleteAllBzReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      receiverID: bzID,
      receiverType: NotePartyType.bz,
    );

    blog('NoteProtocol.deleteAllBzReceivedNotes : END');

  }
  // --------------------
  ///
  static Future<void> wipeBzSentAuthorshipNotes({
    @required String bzID,
  }) async {

    if (bzID != null){

      final List<NoteModel> _notesToDelete = <NoteModel>[];

      /// READ ALL NOTES
      for (int i = 0; i <= 500; i++){
        final List<NoteModel> _notes = await _paginatePendingSentAuthorshipNotes(
          limit: 10,
          senderID: bzID,
          startAfter: _notesToDelete.isNotEmpty == true ? _notesToDelete?.last?.docSnapshot : null,
        );

        if (Mapper.checkCanLoopList(_notes) == true){
          _notesToDelete.addAll(_notes);
        }

        else {
          break;
        }

      }

      /// DELETE ALL NOTES
      if (Mapper.checkCanLoopList(_notesToDelete) == true){

        await NoteFireOps.deleteNotes(
          notes: _notesToDelete,
        );

      }

    }

  }
  // --------------------
  ///
  static Future<List<NoteModel>> _paginatePendingSentAuthorshipNotes({
    @required String senderID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (senderID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        limit: limit,
        addDocSnapshotToEachMap: true,
        addDocsIDs: true,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        startAfter: startAfter,
        finders: _generatePendingSentAuthorshipNotesFireFinder(
          senderID: senderID,
        ),
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
  // --------------------
  ///
  static List<FireFinder> _generatePendingSentAuthorshipNotesFireFinder({
    @required String senderID,
  }){
    return <FireFinder>[
      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: senderID,
      ),
      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.pending,
      ),
      const FireFinder(
        field: 'seen',
        comparison: FireComparison.equalTo,
        value: false,
      ),
    ];
  }
  // -----------------------------------------------------------------------------
}
