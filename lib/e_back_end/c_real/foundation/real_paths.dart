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
  |           | - {cityID}
  |           |     | => [CensusModel]
  |           |
  |           | - {cityID}...
  |
  |
  | --------------------------|
  |
  | /// TASK : PROPOSAL TO MIGRATE APP STATE
  | - appState : <AppStateModel>
  |     | - appVersion
  |     | - ldbVersion
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
  |           |       |          | - {langCode} : <String>
  |           |       |          | - {langCode}...
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
  // -----------------------------------------------------------------------------
  /// CHAINS
  // --------------------
  static const String zonesPhids = 'zonesPhids';
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

  static const String searches = 'searches';
}

class RealDoc {
  // -----------------------------------------------------------------------------

  const RealDoc();

  // -----------------------------------------------------------------------------
  /// APP STATE
  // --------------------
  static const String app_appState = 'appState';
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
  // -----------------------------------------------------------------------------
  /// ZONES LEVELS
  // --------------------
  static const String zones_stages_countries = 'stages_countries';
  static const String zones_stages_cities = 'stages_cities';
  static const String zones_cities = 'cities';
  // -----------------------------------------------------------------------------
}
