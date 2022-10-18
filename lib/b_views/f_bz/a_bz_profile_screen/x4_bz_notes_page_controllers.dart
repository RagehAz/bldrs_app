// import 'dart:async';
//
// import 'package:bldrs/a_models/a_user/user_model.dart';
// import 'package:bldrs/a_models/b_bz/author_model.dart';
// import 'package:bldrs/a_models/b_bz/bz_model.dart';
// import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
// import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
// import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
// import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// --------------------
/// TESTED : WORKS PERFECT
/*
// void decrementBzObeliskUnseenNotesNumber({
//   @required NotesProvider notesProvider,
//   @required int markedNotesLength,
//   @required String bzID,
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
