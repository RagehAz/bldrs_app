import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
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

      if (noteModel.sendNote == true){
        await Fire.createSubDoc(
          collName: FireColl.getPartyCollName(noteModel.parties.receiverType),
          docName: noteModel.parties.receiverID,
          subCollName: FireSubColl.noteReceiver_receiver_notes,
          input: noteModel.toMap(toJSON: false),
          onFinish: (DocumentReference ref){
            if (ref != null){
              _output = noteModel.copyWith(
                id: ref.id,
              );
            }
          },
        );
      }

      else {
        _output = noteModel;
      }

    }

    if (onFinished != null){
      onFinished(_output);
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
              if (uploaded != null){
                _output.add(uploaded);
              }
            }
          );

        }),

      ]);

      _success = true;
    }

    return _success == true ? _output : null;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> readNote({
    @required String noteID,
    @required String userID,
  }) async {
    NoteModel _output;

    if (noteID != null && userID != null){

      final Map<String, dynamic> map = await Fire.readSubDoc(
        collName: FireColl.users,
        docName: userID,
        subCollName: FireSubColl.noteReceiver_receiver_notes,
        subDocName: noteID,
        addDocID: true,
        // addDocSnapshot: true,
      );

      _output = NoteModel.decipherNote(
          map: map,
          fromJSON: false,
      );

    }

    return _output;
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
        collName: FireColl.getPartyCollName(note.parties.receiverType),
        docName: note.parties.receiverID,
        subCollName: FireSubColl.noteReceiver_receiver_notes,
        subDocName: note.id,
        input: note.toMap(toJSON: false),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
        collName: FireColl.getPartyCollName(note.parties.receiverType),
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
  // -----------------------------------------------------------------------------
}
