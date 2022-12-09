import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/ip/zone_ip_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/continent_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/currency_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/c_country_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/d_city_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/e_district_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/x_zone_ids_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_districts_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/translator/zone_translato.dart';
/// => TAMAM
class ZoneProtocols {
  // -----------------------------------------------------------------------------

  const ZoneProtocols();

  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchZoneModelByGeoPoint = ZoneIDsProtocols.fetchZoneModelByGeoPoint;
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = ZoneIDsProtocols.completeZoneModel;
  /// TESTED : WORKS PERFECT
  static const getZoneByIP = ZoneIPOps.getZoneByIP;
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
  // -----------------------------------------------------------------------------

  /// COUNTRY STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCountriesStaging = CountriesStagesRealOps.readCountriesStaging;
  /// TESTED : WORKS PERFECT
  static const updateCountryStageType = CountriesStagesRealOps.updateCountryStageType;
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
  static const fetchCityByName = ZoneSearchOps.searchFetchCityByName;
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
  // -----------------------------------------------------------------------------

  /// CITY STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readCitiesStaging = CitiesStagesRealOps.readCitiesStaging;
  /// TESTED : WORKS PERFECT
  static const updateCityStageType = CitiesStagesRealOps.updateCityStageType;
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
  // -----------------------------------------------------------------------------

  /// DISTRICTS STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readDistrictsStaging = DistrictsStagesRealOps.readDistrictsStaging;
  /// TESTED : WORKS PERFECT
  static const updateDistrictStageType = DistrictsStagesRealOps.updateDistrictStageType;
  /// TESTED : WORKS PERFECT
  static const resetDistrictsStaging = DistrictsStagesRealOps.resetDistrictsStaging;
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

  /// COSMIC COUNTRIES

  // --------------------
  static const searchTheCosmos = ZoneSearchOps.searchTheCosmos;
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
  /// TESTED : WORKS PERFECT
  static const searchDistrictsOfPlanetByIDFromFire = ZoneSearchOps.searchDistrictsOfPlanetByIDFromFire;
  /// TESTED : WORKS PERFECT
  static const searchDistrictOfPlanetByNameFromFire = ZoneSearchOps.searchDistrictOfPlanetByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH DISTRICTS OF COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const searchDistrictsOfCountryByIDFromFire = ZoneSearchOps.searchDistrictsOfCountryByIDFromFire;
  /// TESTED : WORKS PERFECT
  static const searchDistrictsOfCountryByNameFromFire = ZoneSearchOps.searchDistrictsOfCountryByNameFromFire;
  // -----------------------------------------------------------------------------

  /// SEARCH DISTRICTS OF CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static const searchDistrictsOfCityByIDFromFire = ZoneSearchOps.searchDistrictsOfCityByIDFromFire;
  /// TESTED : WORKS PERFECT
  static const searchDistrictsOfCityByNameFromFire = ZoneSearchOps.searchDistrictsOfCityByNameFromFire;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const translateCountry = ZoneTranslator.translateCountry;
  /// TESTED : WORKS PERFECT
  static const translateCity = ZoneTranslator.translateCity;
  /// TESTED : WORKS PERFECT
  static const translateDistrict = ZoneTranslator.translateDistrict;
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------
}
