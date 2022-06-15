import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/authorships_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
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

/// MARKING NOTES AS SEEN

// ------------------------------------------
void decrementUserObelisksNotesNumber({
  @required NotesProvider notesProvider,
  @required int markedNotesLength,
  @required bool notify,
}){

  if (markedNotesLength > 0){

    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      isIncrementing: false,
      notify: false,
    );
    notesProvider.incrementObeliskNoteNumber(
      value: markedNotesLength,
      navModelID: NavModel.getUserTabNavID(UserTab.notifications),
      isIncrementing: false,
      notify: notify,
    );

  }

}
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

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
