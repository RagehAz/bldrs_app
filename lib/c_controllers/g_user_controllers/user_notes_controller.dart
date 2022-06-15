import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/authorships_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// ------------------------------------------
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  blog('note options');

}
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> markNoteAsSeen({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  if (noteModel.noteType != null){

    if (noteModel.seen != true){

      final NoteModel _updatedNote = noteModel.copyWith(
        seen: true,
        seenTime: DateTime.now(),
      );

      await NoteFireOps.updateNote(
        context: context,
        newNoteModel: _updatedNote,
      );

    }

  }

}
// ------------------------------------------
Future<void> onNoteButtonTap({
  @required BuildContext context,
  @required String response,
  @required NoteModel noteModel,
}) async {

  /// AUTHORSHIP NOTES
  if (noteModel.noteType == NoteType.authorship){

    final BzModel _bzModel = await BzzProvider.proFetchBzModel(
      context: context,
      bzID: noteModel.senderID,
    );

    await respondToAuthorshipNote(
      context: context,
      response: response,
      noteModel: noteModel,
      bzModel: _bzModel,
    );

  }

}
