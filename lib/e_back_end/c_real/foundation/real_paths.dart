// ignore_for_file: constant_identifier_names

/*
  | => REAL DATA TREE -------------------------|
  |
  | - [agreesOnReviews]
  |     | - {flyerID}
  |     |     | - {reviewID}
  |     |     |     | - {userID} : <bool>
  |     |     |     | - ...
  |     |     |
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [bldrsChains]
  |     | - {phid_k} : <String>
  |     | - ...
  |
  | --------------------------|
  |
  | - [countingBzz]
  |     | - {bzID}
  |     | - ...
  |
  | --------------------------|
  |
  | - [countingFlyers]
  |     | - {flyerID}
  |     | - ...
  |
  | --------------------------|
  |
  | - [feedbacks]
  |     | - {feedbackID}
  |     | - ...
  |
  | --------------------------|
  |
  | - [phrases]
  |     | - {langCode}
  |     | - ...
  |
  | --------------------------|
  |
  | - [pickers]
  |     | - {flyerType}
  |     | - ...
  |
  | --------------------------|
  |
  | - [recordingCalls]
  |     | - {bzID}
  |     |     | - {recordID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [recordingFollows]
  |     | - {bzID}
  |     |     | - {recordID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [recordingSaves]
  |     | - {flyerID}
  |     |     | - {flyerID_userID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [recordingSearches]
  |     | - {userID}
  |     |     | - {recordID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [recordingShares]
  |     | - {flyerID}
  |     |     | - {recordID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - recordingViews
  |     | - {flyerID}
  |     |     | - {flyerID_slideIndex_userID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - statistics
  |     |
  |     | - planet
  |     |     | => [CensusModel]
  |     |
  |     | - countries
  |     |     | - {countryID}
  |     |     |     | => [CensusModel]
  |     |     |
  |     |     | - {countryID}...
  |     |
  |     | - cities
  |     |     | - {cityID}
  |     |     |     | => [CensusModel]
  |     |     |
  |     |     | - {cityID}...
  |     |
  |     | - districts
  |           | - {districtID}
  |           |     | => [CensusModel]
  |           |
  |           | - {districtID}...
  |
  | --------------------------|
  |
  | /// TASK : PROPOSAL TO MIGRATE APP STATE
  | - appState : <AppStateModel>
  |     | - id
  |     | - showOnlyVerifiedFlyersInHomeWall /// TASK : COMBINE APP CONTROLS WITH APP STATE
  |     | - appControlsVersion
  |     | - appVersion
  |     | - chainsVersion
  |     | - ldbVersion
  |     | - phrasesVersion
  |     | - pickersVersion
  |
  | --------------------------|
  |
  | - zones
  |     |
  |     | - stagesCountries
  |     |     | - hidden    : <List<String>> "countriesIDs"
  |     |     | - inactive  : <List<String>> "countriesIDs"
  |     |     | - active    : <List<String>> "countriesIDs"
  |     |     | - public    : <List<String>> "countriesIDs"
  |     |
  |     | - stagesCities
  |     |     | - {countryID}
  |     |     |       | - hidden    : <List<String>> "citiesIDs"
  |     |     |       | - inactive  : <List<String>> "citiesIDs"
  |     |     |       | - active    : <List<String>> "citiesIDs"
  |     |     |       | - public    : <List<String>> "citiesIDs"
  |     |     |
  |     |     | - {countryID}...
  |     |
  |     | - cities
  |           | - {countryID}
  |           |       | - {cityID}
  |           |       |     | - population
  |           |       |     | - position
  |           |       |     | - phrases
  |           |       |     |    | - {langCode} : <String>
  |           |       |     |    | - {langCode}...
  |           |       |     |
  |           |       |     | - districts
  |           |       |          | - {districtID}
  |           |       |          |      | - level
  |           |       |          |      | - phrases : <String>
  |           |       |          |            | - {langCode} : <String>
  |           |       |          |            | - {langCode}...
  |           |       |          |
  |           |       |          | - {districtID}...
  |           |       |
  |           |       |
  |           |       |
  |           |       | - {cityID}...
  |           |
  |           | - {countryID}...
  |
  | --------------------------|
  |
  | - hashGroups
  |     | - designs
  |     |     | - {groupID} : <String>[{hashID}, {hashID}, ...]
  |     |     | - {groupID}...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [hashCensus]
  |     | - {cityID}
  |     |     | - {phid_k}
  |     |     |      | - {uses} : <int>
  |     |     |      | - {searches} : <int>
  |     |     |      | - {views} : <int>
  |     |     | - ...
  |     |
  |     | - ...
  |
  | -------------------------------------------|

 */

import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:flutter/material.dart';

class RealColl {
  // -----------------------------------------------------------------------------

  const RealColl();

