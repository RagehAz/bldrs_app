import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictLDBOps {
  // -----------------------------------------------------------------------------

  const DistrictLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / INSERT / UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertDistrict({
    @required DistrictModel districtModel,
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.districts,
      input: districtModel?.toMap(
        toJSON: true,
        toLDB: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertDistricts({
    @required List<DistrictModel> districts,
  }) async {

    if (Mapper.checkCanLoopList(districts) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.districts,
        inputs: DistrictModel.cipherDistrictsMaps(
          districts: districts,
          toLDB: true,
          toJSON: true,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DistrictModel> readDistrict({
    @required String districtID,
  }) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.districts,
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: districtID,
    );

    final DistrictModel _district = DistrictModel.decipherDistrict(
      map: _map,
      districtID: districtID,
    );

    return _district;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> readDistricts({
    @required List<String> districtsIDs,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.districts,
        ids: districtsIDs,
      );

      _output = DistrictModel.decipherDistrictsMaps(_maps);

    }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> searchCitiesByName({
    @required String cityName,
    @required String langCode,
  }) async {

    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      lingoCode: langCode,
    );

    final List<CityModel> _foundCities = CityModel.decipherCities(
      maps: _foundMaps,

      fromJSON: true,
    );

    return _foundCities;
  }
   */
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDistrict({
    @required String districtID,
  }) async {

    await LDBOps.deleteMap(
      objectID: districtID,
      docName: LDBDoc.districts,
    );

  }
// -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
