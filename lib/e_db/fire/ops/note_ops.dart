import 'dart:async';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// CREATE

// -----------------------------------
Future<void> createNote({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  if (noteModel != null){
    await Fire.createDoc(
      context: context,
      collName: FireColl.notes,
      input: noteModel.toMap(toJSON: false),
    );
  }

}
// -----------------------------------------------------------------------------

/// ALL NOTES PAGINATION

// -----------------------------------
Future<List<NoteModel>> readReceivedNotes({
  @required BuildContext context,
  @required String recieverID,
  @required NoteReceiverType receiverType,
  int limit = 10,
  QueryDocumentSnapshot<Object> startAfter,
  QueryOrderBy orderBy,
}) async {

  final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
    context: context,
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
          value: NoteModel.cipherNoteReceiverType(receiverType),
      ),

    ],
  );

  final List<NoteModel> _notes = NoteModel.decipherNotes(
      maps: _maps,
      fromJSON: false,
  );

  return _notes;
}

Future<List<NoteModel>> paginateAllSentNotes({
  @required BuildContext context,
  @required String senderID,
  @required int limit,
  @required QueryDocumentSnapshot<Object> startAfter,
}) async {

  List<NoteModel> _notes = <NoteModel>[];

  if (senderID != null){

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
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
// -----------------------------------
Future<List<NoteModel>> paginateAllReceivedNotes({
  @required BuildContext context,
  @required String recieverID,
  @required int limit,
  @required QueryDocumentSnapshot<Object> startAfter,
}) async {

  List<NoteModel> _notes = <NoteModel>[];

  if (recieverID != null){

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
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

/// AUTHORSHIP NOTES PAGINATION

// -----------------------------------
List<FireFinder> generatePendingSentAuthorshipNotesFireFinder({
  @required String senderID,
}){
  return <FireFinder>[
    FireFinder(
      field: 'senderID',
      comparison: FireComparison.equalTo,
      value: senderID,
    ),
    FireFinder(
      field: 'noteType',
      comparison: FireComparison.equalTo,
      value: NoteModel.cipherNoteType(NoteType.authorship),
    ),
    FireFinder(
      field: 'seen',
      comparison: FireComparison.equalTo,
      value: false,
    ),
  ];
}
// -----------------------------------
Future<List<NoteModel>> paginatePendingSentAuthorshipNotes({
  @required BuildContext context,
  @required String senderID,
  @required int limit,
  @required QueryDocumentSnapshot<Object> startAfter,
}) async {

  List<NoteModel> _notes = <NoteModel>[];

  if (senderID != null){

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
      collName: FireColl.notes,
      limit: limit,
      addDocSnapshotToEachMap: true,
      addDocsIDs: true,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
      startAfter: startAfter,
      finders: generatePendingSentAuthorshipNotesFireFinder(
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
// -----------------------------------
Future<List<NoteModel>> paginateReceivedAuthorshipNotes({
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
        FireFinder(
          field: 'noteType',
          comparison: FireComparison.equalTo,
          value: NoteModel.cipherNoteType(NoteType.authorship),
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
// -----------------------------------

/// STREAMING

// -----------------------------------
/// TESTED : WORKS PERFECT
Stream<List<NoteModel>> getNoteModelsStream({
  @required BuildContext context,
  QueryDocumentSnapshot<Object> startAfter,
  int limit,
  QueryOrderBy orderBy,
  List<FireFinder> finders,
}) {

  Stream<List<NoteModel>> _notiModelsStream;

  tryAndCatch(
      context: context,
      methodName: 'getNoteModelsStream',
      functions: () {

        final Stream<QuerySnapshot<Object>> _querySnapshots = Fire.streamCollection(
          collName: FireColl.notes,
          startAfter: startAfter,
          limit: limit,
          orderBy: orderBy,
          finders: finders,
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
// -----------------------------------
/// TESTED : WORKS PERFECT
typedef NotiModelsWidgetsBuilder = Widget Function(
    BuildContext context,
    List<NoteModel> notiModels,
    );
// -----------------------------------------------------------------------------

/// UPDATE

// -----------------------------------
/// TESTED : WORKS PERFECT
Future<void> updateNote({
  @required BuildContext context,
  @required NoteModel newNoteModel,
}) async {

  if (newNoteModel != null){
    await Fire.updateDoc(
      context: context,
      collName: FireColl.notes,
      docName: newNoteModel.id,
      input: newNoteModel.toMap(toJSON: false),
    );
  }

}
// -----------------------------------
/// TESTED : WORKS PERFECT
Future<void> markNoteAsSeen({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  if (noteModel.seen != true){

    final NoteModel _updatedNote = noteModel.copyWith(
      seen: true,
      seenTime: DateTime.now(),
    );

    await updateNote(
      context: context,
      newNoteModel: _updatedNote,
    );

  }


}
// -----------------------------------
/// TESTED : WORKS PERFECT
Future<void> markNotesAsSeen({
  @required BuildContext context,
  @required List<NoteModel> notes,
}) async {

  if (Mapper.checkCanLoopList(notes) == true){

    /// MARK ON FIREBASE
    for (final NoteModel note in notes){
      unawaited(markNoteAsSeen(
        context: context,
        noteModel: note,
      ));
    }


  }

}
// -----------------------------------------------------------------------------

/// DELETE

// -----------------------------------
Future<void> deleteAllSentNotes({
  @required BuildContext context,
  @required String senderID,
}) async {

  if (senderID != null){

    ///
    blog('SHOULD DELETE ALL SENT NOTES BY $senderID');

  }

}
// -----------------------------------
Future<void> deleteNote({
  @required BuildContext context,
  @required String noteID,
}) async {

  if (noteID != null){

    await Fire.deleteDoc(
        context: context,
        collName: FireColl.notes,
        docName: noteID,
    );

  }

}
// -----------------------------------
Future<void> deleteNotes({
  @required BuildContext context,
  @required List<NoteModel> notes,
}) async {

  if (Mapper.checkCanLoopList(notes) == true){

    for (final NoteModel note in notes){

      await deleteNote(
          context: context,
          noteID: note.id,
      );

    }

  }

}
// -----------------------------------
Future<void> deleteAllReceivedNotes({
  @required BuildContext context,
  @required String receiverID,
  @required NoteReceiverType receiverType,
}) async {

  final List<NoteModel> _notesToDelete = <NoteModel>[];

  /// READ ALL NOTES
  for (int i = 0; i <= 500; i++){
    final List<NoteModel> _notes = await readReceivedNotes(
      context: context,
      // limit: 10,
      receiverType: receiverType,
      recieverID: receiverID,
      startAfter: _notesToDelete?.last?.docSnapshot,
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
      context: context,
      notes: _notesToDelete,
    );

  }

}
