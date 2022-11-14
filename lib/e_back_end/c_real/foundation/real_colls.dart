// ignore_for_file: constant_identifier_names

/*
  | => REAL DATA TREE -------------------------|
  |
  | X => OLD : NOT YET ADJUSTED
  | - [agreesOnReviews]
  |     | - {reviewID} ...
  |     |     | - {userID}
  |     |     | - ...
  |     |
  |     | - ...
  |
  | O => SHOULD BE
  | - [agreesOnReviews]
  |     | - {flyerID} ...
  |     |     | - {reviewID} ...
  |     |     |     | - {userID}
  |     |     |     | - ...
  |     |     |
  |     |     | - ...
  |     |
  |     | - ...
  |
  | --------------------------|
  |
  | - [bldrsChains]
  |
  | --------------------------|
  |
  | - [chainsUsage]
  |     | - {cityID}
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
  | - [recordingViews]
  |     | - {flyerID}
  |     |     | - {flyerID_slideIndex_userID}
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
}
