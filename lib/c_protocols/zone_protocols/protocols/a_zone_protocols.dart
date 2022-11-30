import 'package:bldrs/c_protocols/zone_protocols/json/continent_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/json/currency_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/c_country_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/d_city_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/e_district_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/x_zone_ids_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_districts_stages_real_ops.dart';

class ZoneProtocols {
  // -----------------------------------------------------------------------------

  const ZoneProtocols();

  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeCity = CityProtocols.composeCity;
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
  static const refetchCountry = CountryProtocols.refetchCountry;
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
  /// TESTED : WORKS PERFECT
  static const fetchCitiesOfCountry = CityProtocols.fetchCitiesOfCountry;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCitiesOfCountryByIDs = CityProtocols.fetchCitiesOfCountryByIDs;
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchDistrict = DistrictProtocols.fetchDistrict;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchDistricts = DistrictProtocols.fetchDistricts;
  // -----------------------------------------------------------------------------

  /// FETCH CITY DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCity = DistrictProtocols.fetchDistrictsOfCity;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCityByIDs = DistrictProtocols.fetchDistrictsOfCityByIDs;
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCountry = DistrictProtocols.fetchDistrictsOfCountry;
  // -----------------------------------------------------------------------------

  /// READ ZONE STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCountriesStages = CountriesStagesRealOps.readCountriesStages;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCitiesStages = CitiesStagesRealOps.readCitiesStages;
  // --------------------
  /// TASK : TEST ME
  static const readDistrictsStages = DistrictsStagesRealOps.readDistrictsStages;
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovateCity = CityProtocols.renovateCity;
  // -----------------------------------------------------------------------------

  /// UPDATE STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateCountryStage = CountriesStagesRealOps.updateCountryStage;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateCityStage = CitiesStagesRealOps.updateCityStage;
  // --------------------
  /// TASK : TEST ME
  // static const updateDistrictStage = DistrictsStagesRealOps.updateDistrictStage;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// WIPE ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const wipeCity = CityProtocols.wipeCity;
  // --------------------
  /// TESTED : WORKS PERFECT
  // static const wipeDistrict = DistrictProtocols.wipeDistrict;
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
