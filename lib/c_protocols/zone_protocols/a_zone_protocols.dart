import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/fetch_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/renovate_zones.dart';
import 'package:flutter/material.dart';

class ZoneProtocols {
// -----------------------------------------------------------------------------

  const ZoneProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// ----------------------------------

// -----------------------------------------------------------------------------

  /// FETCH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> fetchCountry({
    @required BuildContext context,
    @required String countryID,
  }) => FetchZoneProtocols.fetchCountry(
    context: context,
    countryID: countryID,
  );
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CountryModel>> fetchCountries({
    @required BuildContext context,
    @required List<String> countriesIDs,
  }) => FetchZoneProtocols.fetchCountries(
      context: context,
      countriesIDs: countriesIDs
  );
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCity({
    @required BuildContext context,
    @required String cityID,
  }) => FetchZoneProtocols.fetchCity(
    context: context,
    cityID: cityID,
  );
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCities({
    @required BuildContext context,
    @required List<String> citiesIDs,
    ValueChanged<CityModel> onCityLoaded,
  }) => FetchZoneProtocols.fetchCities(
    context: context,
    citiesIDs: citiesIDs,
    onCityLoaded: onCityLoaded,
  );
// ----------------------------------
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
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> fetchContinents({
    @required BuildContext context,
  }) => FetchZoneProtocols.fetchContinents(
    context: context,
  );
// -----------------------------------------------------------------------------

  /// RENOVATE

// ----------------------------------
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

// ----------------------------------

// -----------------------------------------------------------------------------
}
