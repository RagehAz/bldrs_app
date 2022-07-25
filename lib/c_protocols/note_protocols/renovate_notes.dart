

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class RenovateNoteProtocols {
// -----------------------------------------------------------------------------

  RenovateNoteProtocols();

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required NoteResponse response,
  }) async {
    blog('RenovateNoteProtocols.modifyNoteResponse : START');

    final NoteModel _newNoteModel = noteModel.copyWith(
      response: response,
      responseTime: DateTime.now(),
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
}
