import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class StagingLDBOps {
  // -----------------------------------------------------------------------------

  const StagingLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / UPDATE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> insertStaging({
    @required Staging staging,
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      input: staging?.toMap(
        toLDB: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<Staging> readStaging({
    @required String id,
  }) async {
    Staging _output;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      ids: <String>[id],
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _output = Staging.decipher(
        id: id,
        map: _maps.first,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> deleteStaging({
    @required String id,
  }) async {

    await LDBOps.deleteMaps(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      ids: <String>[id],
    );

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> deleteStagings({
    @required List<String> ids,
  }) async {

    if (Mapper.checkCanLoopList(ids) == true){

      await  LDBOps.deleteMaps(
        docName: LDBDoc.staging,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
        ids: ids,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
