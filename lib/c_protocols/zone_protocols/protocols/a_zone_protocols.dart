import 'package:bldrs/c_protocols/zone_protocols/json/zone_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/fetch_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/renovate_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/searchg_zones.dart';

class ZoneProtocols {
  // -----------------------------------------------------------------------------

  const ZoneProtocols();

  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// FETCH ZONE

  // --------------------
  /// TASK : TEST ME
  static const fetchZoneModelByGeoPoint = FetchZoneProtocols.fetchZoneModelByGeoPoint;
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountry = FetchZoneProtocols.fetchCountry;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountries = FetchZoneProtocols.fetchCountries;
  // -----------------------------------------------------------------------------

  /// FETCH CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCity = FetchZoneProtocols.fetchCity;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCities = FetchZoneProtocols.fetchCities;
  // --------------------
  /// TASK : TEST ME
  static const fetchCitiesByCountryID = FetchZoneProtocols.fetchCitiesByCountryID;
  // -----------------------------------------------------------------------------

  /// FETCH CONTINENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchContinents = FetchZoneProtocols.fetchContinents;
  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCurrencies = ZoneJSONOps.readAllCurrencies;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// RENOVATE ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = RenovateZoneProtocols.completeZoneModel;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// WIPE ZONE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// SEARCH PLANET COUNTRIES

  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetCountriesByID = ZoneSearchOps.searchPlanetCountriesByID;
  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetCountriesByName = ZoneSearchOps.searchPlanetCountriesByName;
  // -----------------------------------------------------------------------------

  /// SEARCH PLANET CITIES

  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetCitiesByID = ZoneSearchOps.searchPlanetCitiesByID;
  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetCitiesByName = ZoneSearchOps.searchPlanetCitiesByName;
  // -----------------------------------------------------------------------------

  /// SEARCH COUNTRY CITIES

  // --------------------
  /// TASK : WRITE ME
  static const searchCountryCitiesByID = ZoneSearchOps.searchCountryCitiesByID;
  // --------------------
  /// TASK : WRITE ME
  static const searchCountryCitiesByName = ZoneSearchOps.searchCountryCitiesByName;
  // -----------------------------------------------------------------------------

  /// SEARCH PLANET DISTRICTS

  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetDistrictsByID = ZoneSearchOps.searchPlanetDistrictsByID;
  // --------------------
  /// TASK : WRITE ME
  static const searchPlanetDistrictsByName = ZoneSearchOps.searchPlanetDistrictsByName;
  // -----------------------------------------------------------------------------

  /// SEARCH CITY DISTRICTS

  // --------------------
  /// TASK : WRITE ME
  static const searchCityDistrictsByID = ZoneSearchOps.searchCityDistrictsByID;
  // --------------------
  /// TASK : WRITE ME
  static const searchCityDistrictsByName = ZoneSearchOps.searchCityDistrictsByName;
  // -----------------------------------------------------------------------------
  /// TASK : TEST ME : DO WE NEED THIS ??
  static const fetchCityByName = ZoneSearchOps.fetchCityByName;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------
}
