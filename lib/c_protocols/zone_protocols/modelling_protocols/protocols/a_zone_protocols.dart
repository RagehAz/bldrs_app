import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/ip/zone_ip_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/continent_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/currency_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/c_country_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/d_city_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/x_zone_ids_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/translator/zone_translator.dart';
/// => TAMAM
class ZoneProtocols {
  // -----------------------------------------------------------------------------

  const ZoneProtocols();

  // -----------------------------------------------------------------------------

  /// ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeZoneModel = ZoneIDsProtocols.completeZoneModel;
  /// TESTED : WORKS PERFECT
  static const getZoneByIP = ZoneIPOps.getZoneByIP;
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

  /// CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const readAllContinents = ContinentJsonOps.readAllContinents;
  // -----------------------------------------------------------------------------

  /// CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchCurrencies = CurrencyJsonOps.readAllCurrencies;
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
  static const searchCountriesByISO2FromAllFlags = ZoneSearchOps.searchCountriesByISO2FromAllFlags;
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

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const translateCountry = ZoneTranslator.translateCountry;
  /// TESTED : WORKS PERFECT
  static const translateCity = ZoneTranslator.translateCity;
  // -----------------------------------------------------------------------------
}
