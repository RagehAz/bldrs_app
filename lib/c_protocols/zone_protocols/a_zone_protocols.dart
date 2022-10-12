import 'package:bldrs/a_models/d_zone/city_model.dart';
import 'package:bldrs/a_models/d_zone/continent_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/h_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/fetch_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/renovate_zones.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/zone_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/zone_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ZoneProtocols {
  // -----------------------------------------------------------------------------

  const ZoneProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// ZONE
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> fetchZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await ZoneFireOps.getAddressFromPosition(geoPoint: geoPoint);

      // blog('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.checkCanLoopList(_marks)){

        final Placemark _mark = _marks[0];

        // blog('mark is : $_mark');

        final String _countryIso = _mark.isoCountryCode;
        final String _countryID = CountryIso.getCountryIDByIso(_countryIso);

        /// try by sub admin area
        final String _subAdministrativeArea = _mark.subAdministrativeArea;
        CityModel _foundCity = await ZoneProtocols.fetchCityByName(
          context: context,
          countryID: _countryID,
          cityName: _subAdministrativeArea,
          langCode: 'en',
        );

        /// try by admin area
        if (_foundCity == null){
          final String _administrativeArea = _mark.administrativeArea;
          _foundCity = await ZoneProtocols.fetchCityByName(
            context: context,
            countryID: _countryID,
            cityName: _administrativeArea,
            langCode: 'en',
          );
        }

        /// try by locality
        if (_foundCity == null){
          final String _locality = _mark.locality;
          _foundCity = await ZoneProtocols.fetchCityByName(
            context: context,
            countryID: _countryID,
            cityName: _locality,
            langCode: 'en',
          );
        }

        _zoneModel = ZoneModel(
          countryID: _countryID,
          cityID: _foundCity?.cityID,
        );

      }

    }

    return _zoneModel;
  }
  // --------------------
  /// COUNTRY
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> fetchCountry({
    @required String countryID,
  }) => FetchZoneProtocols.fetchCountry(
    countryID: countryID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CountryModel>> fetchCountries({
    @required List<String> countriesIDs,
  }) => FetchZoneProtocols.fetchCountries(
      countriesIDs: countriesIDs
  );
  // --------------------
  /// CITY
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCity({
    @required String cityID,
  }) => FetchZoneProtocols.fetchCity(
    cityID: cityID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCities({
    @required List<String> citiesIDs,
    ValueChanged<CityModel> onCityLoaded,
  }) => FetchZoneProtocols.fetchCities(
    citiesIDs: citiesIDs,
    onCityLoaded: onCityLoaded,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCityByName({
    @required BuildContext context,
    @required String cityName,
    @required String langCode,
    String countryID,
  }) => FetchZoneProtocols.fetchCityByName(
    context: context,
    cityName: cityName,
    langCode: langCode,
    countryID: countryID,
  );
  // --------------------
  /// CONTINENT
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> fetchContinents() => FetchZoneProtocols.fetchContinents();
  // --------------------
  /// CURRENCY
  // ---------
  /// TESTED : WORKS PERFECT
  static Future<List<CurrencyModel>> fetchCurrencies() async {

    List<CurrencyModel> _currencies = await ZoneLDBOps.readCurrencies();

    if (Mapper.checkCanLoopList(_currencies) == true){
      // blog('fetchCurrencies : All CurrencyModels FOUND in LDB');
    }

    else {

      _currencies = await ZoneFireOps.readCurrencies();

      if (Mapper.checkCanLoopList(_currencies) == true){
        // blog('fetchCurrencies : All CurrencyModels FOUND in FIREBASE and inserted in LDB');
        await ZoneLDBOps.insertCurrencies(_currencies);
      }

    }

    if (Mapper.checkCanLoopList(_currencies) == false){
      // blog('fetchCurrencies : currencies NOT FOUND');
    }

    return _currencies;

  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> completeZoneModel({
    @required BuildContext context,
    @required ZoneModel incompleteZoneModel,
  }) => RenovateZoneProtocols.completeZoneModel(
    context: context,
    incompleteZoneModel: incompleteZoneModel,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
