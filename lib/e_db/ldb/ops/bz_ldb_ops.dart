import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';

class BzLDBOps {

  BzLDBOps();
// -----------------------------------------------------------------------------

  /// CREATE

// -------------------------------
  static Future<void> insertBz({
  @required BzModel bzModel,
}) async {

    await LDBOps.insertMap(
        docName: LDBDoc.bzz,
        input: bzModel.toMap(toJSON: true),
    );

  }
// -------------------------------
  static Future<void> insertBzz({
  @required List<BzModel> bzz,
}) async {

    await LDBOps.insertMaps(
      docName: LDBDoc.bzz,
      inputs: BzModel.cipherBzz(
        bzz: bzz,
        toJSON: true,
      ),
    );

}
// -----------------------------------------------------------------------------

  /// READ

// -------------------------------
  static Future<List<BzModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
    docName: LDBDoc.bzz,
    );

    final List<BzModel> _bzzModels = BzModel.decipherBzz(
        maps: _maps,
        fromJSON: true,
    );

    return _bzzModels;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// -------------------------------
  static Future<void> updateBzOps({
    @required BzModel bzModel,
  }) async {

    await LDBOps.insertMap(
        docName: LDBDoc.bzz,
        input: bzModel.toMap(toJSON: true),
    );

  }
// -----------------------------------------------------------------------------

  /// DELETE

// -------------------------------
  static Future<void> deleteBzOps({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.bzz,
      objectID: bzModel.id,
    );

  }
// -------------------------------
  static Future<void> wipeOut(BuildContext context) async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bzz);

  }
// -------------------------------
}
