import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// ------------------------------------------
void markBzUnseenNotes({
  @required BuildContext context,
  @required List<NoteModel> notes,
  @required NotesProvider notesProvider,
  @required String bzID,
}){

  /// COLLECT NOTES TO MARK FIRST
  final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
    notes: notes,
  );

  /// MARK ON FIREBASE
  unawaited(NoteFireOps.markNotesAsSeen(
      context: context,
      notes: _notesToMark
  ));

  /// DECREMENT UNSEEN BZ NOTES NUMBER IN OBELISK
  _decrementBzObeliskUnseenNotesNumber(
    notesProvider: notesProvider,
    markedNotesLength: _notesToMark.length,
    bzID: bzID,
  );

  /// UN-FLASH PYRAMID
  notesProvider.setIsFlashing(
    setTo: false,
    notify: true,
  );

  /// REMOVE UNSEEN NOTES FROM ALL BZZ UNSEEN NOTES
  notesProvider.removeNotesFromAllBzzUnseenNotes(
    notes: _notesToMark,
    notify: true,
  );


}
// ------------------------------------------
void _decrementBzObeliskUnseenNotesNumber({
  @required NotesProvider notesProvider,
  @required int markedNotesLength,
  @required String bzID,
}){

  if (markedNotesLength > 0){

    /// MARK ON PROVIDER
    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
      notify: false,
      isIncrementing: false,
    );
    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
      notify: false,
      isIncrementing: false,
    );

  }

}
// ------------------------------------------