  // -----------------------------------------------------------------------------
  /// BZ
  // --------------------
  static const String countingBzz = 'countingBzz';
  static const String recordingFollows = 'recordingFollows';
  static const String recordingCalls = 'recordingCalls';
// ----------------------------------
  /// FLYER
  // --------------------
  static const String countingFlyers = 'countingFlyers';
  static const String recordingShares = 'recordingShares';
  static const String recordingViews = 'recordingViews';
  static const String recordingSaves = 'recordingSaves';
  // static const String recordingReviews = 'recordingReviews';
  static const String reviews = 'reviews';
  static const String agreesOnReviews = 'agreesOnReviews';
  // ----------------------------------
  /// USER
  // --------------------
  static const String recordingSearches = 'recordingSearches';
  // ----------------------------------
  /// QUESTIONS - ANSWERS
  // --------------------
  static const String recordingQuestions = 'recordingQuestions';
  static const String recordingAnswers = 'recordingAnswers';
  // -----------------------------------------------------------------------------
  /// CHAINS
  // --------------------
  static const String citiesPhids = 'citiesPhids';
  static const String bldrsChains = 'bldrsChains';
  // -----------------------------------------------------------------------------
  /// PICKERS
  // --------------------
  static const String pickers = 'pickers';
  // -----------------------------------------------------------------------------
  /// Phrases
  // --------------------
  static const String phrases = 'phrases';
  // -----------------------------------------------------------------------------
  /// Zones
  // --------------------
  static const String zoneCountries = 'zoneCountries';
  // -----------------------------------------------------------------------------
  /// FEED BACK
  // --------------------
  static const String feedbacks = 'feedbacks';
  // -----------------------------------------------------------------------------
  /// NOTES
  // --------------------
  static const String notes = 'notes';
  // -----------------------------------------------------------------------------
  /// STATISTICS
  // --------------------
  static const String statistics = 'statistics';
  // -----------------------------------------------------------------------------
  /// ZONES LEVELS
  // --------------------
  static const String zones = 'zones';
  // -----------------------------------------------------------------------------
  /// APP
  // --------------------
  static const String app = 'app';
}

class RealDoc {
  // -----------------------------------------------------------------------------

  const RealDoc();

  // -----------------------------------------------------------------------------
  /// APP STATE
  // --------------------
  static const String app_globalAppState = 'globalAppState';
  static const String app_appControls = 'appControls';
  static const String app_tests = 'tests';
  // -----------------------------------------------------------------------------
  /// PICKERS
  // --------------------
  static const String pickers_properties = 'properties';
  // -----------------------------------------------------------------------------
  /// STATISTICS
  // --------------------
  static const String statistics_planet = 'planet';
  static const String statistics_countries = 'countries';
  static const String statistics_cities = 'cities';
  static const String statistics_districts = 'districts';
  // -----------------------------------------------------------------------------
  /// ZONES LEVELS
  // --------------------
  static const String zones_stages_countries = 'stages_countries';
  static const String zones_stages_cities = 'stages_cities';
  static const String zones_stages_districts = 'stages_districts';
  static const String zones_cities = 'cities';
  static const String zones_districts = 'districts';
  // -----------------------------------------------------------------------------
  void f(){}
}

class RealPath{
  // -----------------------------------------------------------------------------

  const RealPath();

  // -----------------------------------------------------------------------------

  /// CENSUS / PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static const String getCensusPathOfPlanet = '${RealColl.statistics}/${RealDoc.statistics_planet}';
  // -----------------------------------------------------------------------------

  /// CENSUS / COUNTRIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusesPathOfAllCountries(){
    return '${RealColl.statistics}/${RealDoc.statistics_countries}';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusPathOfCountry({
    @required String countryID,
  }){

    if (countryID == null){
      return null;
    }
    else {
      return '${RealColl.statistics}/${RealDoc.statistics_countries}/$countryID';
    }

  }
  // -----------------------------------------------------------------------------

  /// CENSUS / CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusesPathOfCities({
    @required String countryID,
  }){

    if (countryID == null){
      return null;
    }

    else {
      return '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusPathOfCity({
    @required String cityID,
  }){

    if (cityID == null){
      return null;
    }

    else {
      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      return '${RealColl.statistics}/${RealDoc.statistics_cities}/$_countryID/$cityID';
    }

  }
  // -----------------------------------------------------------------------------

  /// CENSUS / DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusesPathOfDistricts({
    @required String cityID,
  }){

    if (cityID == null){
      return null;
    }

    else {
      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      return '${RealColl.statistics}/${RealDoc.statistics_districts}/$_countryID/$cityID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCensusPathOfDistrict({
    @required String districtID,
  }){

    if (districtID == null){
      return null;
    }

    else {
      final String _countryID = DistrictModel.getCountryIDFromDistrictID(districtID);
      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);
      return '${RealColl.statistics}/${RealDoc.statistics_districts}/$_countryID/$_cityID/$districtID';
    }

  }
  // -----------------------------------------------------------------------------
}
