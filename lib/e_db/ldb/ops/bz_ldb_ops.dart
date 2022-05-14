import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;

class BzLDBOps {

  BzLDBOps();
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------------

// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------

// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------------

// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------------
  static Future<void> deleteBzOps({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.bzz,
      objectID: bzModel.id,
    );

  }
// -----------------------------------------------------------------------------
}
