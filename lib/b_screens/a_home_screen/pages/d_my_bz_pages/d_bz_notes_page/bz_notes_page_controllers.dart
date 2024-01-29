import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/c_noot_action_protocols.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
// -----------------------------------------------------------------------------

/// NOTE TAP

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onBzNoteTap({
  required NoteModel? noteModel,
  required bool mounted,
}) async {

  // blog('namexxx : ${noteModel.navTo.name}');

  if (
      noteModel?.navTo?.name != BldrsTabber.bidMyNotes &&
      noteModel?.navTo?.name != BldrsTabber.bidMyBzNotes /// WHICH_BZ_EXACTLY
  ){

    await NootActionProtocols.onNootTap(
      noteModel: noteModel,
      startFromHome: false,
      mounted: mounted,
    );

  }

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// --------------------
/// TESTED : WORKS PERFECT
/*
// void decrementBzObeliskUnseenNotesNumber({
//   required NotesProvider notesProvider,
//   required int markedNotesLength,
//   required String bzID,
// }){
//
//   if (markedNotesLength > 0){
//
//     final int _mainNaValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
//     );
//
//     final int _updatedMainValue = NavModel.updateObeliskNumber(
//       oldNumber: _mainNaValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     /// MARK ON PROVIDER
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementBzObeliskUnseenNotesNumber',
//       value: _updatedMainValue,
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
//       notify: false,
//     );
//
//     final int _bzNotesTabValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
//     );
//
//     final int _updatedValue = NavModel.updateObeliskNumber(
//       oldNumber: _bzNotesTabValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementBzObeliskUnseenNotesNumber',
//       value: _updatedValue,
//       navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
//       notify: false,
//     );
//
//   }
//
// }
 */
// -----------------------------------------------------------------------------
