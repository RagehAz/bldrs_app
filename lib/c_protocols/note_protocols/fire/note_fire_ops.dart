import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class NoteFireOps {
  // -----------------------------------------------------------------------------

  const NoteFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel?> createNote({
    required NoteModel? noteModel,
    ValueChanged<NoteModel?>? onFinished,
  }) async {
    NoteModel? _output;

    if (noteModel != null){

      if (noteModel.sendNote != null && noteModel.sendNote! == true){

        blog('CREATING NOTE FOR (${noteModel.parties?.receiverID}) ${noteModel.parties?.receiverType}');

        final String? docID = await Fire.createDoc(
          coll: FireColl.getPartyCollName(noteModel.parties?.receiverType),
          doc: noteModel.parties?.receiverID,
          subColl: FireSubColl.noteReceiver_receiver_notes,
          input: noteModel.toMap(toJSON: false),
        );

         if (docID != null){
              _output = noteModel.copyWith(
                id: docID,
              );
            }

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
    required NoteModel? noteModel,
    required List<String>? receiversIDs,
  }) async {

    final List<NoteModel> _output = <NoteModel>[];
    bool _success = false;

    if (noteModel != null && Lister.checkCanLoopList(receiversIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(receiversIDs!.length, (index){

          final NoteModel _note = noteModel.copyWith(
            parties: noteModel.parties?.copyWith(
              receiverID: receiversIDs[index],
            ),
          );

          return createNote(
            noteModel: _note,
            onFinished: (NoteModel? uploaded){
              if (uploaded != null){
                _output.add(uploaded);
              }
            }
          );

        }),

      ]);

      _success = true;
    }

    return _success == true ? _output : [];
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel?> readNote({
    required String? noteID,
    required String? userID,
  }) async {
    NoteModel? _output;

    if (noteID != null && userID != null){

      final Map<String, dynamic>? map = await Fire.readDoc(
        coll: FireColl.users,
        doc: userID,
        subColl: FireSubColl.noteReceiver_receiver_notes,
        subDoc: noteID,
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
    required NoteModel? note,
  }) async {

    if (note != null && note.parties?.receiverID != null){

      await Fire.updateDoc(
        coll: FireColl.getPartyCollName(note.parties?.receiverType),
        doc: note.parties!.receiverID!,
        subColl: FireSubColl.noteReceiver_receiver_notes,
        subDoc: note.id,
        input: note.toMap(toJSON: false),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> markNoteAsSeen({
    required NoteModel noteModel,
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
    required List<NoteModel>? notes,
  }) async {

    if (Lister.checkCanLoopList(notes) == true){

      /// MARK ON FIREBASE
      for (final NoteModel note in notes!){
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
    required NoteModel? note,
  }) async {

    if (note != null && note.parties?.receiverID != null){

      await Fire.deleteDoc(
        coll: FireColl.getPartyCollName(note.parties?.receiverType),
        doc: note.parties!.receiverID!,
        subColl: FireSubColl.noteReceiver_receiver_notes,
        subDoc: note.id,
      );

    }

  }
  // --------------------
  ///
  static Future<void> deleteNotes({
    required List<NoteModel>? notes,
  }) async {

    if (Lister.checkCanLoopList(notes) == true){

      await Future.wait(<Future>[

        ...List.generate(notes!.length, (index){

          return deleteNote(
            note: notes[index],
          );

        }),

      ]);


    }

  }
  // -----------------------------------------------------------------------------
}
