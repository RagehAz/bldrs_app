import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CityLDBOps{
  // -----------------------------------------------------------------------------

  const CityLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / INSERT / UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCity({
    @required CityModel city,
  }) async {

    await LDBOps.insertMap(
      // allowDuplicateIDs: false, DEFAULT
      docName: LDBDoc.cities,
      input: city?.toMap(
        toJSON: true,
        toLDB: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCities({
    @required List<CityModel> cities,
  }) async {

    if (Mapper.checkCanLoopList(cities) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.cities,
        inputs: CityModel.cipherCities(
          cities: cities,
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
  static Future<CityModel> readCity({
    @required String cityID,
  }) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.cities,
      sortFieldName: 'cityID',
      searchFieldName: 'cityID',
      searchValue: cityID,
    );

    final CityModel _city = CityModel.decipherCity(
      map: _map,
      fromJSON: true,
      cityID: cityID,
      fromLDB: true,
    );

    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> readCities({
    @required List<String> citiesIDs,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDs) == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.cities,
        ids: citiesIDs,
      );

      _output = CityModel.decipherCities(
        maps: _maps,
        fromJSON: true,
        fromLDB: true,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCity({
    @required String cityID,
  }) async {

    await LDBOps.deleteMap(
        objectID: cityID,
        docName: LDBDoc.cities,
    );

  }
  // -----------------------------------------------------------------------------
}