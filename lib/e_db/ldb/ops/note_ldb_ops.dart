import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;

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

// -----------------------------------------------------------------------------

/// UPDATE

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

/// DELETE

// ------------------------------------------
//   static Future<void>
// -----------------------------------------------------------------------------
}
