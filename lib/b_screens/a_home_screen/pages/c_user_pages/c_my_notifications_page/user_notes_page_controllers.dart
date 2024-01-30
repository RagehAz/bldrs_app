import 'dart:async';

import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/c_noot_action_protocols.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NOTE TAP

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onUserNoteTap({
  required NoteModel? noteModel,
  required bool mounted,
}) async {

  // noteModel.blogNoteModel(invoker: 'onUserNoteTap');

  if (
      noteModel?.navTo?.name != TabName.bid_My_Notes ||
      noteModel?.navTo?.name != TabName.bid_MyBz_Notes
  ){

    await NootActionProtocols.onNootTap(
      noteModel: noteModel,
    );
  }

}
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onShowNoteOptions({
  required BuildContext context,
  required NoteModel? noteModel,
  required PaginationController? paginationController,
}) async {

  noteModel?.blogNoteModel(invoker: 'onShowNoteOptions');

  await BottomDialog.showButtonsBottomDialog(
      numberOfWidgets: 2,
      titleVerse: const Verse(
        id: 'phid_options',
        translate: true,
      ),
      buttonHeight: 50,
      builder: (_, __){

        return <Widget>[

          BottomDialog.wideButton(
              verse: const Verse(
                id: 'phid_delete',
                translate: true,
              ),
              height: 50,
              onTap: () => _wipeNote(
                context: context,
                noteModel: noteModel,
                paginationController: paginationController,
              ),
          ),


        ];

      }
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _wipeNote({
  required BuildContext context,
  required NoteModel? noteModel,
  required PaginationController? paginationController,
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

  paginationController?.deleteMapByID(
    id: noteModel?.id,
  );

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// --------------------
/*
// void decrementUserObelisksNotesNumber({
//   required NotesProvider notesProvider,
//   required int markedNotesLength,
//   required bool notify,
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
  required String reply,
  required NoteModel noteModel,
}) async {

  // blog('${noteModel.topic} == TopicModel.bzInvitations  ? ${noteModel.topic == TopicModel.bzInvitations}');
  // blog('${noteModel.trigger.name} == TriggerModel.authorshipInvitation  ? ${noteModel.trigger.name == TriggerModel.authorshipInvitation}');
  // blog('${noteModel.parties.senderType} == PartyType.bz  ? ${noteModel.parties.senderType == PartyType.bz}');

  /// AUTHORSHIP NOTES
  if (NoteModel.checkIsAuthorshipNote(noteModel) == true){

    await AuthorshipProtocols.respondToInvitation(
        noteModel: noteModel,
        reply: reply
    );

  }

}
// -----------------------------------------------------------------------------

bool canTapNoteBubble(NoteModel? noteModel){

  if (noteModel == null){
    return false;
  }
  else if (
      noteModel.navTo?.name == TabName.bid_My_Notes
      ||
      noteModel.navTo?.name == TabName.bid_MyBz_Notes
      ||
      noteModel.navTo?.name == null
  ){
    return false;
  }
  else {
    return true;
  }

}
