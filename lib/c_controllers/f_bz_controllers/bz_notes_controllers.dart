import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// ------------------------------------------
void decrementBzObeliskUnseenNotesNumber({
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
