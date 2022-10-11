import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:flutter/material.dart';

class NoteRealOps {
  // -----------------------------------------------------------------------------

  const NoteRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  static Future<NoteModel> create({
    @required NoteModel note,
    @required BuildContext context,
  }) async {

    NoteModel _uploaded;

    if (NoteModel.checkCanSendNote(note) == true){

      final Map<String, dynamic> _map = await Real.createDocInPath(
        context: context,
        pathWithoutDocName: '${RealColl.notes}/${note.parties.receiverID}',
        addDocIDToOutput: true,
        map: note.toMap(toJSON: true),
      );

      _uploaded = NoteModel.decipherNote(map: _map, fromJSON: true);

    }

    return _uploaded;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /*
  static Future<List<NoteModel>> readNotes() async {}
   */
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------

  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------

  // -----------------------------------------------------------------------------
  void fuck(){}
  // -----------------------------------------------------------------------------
}
