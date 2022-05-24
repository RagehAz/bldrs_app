import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;

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

/// READ

// -----------------------------------
Future<List<NoteModel>> readSentNotes({
  @required BuildContext context,
  @required String senderID,
  @required int limit,
}) async {

  List<NoteModel> _notes = <NoteModel>[];

  if (senderID != null){

    final List<Map<String, dynamic>> _maps = await FireSearch.mapsByFieldValue(
      context: context,
      collName: FireColl.notes,
      field: 'senderID',
      compareValue: senderID,
      valueIs: FireSearch.ValueIs.equalTo,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
      limit: limit,
    );

    if (Mapper.canLoopList(_maps) == true){

      _notes = NoteModel.decipherNotesModels(
        maps: _maps,
        fromJSON: false,
      );

    }

  }

  return _notes;
}
// -----------------------------------
Future<List<NoteModel>> readReceivedNotes({
  @required BuildContext context,
  @required String recieverID,
  @required int limit,
}) async {

  List<NoteModel> _notes = <NoteModel>[];

  if (recieverID != null){

    final List<Map<String, dynamic>> _maps = await FireSearch.mapsByFieldValue(
      context: context,
      collName: FireColl.notes,
      field: 'recieverID',
      compareValue: recieverID,
      valueIs: FireSearch.ValueIs.equalTo,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
      limit: limit,
    );


    if (Mapper.canLoopList(_maps) == true){

      _notes = NoteModel.decipherNotesModels(
        maps: _maps,
        fromJSON: false,
      );

    }

  }

  return _notes;
}
// -----------------------------------------------------------------------------

/// STREAMING

// -----------------------------------
Widget notiStreamBuilder({
  BuildContext context,
  NotiModelsWidgetsBuilder builder,
  String userID,
}) {
  return StreamBuilder<List<NoteModel>>(
    key: const ValueKey<String>('notifications_stream_builder'),
    stream: getNotiModelsStream(context, userID),
    initialData: const <NoteModel>[],
    builder: (BuildContext ctx, AsyncSnapshot<List<NoteModel>> snapshot) {

      if (StreamChecker.connectionIsLoading(snapshot) == true) {
        blog('the shit is looooooooooooooooooooooooading');
        return const LoadingFullScreenLayer();
      }

      else {
        final List<NoteModel> notiModels = snapshot.data;
        blog('the shit is getting reaaaaaaaaaaaaaaaaaaaaaaal');
        return builder(ctx, notiModels);
      }

    },
  );
}
// -----------------------------------------------------------------------------
Stream<List<NoteModel>> getNotiModelsStream(BuildContext context, String userID) {
  Stream<List<NoteModel>> _notiModelsStream;

  tryAndCatch(
      context: context,
      methodName: 'getNotiModelsStream',
      functions: () {
        final Stream<QuerySnapshot<Object>> _querySnapshots =
        Fire.streamSubCollection(
          collName: FireColl.users,
          docName: userID,
          subCollName: FireSubColl.users_user_notifications,
          orderBy: 'timeStamp', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
          descending: true,
          field: 'dismissed', // NEVER CHANGE THIS -> OR CREATE NEW FIREBASE QUERY INDEX
          compareValue: false,
        );

        blog('getNotiModelsStream : _querySnapshots : $_querySnapshots');

        _notiModelsStream = _querySnapshots.map((QuerySnapshot<Object> qShot) =>
            qShot.docs
                .map((QueryDocumentSnapshot<Object> doc) =>
                NoteModel.decipherNoteModel(
                  map: doc,
                  fromJSON: false,
                ))
                .toList());

        blog('getNotiModelsStream : _notiModelsStream : $_notiModelsStream');
      });

  return _notiModelsStream;
}
// -----------------------------------------------------------------------------
typedef NotiModelsWidgetsBuilder = Widget Function(
    BuildContext context,
    List<NoteModel> notiModels,
    );
// -----------------------------------------------------------------------------

/// UPDATE

// -----------------------------------
Future<void> updateNoteSeen({
  @required BuildContext context,
  @required NoteModel noteModel
}) async {

  if (noteModel.seen != true){

    final NoteModel _updatedNote = noteModel.copyWith(
      seen: true,
      seenTime: DateTime.now(),
    );

    await Fire.updateDoc(
        context: context,
        collName: FireColl.notes,
        docName: noteModel.id,
        input: _updatedNote.toMap(toJSON: false),
    );

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
// -----------------------------------------------------------------------------
