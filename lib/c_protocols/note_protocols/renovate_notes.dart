import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_response_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class RenovateNoteProtocols {
  // -----------------------------------------------------------------------------

  const RenovateNoteProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required PollModel pollModel,
  }) async {
    blog('RenovateNoteProtocols.modifyNoteResponse : START');

    final NoteModel _newNoteModel = noteModel.copyWith(
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
}
