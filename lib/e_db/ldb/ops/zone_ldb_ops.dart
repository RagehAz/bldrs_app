import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;

class ZoneLDBOps{

  ZoneLDBOps();
  // -----------------------------------------------------------------------------

  /// CONTINENT

  // ---------------------------------
  /// CREATE / INSERT
  // ---------------
  static Future<void> insertContinents(List<Continent> continents) async {

    await LDBOps.insertMap(
      input: Continent.cipherContinents(continents),
      docName: LDBDoc.continents,
    );

  }
  // ---------------------------------
  /// READ
  // ---------------
  static Future<List<Continent>> readContinents() async {

    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.continents,
    );

    List<Continent> _continents = <Continent>[];

    if (Mapper.checkCanLoopList(_maps) == true){
      _continents = Continent.decipherContinents(_maps[0]);
    }

    return _continents;
  }
  // ---------------------------------
  /// UPDATE
  // ---------------
  /// DELETE
  // -----------------------------------------------------------------------------

  /// COUNTRY

  // ---------------------------------
  /// CREATE / INSERT
  // ---------------
  static Future<void> insertCountry(CountryModel country) async {

    await LDBOps.insertMap(
      input: country.toMap(toJSON: true),
      docName: LDBDoc.countries,
    );

  }
  // ---------------------------------
  /// READ
  // ---------------
  static Future<CountryModel> readCountry(String countryID) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.countries,
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: countryID,
    );

    final CountryModel _country  = CountryModel.decipherCountryMap(
      map: _map,
      fromJSON: true,
    );

    return _country;
  }
  // ---------------------------------
  /// UPDATE
  // ---------------
  /// DELETE
  // -----------------------------------------------------------------------------

  /// CITY

  // ---------------------------------
  /// CREATE / INSERT
  // ---------------
  static Future<void> insertCity(CityModel city) async {

    await LDBOps.insertMap(
      input: city.toMap(toJSON: true),
      docName: LDBDoc.cities,
    );

  }
  // ---------------------------------
  /// READ
  // ---------------
  static Future<CityModel> readCity(String cityID) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.cities,
      fieldToSortBy: 'cityID',
      searchField: 'cityID',
      searchValue: cityID,
    );

    final CityModel _city = CityModel.decipherCityMap(
      map: _map,
      fromJSON: true,
    );

    return _city;
  }
  // ---------------
  static Future<List<CityModel>> searchCitiesByName({
    @required String cityName,
    @required String langCode,
  }) async {

    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      lingoCode: langCode,
    );

    final List<CityModel> _foundCities = CityModel.decipherCitiesMaps(
        maps: _foundMaps,
        fromJSON: true,
    );

    return _foundCities;
  }
// ---------------------------------
  /// UPDATE
  // ---------------
  /// DELETE
  // -----------------------------------------------------------------------------

  /// CURRENCIES

  // ---------------------------------
  /// CREATE / INSERT
  // ---------------
  static Future<void> insertCurrencies(List<CurrencyModel> currencies) async {

    await LDBOps.insertMap(
      input: CurrencyModel.cipherCurrencies(currencies),
      docName: LDBDoc.currencies,
    );

  }
  // ---------------------------------
  /// READ
  // ---------------
  static Future<List<CurrencyModel>> readCurrencies() async {

    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.currencies,
    );

    final List<CurrencyModel> _currencies = CurrencyModel.decipherCurrencies(_maps[0]);

    return _currencies;
  }


}
