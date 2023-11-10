// import 'package:bldrs/a_models/e_notes/a_note_model.dart';
// import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
// import 'package:basics/ldb/methods/ldb_ops.dart';
// import 'package:flutter/material.dart';
//
// class NoteLDBOps {
//   // -----------------------------------------------------------------------------
//
//   const NoteLDBOps();
//
//   // -----------------------------------------------------------------------------
//
//   /// CREATE / INSERT
//
//   // --------------------
//   ///
//   static Future<void> insertNotes(List<NoteModel> notes) async {
//
//     await LDBOps.insertMaps(
//       docName: LDBDoc.notes,
//       primaryKey: LDBDoc.getPrimaryKey(LDBDoc.notes),
//       inputs: NoteModel.cipherNotesModels(
//           notes: notes,
//           toJSON: true
//       ),
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   ///
//   static Future<List<NoteModel>> readAllNotes(BuildContext context) async {
//
//     final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
//       docName: LDBDoc.notes,
//     );
//
//     return NoteModel.decipherNotes(
//         maps: _maps,
//         fromJSON: true,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// UPDATE
//
//   // --------------------
//   ///
//   // -----------------------------------------------------------------------------
//
//   /// DELETE
//
//   // --------------------
//   ///
//   // -----------------------------------------------------------------------------
// }
