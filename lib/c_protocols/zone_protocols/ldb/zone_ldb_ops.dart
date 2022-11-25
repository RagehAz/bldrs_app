import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ZoneLDBOps{
  // -----------------------------------------------------------------------------

  const ZoneLDBOps();

  // -----------------------------------------------------------------------------

  /// COUNTRY

  // --------------------
  /// CREATE / INSERT
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCountry(CountryModel country) async {

    await LDBOps.insertMap(
      input: country?.toMap(),
      docName: LDBDoc.countries,
    );

  }
  // --------------------
  /// READ
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> readCountry(String countryID) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.countries,
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: countryID,
    );

    final CountryModel _country  = CountryModel.decipherCountryMap(
      map: _map,
    );

    return _country;
  }
  // --------------------
  /// UPDATE
  // --------------------
  /// DELETE
  // -----------------------------------------------------------------------------

  /// CITY

  // --------------------
  /// CREATE / INSERT
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCity(CityModel city) async {

    await LDBOps.insertMap(
      docName: LDBDoc.cities,
      input: city.toMap(
        toJSON: true,
        toLDB: true,
      ),
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> insertCities(List<CityModel> cities) async {

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
  // --------------------
  /// READ
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> readCity(String cityID) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.cities,
      fieldToSortBy: 'cityID',
      searchField: 'cityID',
      searchValue: cityID,
    );

    final CityModel _city = CityModel.decipherCity(
      map: _map,
      fromJSON: true,
      cityID: cityID,
    );

    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> searchCitiesByName({
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
  // --------------------
  /// UPDATE
  // --------------------
  /// DELETE
  // -----------------------------------------------------------------------------

}
