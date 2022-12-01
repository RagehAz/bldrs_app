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

  /// ZONE

  // --------------------
  /// TASK : TEST ME
  static const fetchZoneModelByGeoPoint = ZoneIDsProtocols.fetchZoneModelByGeoPoint;
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = ZoneIDsProtocols.completeZoneModel;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const  fetchCountry = CountryProtocols.fetchCountry;
  /// TESTED : WORKS PERFECT
  static const refetchCountry = CountryProtocols.refetchCountry;
  /// TESTED : WORKS PERFECT
  static const  fetchCountries = CountryProtocols.fetchCountries;
  // STAGES
  /// TESTED : WORKS PERFECT
  static const readCountriesStages = CountriesStagesRealOps.readCountriesStages;
  /// TESTED : WORKS PERFECT
  static const updateCountryStage = CountriesStagesRealOps.updateCountryStage;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeCity = CityProtocols.composeCity;
  /// TESTED : WORKS PERFECT
  static const fetchCity = CityProtocols.fetchCity;
  /// TESTED : WORKS PERFECT
  static const fetchCities = CityProtocols.fetchCities;
  /// TESTED : WORKS PERFECT
  static const fetchCitiesOfCountry = CityProtocols.fetchCitiesOfCountry;
  /// TESTED : WORKS PERFECT
  static const fetchCitiesOfCountryByIDs = CityProtocols.fetchCitiesOfCountryByIDs;
  /// TESTED : WORKS PERFECT
  static const renovateCity = CityProtocols.renovateCity;
  /// TESTED : WORKS PERFECT
  static const wipeCity = CityProtocols.wipeCity;
  // STAGES
  /// TESTED : WORKS PERFECT
  static const readCitiesStages = CitiesStagesRealOps.readCitiesStages;
  /// TESTED : WORKS PERFECT
  static const updateCityStage = CitiesStagesRealOps.updateCityStage;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeDistrict = DistrictProtocols.composeDistrict;
  /// TESTED : WORKS PERFECT
  static const fetchDistrict = DistrictProtocols.fetchDistrict;
  /// TESTED : WORKS PERFECT
  static const fetchDistricts = DistrictProtocols.fetchDistricts;
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCity = DistrictProtocols.fetchDistrictsOfCity;
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCityByIDs = DistrictProtocols.fetchDistrictsOfCityByIDs;
  /// TESTED : WORKS PERFECT
  static const fetchDistrictsOfCountry = DistrictProtocols.fetchDistrictsOfCountry;
  /// TESTED : WORKS PERFECT
  static const renovateDistrict = DistrictProtocols.renovateDistrict;
  /// TESTED : WORKS PERFECT
  static const wipeDistrict = DistrictProtocols.wipeDistrict;
  // STAGES
  /// TESTED : WORKS PERFECT
  static const readDistrictsStages = DistrictsStagesRealOps.readDistrictsStages;
  /// TESTED : WORKS PERFECT
  static const updateDistrictStage = DistrictsStagesRealOps.updateDistrictStage;
  /// TESTED : WORKS PERFECT
  static const resetDistrictsStages = DistrictsStagesRealOps.resetDistrictsStages;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readAllContinents = ContinentJsonOps.readAllContinents;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCurrencies = CurrencyJsonOps.readAllCurrencies;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// SEARCH COUNTRIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const searchCountriesByIDFromAllFlags = ZoneSearchOps.searchCountriesByIDFromAllFlags;
  /// TESTED : WORKS PERFECT
  static const searchCountriesByNameFromLDBFlags = ZoneSearchOps.searchCountriesByNameFromLDBFlags;
  // -----------------------------------------------------------------------------

  /// SEARCH CITIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static const searchCitiesOfPlanetByIDFromFire = ZoneSearchOps.searchCitiesOfPlanetByIDFromFire;
  /// TESTED : WORKS PERFECT
  static const searchCitiesOfPlanetByNameFromFire = ZoneSearchOps.searchCitiesOfPlanetByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH CITIES OF COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const searchCountryCitiesByIDFromFire = ZoneSearchOps.searchCitiesOfCountryByIDFromFire;
  /// TESTED : WORKS PERFECT
  static const searchCountryCitiesByNameFromFire = ZoneSearchOps.searchCitiesOfCountryByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH DISTRICTS OF PLANET

  // --------------------
  /// TASK : WRITE ME
  static const searchDistrictsOfPlanetByIDFromFire = ZoneSearchOps.searchDistrictsOfPlanetByIDFromFire;
  /// TASK : WRITE ME
  static const searchDistrictOfPlanetByNameFromFire = ZoneSearchOps.searchDistrictOfPlanetByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH DISTRICTS OF COUNTRY

  // --------------------
  /// TASK : WRITE ME
  static const searchDistrictsOfCountryByIDFromFire = ZoneSearchOps.searchDistrictsOfCountryByIDFromFire;
  /// TASK : WRITE ME
  static const searchDistrictsOfCountryByNameFromFire = ZoneSearchOps.searchDistrictsOfCountryByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH DISTRICTS OF CITY

  // --------------------
  /// TASK : WRITE ME
  static const searchDistrictsOfCityByIDFromFire = ZoneSearchOps.searchDistrictsOfCityByIDFromFire;
  /// TASK : WRITE ME
  static const searchDistrictsOfCityByNameFromFire = ZoneSearchOps.searchDistrictsOfCityByNameFromFire;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------
  /// TASK : TEST ME : DO WE NEED THIS ??
  static const fetchCityByName = ZoneSearchOps.fetchCityByName;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------
}
