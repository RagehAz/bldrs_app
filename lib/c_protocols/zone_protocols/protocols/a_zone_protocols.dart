import 'package:bldrs/c_protocols/zone_protocols/json/continent_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/json/currency_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/c_country_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/d_city_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/e_district_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/x_zone_ids_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/a_countries_levels_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_cities_levels_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_districts_levels_real_ops.dart';

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
  static const fetchZoneModelByGeoPoint = ZoneIDsProtocols.fetchZoneModelByGeoPoint;
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountry = CountryProtocols.fetchCountry;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountries = CountryProtocols.fetchCountries;
  // -----------------------------------------------------------------------------

  /// FETCH CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCity = CityProtocols.fetchCity;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCities = CityProtocols.fetchCities;
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY CITY

  // --------------------
  /// TASK : TEST ME
  static const fetchCitiesOfCountryByLevel = CityProtocols.fetchCitiesOfCountryByLevel;
  // --------------------
  /// TASK : TEST ME
  static const fetchCitiesFromAllOfCountry = CityProtocols.fetchCitiesFromAllOfCountry;
  // --------------------
  /// TASK : TEST ME
  static const fetchCitiesFromSomeOfCountry = CityProtocols.fetchCitiesFromSomeOfCountry;
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICT

  // --------------------
  /// TASK : TEST ME
  static const fetchDistrict = DistrictProtocols.fetchDistrict;
  // --------------------
  /// TASK : TEST ME
  static const fetchDistricts = DistrictProtocols.fetchDistricts;
  // -----------------------------------------------------------------------------

  /// FETCH CITY DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static const fetchCityDistrictsByLevel = DistrictProtocols.fetchCityDistrictsByLevel;
  // --------------------
  /// TASK : TEST ME
  static const fetchDistrictsFromAllOfCity = DistrictProtocols.fetchDistrictsFromAllOfCity;
  // --------------------
  /// TASK : TEST ME
  static const fetchDistrictsFromSomeOfCity = DistrictProtocols.fetchDistrictsFromSomeOfCity;
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static const fetchCountryDistricts = DistrictProtocols.fetchDistrictsFromAllOfCountryOneByOne;
  // -----------------------------------------------------------------------------

  /// READ ZONE LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCountriesLevels = CountriesLevelsRealOps.readCountriesLevels;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCitiesLevels = CitiesLevelsRealOps.readCitiesLevels;
  // --------------------
  /// TASK : TEST ME
  static const readDistrictsLevels = DistrictsLevelsRealOps.readDistrictsLevels;
  // -----------------------------------------------------------------------------

  /// FETCH CONTINENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readAllContinents = ContinentJsonOps.readAllContinents;
  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCurrencies = CurrencyJsonOps.readAllCurrencies;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// RENOVATE ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = ZoneIDsProtocols.completeZoneModel;
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
