import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// ------------------------------------------
/// TESTED : WORKS PERFECT
FireQueryModel bzReceivedNotesPaginationQueryParameters({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    finders: <FireFinder>[

      FireFinder(
        field: 'receiverID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

    ],
    onDataChanged: onDataChanged,
  );

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// ------------------------------------------
/// TESTED : WORKS PERFECT
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
// ------------------------------------------
