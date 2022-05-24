import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;

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
