// ignore_for_file: non_constant_identifier_names
import 'dart:async';

import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/a_models/d_zone/zz_old/country_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/zone_real_ops.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ZoneFireOps {
  // -----------------------------------------------------------------------------

  const ZoneFireOps();

  // -----------------------------------------------------------------------------

  /// CONTINENT

  // --------------------
  /// DEPRECATED
  /*
  static Future<List<Continent>> readContinentsOpsX() async {
    final Map<String, dynamic> _map = await Fire.readDoc(
      collName: FireColl.zones,
      docName: FireDoc.zones_continents,
    );

    final List<Continent> _allContinents = Continent.decipherContinents(_map);

    return _allContinents;
  }
   */
  // -----------------------------------------------------------------------------

  /// COUNTRY

  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> readCountryOps({
    @required String countryID,
  }) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      subDocName: countryID,
    );

    final CountryModel _countryModel = CountryModel.decipherCountryMap(
      map: _map,
    );

    return _countryModel;
  }
   */
  // -----------------------------------------------------------------------------

  /// CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> readCityOps({
    @required String cityID,
  }) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      collName: FireColl.zones,
      docName: FireDoc.zones_cities,
      subCollName: FireSubColl.zones_cities_cities,
      subDocName: cityID,
    );

    final CityModel _cityModel = CityModel.decipherCityMap(
      map: _map,
      fromJSON: false,
    );

    return _cityModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<CityModel>> readCountryCitiesOps({
    @required String countryID,
  }) async {
    final List<CityModel> _cities = <CityModel>[];

    final CountryModel _country = await ZoneRealOps.readCountry(
      countryID: countryID,
    );

    if (_country != null) {

      final List<String> _citiesIDs = _country.citiesIDs.getAllIDs();

      if (Mapper.checkCanLoopList(_citiesIDs)) {
        for (final String id in _citiesIDs) {

          final CityModel _city = await readCityOps(
            cityID: id,
          );

          if (_city != null) {
            _cities.add(_city);
          }
        }
      }
    }

    return _cities;
  }
  // -----------------------------------------------------------------------------

  /// CURRENCY

  // --------------------
  /// DEPRECATED
  /*
  static Future<List<CurrencyModel>> readCurrencies() async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      collName: FireColl.zones,
      docName: FireDoc.zones_currencies,
    );

    final List<CurrencyModel> _currencies = CurrencyModel.decipherCurrencies(_map);

    return _currencies;
  }
   */
  // -----------------------------------------------------------------------------
}
