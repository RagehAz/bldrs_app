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
  | - [chainsUsage] TASK : should rename this "citiesPhids"
  |     | - {cityID}
  |     |     | - {phid_k} : <int>
  |     |     | - ...
  |     |
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
  |     | - countriesLevels
  |     |     | - hidden    : <List<String>> "countriesIDs"
  |     |     | - inactive  : <List<String>> "countriesIDs"
  |     |     | - active    : <List<String>> "countriesIDs"
  |     |     | - public    : <List<String>> "countriesIDs"
  |     |
  |     | - citiesLevels
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
// ----------------------------------
  /// QUESTIONS - ANSWERS
  // --------------------
  static const String recordingQuestions = 'recordingQuestions';
  static const String recordingAnswers = 'recordingAnswers';
  // -----------------------------------------------------------------------------
  /// CHAINS
  // --------------------
  static const String chainsUsage = 'chainsUsage';
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

  static const String statistics = 'statistics';
  // -----------------------------------------------------------------------------
}

class RealDoc {
  // -----------------------------------------------------------------------------

  const RealDoc();

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
}
