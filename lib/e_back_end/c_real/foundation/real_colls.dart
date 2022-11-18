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
  | /// TASK : PROPOSAL FOR STATISTICS : which will be used to filter which countries are
  | - statistics
  |     | - activeCountriesIDs                  : <List<String>>
  |     | - globalCountriesIDs                  : <List<String>>
  |     | - planet
  |     |     | - totalUsers                    : <int>
  |     |     | - totalBzz                      : <int>
  |     |     | - totalFlyers                   : <int>
  |     |     | - totalSlides                   : <int>
  |     |     | - bzSectionRealEstate           : <int>
  |     |     | - bzSectionConstruction         : <int>
  |     |     | - bzSectionSupplies             : <int>
  |     |     | - bzTypeDeveloper               : <int>
  |     |     | - bzTypeBroker                  : <int>
  |     |     | - bzTypeDesigner                : <int>
  |     |     | - bzTypeContractor              : <int>
  |     |     | - bzTypeArtisan                 : <int>
  |     |     | - bzTypeManufacturer            : <int>
  |     |     | - bzTypeSupplier                : <int>
  |     |     | - bzFormIndividual              : <int>
  |     |     | - bzFormCompany                 : <int>
  |     |     | - bzAccountTypeStandard         : <int>
  |     |     | - bzAccountTypePro              : <int>
  |     |     | - bzAccountTypeMaster           : <int>
  |     |     | - flyerTypeProperty             : <int>
  |     |     | - flyerTypeDesign               : <int>
  |     |     | - flyerTypeProject              : <int>
  |     |     | - flyerTypeProduct              : <int>
  |     |     | - flyerTypeTrade                : <int>
  |     |     | - flyerTypeEquipment            : <int>
  |     |     | - needTypeSeekProperty          : <int>
  |     |     | - needTypePlanConstruction      : <int>
  |     |     | - needTypeFinishConstruction    : <int>
  |     |     | - needTypeFurnish               : <int>
  |     |     | - needTypeOfferProperty         : <int>
  |     |
  |     | - countries
  |     |     | - {countryID}
  |     |     |     | => [zoneState]
  |     |     |
  |     |     | - {countryID}...
  |     |
  |     | - cities
  |     |     | - {cityID}
  |     |     |     | => [zoneState]
  |     |     |
  |     |     | - {cityID}...
  |     |
  |     | - districts
  |           | - {districtID}
  |           |     | => [zoneState]
  |           |
  |           | - {districtID}...
  |
  | --------------------------|
  |
  | /// TASK : PROPOSAL TO MIGRATE FIRE ZONE COLL TO THIS TREE
  | - zones
  |     | - {countryID}
  |     |     | - id          : <String>
  |     |     | - region      : <String>
  |     |     | - continent   : <String>
  |     |     | - isActivated : <bool>
  |     |     | - isGlobal    : <bool>
  |     |     | - citiesIDs   : List<String>
  |     |     | - language    : <String>
  |     |     | - currency    : <String>
  |     |     | - phrases
  |     |     |     | - {langCode}
  |     |     |     |     | - langCode : <String>
  |     |     |     |     | - value    : <String>
  |     |     |     |
  |     |     |     | - {langCode}...
  |     |     |
  |     |     | - iso2        : <String>
  |     |     | - phoneCode   : <String>
  |     |     | - capital     : <String>
  |     |     | - cities
  |     |          | - {cityID}
  |     |          |     | - countryID   : <String>
  |     |          |     | - cityID      : <String>
  |     |          |     | - districts   : <List<DistrictModel>>
  |     |          |     | - population  : <int>
  |     |          |     | - isActivated : <bool>
  |     |          |     | - isPublic    : <bool>
  |     |          |     | - position    : <String>
  |     |          |     | - state       : <String>
  |     |          |     | - phrases
  |     |          |          | - {langCode}
  |     |          |          |     | - langCode : <String>
  |     |          |          |     | - value    : <String>
  |     |          |          |
  |     |          |          | - {langCode}...
  |     |          |
  |     |          |
  |     |          | - {cityID}...
  |     |
  |     |
  |     | - {countryID}...
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
