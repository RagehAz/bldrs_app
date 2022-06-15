import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';

class NoteLDBOps {

  NoteLDBOps();
// -----------------------------------------------------------------------------

/// CREATE / INSERT

// ------------------------------------------
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

// -----------------------------------------------------------------------------
  static Future<List<NoteModel>> readAllNotes(BuildContext context) async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
        docName: LDBDoc.notes,
    );

    return NoteModel.decipherNotes(maps: _maps, fromJSON: true);
  }
// -----------------------------------------------------------------------------

/// UPDATE

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

/// DELETE

// ------------------------------------------
//   static Future<void>
// -----------------------------------------------------------------------------
}
