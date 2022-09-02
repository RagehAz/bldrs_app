import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class BzLDBOps {
// -----------------------------------------------------------------------------

  const BzLDBOps();

// -----------------------------------------------------------------------------

  /// CREATE

// -------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBz({
  @required BzModel bzModel,
}) async {

    await LDBOps.insertMap(
        docName: LDBDoc.bzz,
        input: bzModel.toMap(toJSON: true),
    );

  }
// -------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<BzModel> readBz(String bzID) async {

    final Map<String, dynamic> _bzMap = await LDBOps.searchFirstMap(
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: bzID,
      docName: LDBDoc.bzz,
    );

    BzModel _bzModel;

    if (_bzMap != null){
      _bzModel = BzModel.decipherBz(
        map: _bzMap,
        fromJSON: true,
      );
    }

    return _bzModel;

  }
// -------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBzOps({
    @required String bzID,
  }) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.bzz,
      objectID: bzID,
    );

  }
// -------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOut(BuildContext context) async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bzz);

  }
// -----------------------------------------------------------------------------

  /// EDITOR SESSION

// ---------------------------------
  ///
  static Future<void> saveEditorSession({
    @required BzModel bzModel,
  }) async {

    if (bzModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.bzEditor,
        input: bzModel.toMap(toJSON: true),
      );

    }

  }
  // ---------------------------------
  ///
  static Future<BzModel> loadEditorSession({
    @required String bzID,
  }) async {
    BzModel _bz;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: <String>[bzID],
      docName: LDBDoc.bzEditor,
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _bz = BzModel.decipherBz(
        map: _maps.first,
        fromJSON: true,
      );

    }

    return _bz;
  }
// ---------------------------------
  ///
  static Future<void> wipeEditorSession(String bzID) async {

    await LDBOps.deleteMap(
      objectID: bzID,
      docName: LDBDoc.bzEditor,
    );

  }
// -----------------------------------------------------------------------------
}
