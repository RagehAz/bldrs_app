

import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class CensusLDBOps {
  // -----------------------------------------------------------------------------

  CensusLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT / CREATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> insertCensus({
    @required CensusModel census,
  }) async {

    if (census != null){

      await LDBOps.insertMap(
          docName: LDBDoc.census,
          input: census.toMap(toLDB: true),
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
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
        inputs: _maps,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<CensusModel> readCensus({
    @required String id,
  }) async {
    CensusModel _output;

    if (id != null){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
          docName: LDBDoc.census,
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
  /// TASK : TEST ME
  static Future<void> deleteCensus({
    @required String id,
  }) async {

    if (id != null){

      await LDBOps.deleteMap(
          docName: LDBDoc.census,
          objectID: id,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
