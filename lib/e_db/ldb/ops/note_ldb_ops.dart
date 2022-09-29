import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:flutter/material.dart';

class NoteLDBOps {
  // -----------------------------------------------------------------------------

  const NoteLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertNotes(List<NoteModel> notes) async {

    await LDBOps.insertMaps(
      docName: LDBDoc.notes,
      inputs: NoteModel.cipherNotesModels(
          notes: notes,
          toJSON: true
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<NoteModel>> readAllNotes(BuildContext context) async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.notes,
    );

    return NoteModel.decipherNotes(
        maps: _maps,
        fromJSON: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
