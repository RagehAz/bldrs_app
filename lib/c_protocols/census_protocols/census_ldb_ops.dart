import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CensusLDBOps {
  // -----------------------------------------------------------------------------

  CensusLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT / CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCensus({
    @required CensusModel census,
  }) async {

    if (census != null){

      await LDBOps.insertMap(
          docName: LDBDoc.census,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
          input: census.toMap(toLDB: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCensuses({
    @required List<CensusModel> censuses,
  }) async {

    if (Mapper.checkCanLoopList(censuses) == true){

      final List<Map<String, dynamic>> _maps = CensusModel.cipherCensuses(
        censuses: censuses,
        toLDB: true,
      );

      await LDBOps.insertMaps(
        docName: LDBDoc.census,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
        inputs: _maps,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel> readCensus({
    @required String id,
  }) async {
    CensusModel _output;

    if (id != null){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.census,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
        ids: <String>[id],
      );

      if (Mapper.checkCanLoopList(_maps) == true){

        _output = CensusModel.decipher(
            map: _maps.first,
            id: id
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCensus({
    @required String id,
  }) async {

    if (id != null){

      await LDBOps.deleteMap(
        docName: LDBDoc.census,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
        objectID: id,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeAllCensuses() async {
    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.census);
  }
  // -----------------------------------------------------------------------------
}
