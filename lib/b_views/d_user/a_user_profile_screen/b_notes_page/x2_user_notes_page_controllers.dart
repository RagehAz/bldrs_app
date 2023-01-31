import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/c_noot_nav_protocols.dart';
import 'package:fire/fire.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NOTE TAP

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onUserNoteTap({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  noteModel.blogNoteModel(invoker: 'onUserNoteTap');

  if (
      noteModel?.navTo?.name != Routing.myUserNotesPage ||
      noteModel?.navTo?.name != Routing.myBzNotesPage
  ){

    await NootNavToProtocols.onNootTap(
      context: context,
      noteModel: noteModel,
      startFromHome: false,
    );

  }

}
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required PaginationController paginationController,
  @required bool mounted,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 1,
      titleVerse: const Verse(
        text: 'phid_options',
        translate: true,
      ),
      buttonHeight: 50,
      builder: (_){

        return <Widget>[

          BottomDialog.wideButton(
              context: context,
              verse: const Verse(
                text: 'phid_delete',
                translate: true,
              ),
              height: 50,
              onTap: () => _wipeNote(
                context: context,
                noteModel: noteModel,
                paginationController: paginationController,
                mounted: mounted,
              ),
          ),

        ];

      }
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _wipeNote({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required PaginationController paginationController,
  @required bool mounted,
}) async {

  /// CLOSE BOTTOM DIALOG
  await Nav.goBack(
    context: context,
    invoker: 'onShowNoteOptions',
  );

  /// WIPE NOTE
  await NoteProtocols.wipeNote(
    note: noteModel,
  );

  paginationController.deleteMapByID(
    id: noteModel.id,
    mounted: mounted,
  );

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// --------------------
/*
// void decrementUserObelisksNotesNumber({
//   @required NotesProvider notesProvider,
//   @required int markedNotesLength,
//   @required bool notify,
// }){
//
//   blog('decrementUserObelisksNotesNumber : receiving $markedNotesLength notes');
//
//   if (markedNotesLength > 0){
//
//     final int _mainValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
//     );
//
//     final int _mainUpdated = NavModel.updateObeliskNumber(
//       oldNumber: _mainValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementUserObelisksNotesNumber',
//       value: _mainUpdated,
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
//       notify: false,
//     );
//
//     final int _userNotesTabValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getUserTabNavID(UserTab.notifications),
//     );
//
//     final int _userNotesTabValueUpdated = NavModel.updateObeliskNumber(
//       oldNumber: _userNotesTabValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementUserObelisksNotesNumber',
//       value: _userNotesTabValueUpdated,
//       navModelID: NavModel.getUserTabNavID(UserTab.notifications),
//       notify: notify,
//     );
//
//   }
//
// }
*/
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// --------------------
///
Future<void> onNoteButtonTap({
  @required BuildContext context,
  @required String reply,
  @required NoteModel noteModel,
}) async {

  // blog('${noteModel.topic} == TopicModel.bzInvitations  ? ${noteModel.topic == TopicModel.bzInvitations}');
  // blog('${noteModel.trigger.name} == TriggerModel.authorshipInvitation  ? ${noteModel.trigger.name == TriggerModel.authorshipInvitation}');
  // blog('${noteModel.parties.senderType} == PartyType.bz  ? ${noteModel.parties.senderType == PartyType.bz}');

  /// AUTHORSHIP NOTES
  if (NoteModel.checkIsAuthorshipNote(noteModel) == true){

    await AuthorshipProtocols.respondToInvitation(
        context: context,
        noteModel: noteModel,
        reply: reply
    );

  }

}
// -----------------------------------------------------------------------------

bool canTapNoteBubble(NoteModel noteModel){

  if (noteModel == null){
    return false;
  }
  else if (
      noteModel.navTo.name == Routing.myUserNotesPage
      ||
      noteModel.navTo.name == Routing.myBzNotesPage
      ||
      noteModel.navTo.name == null
  ){
    return false;
  }
  else {
    return true;
  }

}
