import 'package:bldrs/c_protocols/zone_protocols/json/zone_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/fetch_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/renovate_zones.dart';

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
  /// TASK : TEST ME
  static const fetchZoneModelByGeoPoint = FetchZoneProtocols.fetchZoneModelByGeoPoint;
  // --------------------
  /// COUNTRY
  // ---------
  /// TESTED : WORKS PERFECT
  static const  fetchCountry = FetchZoneProtocols.fetchCountry;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountries = FetchZoneProtocols.fetchCountries;
  // --------------------
  /// CITY
  // ---------
  /// TESTED : WORKS PERFECT
  static const fetchCity = FetchZoneProtocols.fetchCity;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCities = FetchZoneProtocols.fetchCities;
  // --------------------
  /// TASK : TEST ME
  static const fetchCitiesByCountryID = FetchZoneProtocols.fetchCitiesByCountryID;
  // --------------------
  /// TASK : TEST ME
  static const fetchCityByName = FetchZoneProtocols.fetchCityByName;
  // --------------------
  /// CONTINENT
  // ---------
  /// TESTED : WORKS PERFECT
  static const fetchContinents = FetchZoneProtocols.fetchContinents;
  // --------------------
  /// CURRENCY
  // ---------
  /// TESTED : WORKS PERFECT
  static const fetchCurrencies = ZoneJSONOps.readAllCurrencies;
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = RenovateZoneProtocols.completeZoneModel;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
