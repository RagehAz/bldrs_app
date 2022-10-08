import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_response_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteProtocols {
  // -----------------------------------------------------------------------------

  const NoteProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> compose({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    // final NoteModel _finalNoteModel = note.value.copyWith(
    //   sentTime: DateTime.now(),
    // );
    //
    // final List<NoteModel> _uploadedNotes = await NoteFireOps.createNotes(
    //   context: context,
    //   noteModel: _finalNoteModel,
    //   receiversIDs: receiversIDs.value,
    // );
    //
    // /// TASK : SHOULD VISIT THIS onSendNoteOps thing
    // /// MAYBE SAVE A REFERENCE OF THIS NOTE ID SOMEWHERE ON SUB DOC OF BZ
    // /// TO BE EASY TO TRACE AND DELETE WHILE IN DELETE BZ OPS
    //
    // await NoteLDBOps.insertNotes(_uploadedNotes);

    /// REFERENCE
    // await NoteFireOps.createNote(
    //     context: context,
    //     noteModel: _noteModel
    // );


  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------

  static Future<void> renovate({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

  }
  // --------------------
  ///
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel note,
    @required PollModel pollModel,
  }) async {
    blog('RenovateNoteProtocols.modifyNoteResponse : START');

    final NoteModel _newNoteModel = note.copyWith(
      poll: pollModel,
      // responseTime: DateTime.now(),
    );

    NotesProvider.proUpdateNoteEverywhereIfExists(
      context: context,
      noteModel: _newNoteModel,
      notify: true,
    );

    await NoteFireOps.updateNote(
      context: context,
      newNoteModel: _newNoteModel,
    );

    blog('RenovateNoteProtocols.modifyNoteResponse : END');
  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipeNote({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.deleteNoteEverywhereProtocol : START');

    // /// DELETE ATTACHMENT IF IMAGE
    // if (noteModel.posterType == NoteAttachmentType.image){
    //
    //   final String _picName = await Storage.getImageNameByURL(
    //     context: context,
    //     url: noteModel.model,
    //   );
    //
    //   await Storage.deleteStoragePic(
    //     context: context,
    //     storageDocName: StorageDoc.notesBanners,
    //     fileName: _picName,
    //   );
    //
    // }

    /// FIRE DELETE
    await NoteFireOps.deleteNote(
      context: context,
      noteID: note.id,
    );

    /// PRO DELETE
    NotesProvider.proDeleteNoteEverywhereIfExists(
      context: context,
      noteID: note.id,
      notify: true,
    );

    blog('NoteProtocol.deleteNoteEverywhereProtocol : END');
  }
  // -----------------------------------------------------------------------------
}
