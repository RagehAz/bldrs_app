import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteFireOps {
  // -----------------------------------------------------------------------------

  const NoteFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> createNote({
    @required NoteModel noteModel,
    ValueChanged<NoteModel> onFinished,
  }) async {
    NoteModel _output;

    if (noteModel != null){

      await Fire.createSubDoc(
        collName: NoteModel.getNoteCollName(noteModel),
        docName: noteModel.parties.receiverID,
        subCollName: FireSubColl.noteReceiver_receiver_notes,
        input: noteModel.toMap(toJSON: false),
        onFinish: (DocumentReference ref){
          _output = noteModel.copyWith(id: ref.id,);
        },
      );

    if (onFinished != null){
        onFinished(_output);
      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<NoteModel>> createNotes({
    @required NoteModel noteModel,
    @required List<String> receiversIDs,
  }) async {

    final List<NoteModel> _output = <NoteModel>[];
    bool _success = false;

    if (noteModel != null && Mapper.checkCanLoopList(receiversIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(receiversIDs.length, (index){

          final NoteModel _note = noteModel.copyWith(
            parties: noteModel.parties.copyWith(
              receiverID: receiversIDs[index],
            ),
          );

          return createNote(
            noteModel: _note,
            onFinished: (NoteModel uploaded){
              _output.add(uploaded);
            }
          );

        }),

      ]);

      _success = true;
    }

    return _success == true ? _output : null;
  }

  // -----------------------------------------------------------------------------

  /// ALL NOTES PAGINATION

  // --------------------
  ///
  static Future<List<NoteModel>> readReceivedNotes({
    @required String recieverID,
    @required PartyType receiverType,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
    QueryOrderBy orderBy,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      collName: FireColl.notes,
      limit: limit,
      addDocsIDs: true,
      orderBy: orderBy,
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
      finders: <FireFinder>[

        FireFinder(
          field: 'receiverID',
          comparison: FireComparison.equalTo,
          value: recieverID,
        ),

        FireFinder(
          field: 'receiverType',
          comparison: FireComparison.equalTo,
          value: NoteParties.cipherPartyType(receiverType),
        ),

      ],
    );

    final List<NoteModel> _notes = NoteModel.decipherNotes(
      maps: _maps,
      fromJSON: false,
    );

    return _notes;
  }
  // --------------------
  ///
  static Future<List<NoteModel>> paginateAllSentNotes({
    @required String senderID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (senderID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        // startAfter: startAfter,
        // orderBy: 'sentTime',
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        // limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'senderID',
            comparison: FireComparison.equalTo,
            value: senderID,
          ),
        ],
      );

      Mapper.blogMaps(_maps, methodName: 'paginateAllSentNotes');

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
  static Future<List<NoteModel>> paginateAllReceivedNotes({
    @required String recieverID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (recieverID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        startAfter: startAfter,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'recieverID',
            comparison: FireComparison.equalTo,
            value: recieverID,
          ),
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

  /// STREAMING

  // --------------------
  ///
  static Stream<List<NoteModel>> getNoteModelsStream({
    QueryDocumentSnapshot<Object> startAfter,
    int limit,
    QueryOrderBy orderBy,
    List<FireFinder> finders,
  }) {

    Stream<List<NoteModel>> _notiModelsStream;

    tryAndCatch(
        methodName: 'getNoteModelsStream',
        functions: () {

          final Stream<QuerySnapshot<Object>> _querySnapshots = Fire.streamCollection(
            queryModel: FireQueryModel(
                collRef: Fire.getSuperCollRef(aCollName: FireColl.notes),
                startAfter: startAfter,
                limit: limit,
                orderBy: orderBy,
                finders: finders,
                onDataChanged: (List<Map<String, dynamic>> maps){
                  blog('getNoteModelsStream : onDataChanged : ${maps.length} maps');
                }
            ),
          );

          blog('x getNotiModelsStream : _querySnapshots : $_querySnapshots : id : ${_querySnapshots.first}');

          _notiModelsStream = _querySnapshots.map((QuerySnapshot<Object> querySnapshot){

            final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: querySnapshot.docs,
              addDocsIDs: true,
              addDocSnapshotToEachMap: true,
            );

            final List<NoteModel> _notes = NoteModel.decipherNotes(
                maps: _maps,
                fromJSON: false
            );

            return _notes;
          });

          blog('getNotiModelsStream : _notiModelsStream : $_notiModelsStream');
        });

    return _notiModelsStream;
  }
  // --------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateNote({
    @required NoteModel note,
  }) async {

    if (note != null){
      await Fire.updateSubDoc(
        collName: NoteModel.getNoteCollName(note),
        docName: note.parties.receiverID,
        subCollName: FireSubColl.noteReceiver_receiver_notes,
        subDocName: note.id,
        input: note.toMap(toJSON: false),
      );
    }

  }
  // --------------------
  ///
  static Future<void> markNoteAsSeen({
    @required NoteModel noteModel,
  }) async {

    if (noteModel.seen != true){

      final NoteModel _updatedNote = noteModel.copyWith(
        seen: true,
        // seenTime: DateTime.now(),
      );

      await updateNote(
        note: _updatedNote,
      );

    }


  }
  // --------------------
  ///
  static Future<void> markNotesAsSeen({
    @required List<NoteModel> notes,
  }) async {

    if (Mapper.checkCanLoopList(notes) == true){

      /// MARK ON FIREBASE
      for (final NoteModel note in notes){
        unawaited(markNoteAsSeen(
          noteModel: note,
        ));
      }


    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteNote({
    @required NoteModel note,
  }) async {

    if (note != null){

      await Fire.deleteSubDoc(
        collName: NoteModel.getNoteCollName(note),
        docName: note.parties.receiverID,
        subCollName: FireSubColl.noteReceiver_receiver_notes,
        subDocName: note.id,
      );

    }

  }
  // --------------------
  ///
  static Future<void> deleteNotes({
    @required List<NoteModel> notes,
  }) async {

    if (Mapper.checkCanLoopList(notes) == true){

      await Future.wait(<Future>[

        ...List.generate(notes.length, (index){

          return deleteNote(
            note: notes[index],
          );

        }),

      ]);


    }

  }
  // --------------------
  ///
  static Future<void> deleteAllReceivedNotes({
    @required String receiverID,
    @required PartyType receiverType,
  }) async {

    /// TASK : VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION

    final List<NoteModel> _notesToDelete = <NoteModel>[];

    /// READ ALL NOTES
    for (int i = 0; i <= 500; i++){
      final List<NoteModel> _notes = await readReceivedNotes(
        // limit: 10,
        receiverType: receiverType,
        recieverID: receiverID,
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

      await deleteNotes(
        notes: _notesToDelete,
      );

    }

  }
  // --------------------
}
