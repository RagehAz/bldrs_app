import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;

class BzLDBOps {

  BzLDBOps();
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------------
  static Future<void> createBzOps({
  @required BzModel bzModel,
}) async {

    await LDBOps.insertMap(
        docName: LDBDoc.bzz,
        input: bzModel.toMap(toJSON: true),
    );

  }
// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------

// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------------
  static Future<void> updateBzOps({
    @required BzModel bzModel,
  }) async {

    await LDBOps.updateMap(
        objectID: bzModel.id,
        docName: LDBDoc.bzz,
        input: bzModel.toMap(toJSON: true),
    );

  }
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
// ----------------------------------------
  static Future<void> wipeOut(BuildContext context) async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bzz);

  }
// ----------------------------------------
}
