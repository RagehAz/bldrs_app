// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/g_statistics/records/user_record_model.dart';

/// => TAMAM
class RealColl {
  // -----------------------------------------------------------------------------

  const RealColl();

  // -----------------------------------------------------------------------------
  static const String agrees = 'agrees';
  // --------------------
  static const String app = 'app';
  static const String camps = 'camps';
  // --------------------
  static const String bldrsChains = 'bldrsChains'; /// ERADICATE_CHAINS
  static const String keywords = 'keywords';
  static const String keywordsPhrases = 'keywordsPhrases';
  // --------------------
  static const String records = 'records';
  // --------------------
  static const String feedbacks = 'feedbacks';
  // --------------------
  static const String pickers = 'pickers';
  // --------------------
  static const String searches = 'searches';
  // --------------------
  static const String statistics = 'statistics';
  // --------------------
  static const String zones = 'zones';
  // --------------------
  static const String zonesPhids = 'zonesPhids';
  // --------------------
  static const String deletionRequests = 'deletionRequests';
  // --------------------
  static const String gta = 'gta';
  // --------------------
}

/// => TAMAM
class RealDoc {
  // -----------------------------------------------------------------------------

  const RealDoc();

  // -----------------------------------------------------------------------------
  /// APP STATE
  // --------------------
  static const String app_tests = 'tests';
  static const String app_history = 'history';
  static const String app_noteCampaigns = 'noteCampaigns';
  static const String app_emailingLists = 'emailingLists';
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
  /// RECORDS
  // --------------------
  static const String records_users = 'users';
  static const String records_users_userID_counter = 'counter';
  static const String records_users_userID_records = 'records';
  // --------------------
  static const String records_bzz = 'bzz';
  static const String records_bzz_bzID_counter = 'counter';
  static const String records_bzz_bzID_recordingCalls = 'recordingCalls';
  static const String records_bzz_bzID_recordingFollows = 'recordingFollows';
  // --------------------
  static const String records_flyers = 'flyers';
  static const String records_flyers_bzID_flyerID_counter = 'counter';
  static const String records_flyers_bzID_flyerID_recordingSaves = 'recordingSaves';
  static const String records_flyers_bzID_flyerID_recordingShares = 'recordingShares';
  static const String records_flyers_bzID_flyerID_recordingViews = 'recordingViews';
  // -----------------------------------------------------------------------------
  /// GTA
  // --------------------
  static const String gta_selected = 'selected';
  static const String gta_scrapped = 'scrapped';
  static const String gta_version = 'version';
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class RealPath {
  // -----------------------------------------------------------------------------

  const RealPath();

  // -----------------------------------------------------------------------------

  /// agreesOnReviews

  // --------------------
  static String agrees_bzID({
    required String bzID,
  }) => '${RealColl.agrees}/$bzID';
  // --------------------
  static String agrees_bzID_flyerID({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.agrees}/$bzID/$flyerID';
  // --------------------
  static String agrees_bzID_flyerID_reviewID({
    required String bzID,
    required String flyerID,
    required String reviewID,
  }) => '${RealColl.agrees}/$bzID/$flyerID/$reviewID';
  // --------------------
  static String agrees_bzID_flyerID_reviewID_userID({
    required String bzID,
    required String flyerID,
    required String reviewID,
    required String userID,
  }) => '${RealColl.agrees}/$bzID/$flyerID/$reviewID/$userID';
  // -----------------------------------------------------------------------------

  /// app

  // --------------------
  static String app_tests() => '${RealColl.app}/${RealDoc.app_tests}';
  // --------------------
  static String app_history() => '${RealColl.app}/${RealDoc.app_history}';
  // --------------------
  static String app_noteCampaigns() => '${RealColl.app}/${RealDoc.app_noteCampaigns}';
  // --------------------
  static String app_noteCampaigns_campaignID({
    required String campaignID,
  }) => '${RealColl.app}/${RealDoc.app_noteCampaigns}/$campaignID';
  // --------------------
  static String app_emailingLists() => '${RealColl.app}/${RealDoc.app_emailingLists}';
  // --------------------
  static String app_emailingLists_listID({
    required String listID,
  }) => '${RealColl.app}/${RealDoc.app_emailingLists}/$listID';
  // -----------------------------------------------------------------------------

  /// bldrsChains

  // --------------------
  /// NO PATHS
  // -----------------------------------------------------------------------------

  /// USERS records

  // --------------------
  static String records_users_userID({
    required String userID,
  }) => '${RealColl.records}/${RealDoc.records_users}/$userID';
  // --------------------
  static String records_users_userID_records({
    required String userID,
  }) => '${RealColl.records}/${RealDoc.records_users}/$userID/${RealDoc.records_users_userID_records}';
  // --------------------
  static String records_users_userID_counter({
    required String userID,
  }) => '${RealColl.records}/${RealDoc.records_users}/$userID/${RealDoc.records_users_userID_counter}';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? records_users_userID_records_date({
    required String? userID,
    required DateTime time,
  }){

    if (TextCheck.isEmpty(userID) == true){
      return null;
    }
    else {
      final String _day = UserRecordModel.cipherDayNodeName(
          dateTime: time,
      )!;

      final String _output =  '${RealColl.records}/'
                              '${RealDoc.records_users}/'
                              '$userID/'
                              '${RealDoc.records_users_userID_records}/'
                              '$_day';
      return _output;
    }

  }
  // -----------------------------------------------------------------------------

  /// BZZ records

  // --------------------
  static String records_bzz_bzID({
    required String bzID,
  }) => '${RealColl.records}/${RealDoc.records_bzz}/$bzID';
  // --------------------
  static String records_bzz_bzID_counter({
    required String bzID,
  }) => '${RealColl.records}/${RealDoc.records_bzz}/$bzID/${RealDoc.records_bzz_bzID_counter}';
  // --------------------
  static String records_bzz_bzID_recordingCalls({
    required String bzID,
  }) => '${RealColl.records}/${RealDoc.records_bzz}/$bzID/${RealDoc.records_bzz_bzID_recordingCalls}';
  // --------------------
  static String records_bzz_bzID_recordingFollows({
    required String bzID,
  }) => '${RealColl.records}/${RealDoc.records_bzz}/$bzID/${RealDoc.records_bzz_bzID_recordingFollows}';
  // -----------------------------------------------------------------------------

  /// FLYERS records

  // --------------------
  static String records_flyers_bzID({
    required String bzID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID';
  // --------------------
  static String records_flyers_bzID_flyerID({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID/$flyerID';
  // --------------------
  static String records_flyers_bzID_flyerID_counter({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_counter}';
  // --------------------
  static String records_flyers_bzID_flyerID_recordingSaves({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_recordingSaves}';
  // --------------------
  static String records_flyers_bzID_flyerID_recordingShares({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_recordingShares}';
  // --------------------
  static String records_flyers_bzID_flyerID_recordingViews({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.records}/${RealDoc.records_flyers}/$bzID/$flyerID/${RealDoc.records_flyers_bzID_flyerID_recordingViews}';
  // -----------------------------------------------------------------------------

  /// feedbacks

  // --------------------
  /// no paths
  // -----------------------------------------------------------------------------

  /// pickers

  // --------------------
  /// not important
  // -----------------------------------------------------------------------------

  /// searches

  // --------------------
  static String searches_userID({
    required String userID,
  }) => '${RealColl.searches}/$userID';
  // --------------------
  static String searches_userID_searchID({
    required String userID,
    required String searchID,
  }) => '${RealColl.searches}/$userID/$searchID';
  // -----------------------------------------------------------------------------

  /// statistics

  // --------------------
  static String statistics_planet() => '${RealColl.statistics}/${RealDoc.statistics_planet}';
  // --------------------
  static String statistics_countries() => '${RealColl.statistics}/${RealDoc.statistics_countries}';
  // --------------------
  static String statistics_countries_countryID({
    required String countryID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_countries}/$countryID';
  // --------------------
  static String statistics_cities() => '${RealColl.statistics}/${RealDoc.statistics_cities}';
  // --------------------
  static String statistics_cities_countryID({
    required String countryID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID';
  // --------------------
  static String statistics_cities_countryID_cityID({
    required String countryID,
    required String cityID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID/$cityID';
  // -----------------------------------------------------------------------------

  /// zones

  // --------------------
  static String zones_cities_countryID({
    required String countryID,
  }) => '${RealColl.zones}/${RealDoc.zones_cities}/$countryID';
  // --------------------
  static String zones_cities_countryID_cityID({
    required String countryID,
    required String cityID,
  }) => '${RealColl.zones}/${RealDoc.zones_cities}/$countryID/$cityID';
  // --------------------
  static String zones_stagesCities_countryID({
    required String countryID,
  }) => '${RealColl.zones}/${RealDoc.zones_stages_cities}/$countryID';
  // --------------------
  static String zones_stagesCountries() => '${RealColl.zones}/${RealDoc.zones_stages_countries}';
  // -----------------------------------------------------------------------------

  /// zonesPhids

  // --------------------
  static String zonesPhids_countryID({
    required String countryID,
  }) => '${RealColl.zonesPhids}/$countryID';
  // --------------------
  static String zonesPhids_countryID_cityID({
    required String countryID,
    required String cityID,
  }) => '${RealColl.zonesPhids}/$countryID/$cityID';
  // -----------------------------------------------------------------------------

  /// GTA

  // --------------------
  static String gta_selected() => '${RealColl.gta}/${RealDoc.gta_selected}';
  // --------------------
  static String gta_scrapped() => '${RealColl.gta}/${RealDoc.gta_scrapped}';
  // -----------------------------------------------------------------------------

  /// KEYWORDS PHRASES

  // --------------------
  static String keywordsPhrases_lang({
    required String langCode,
  }) => '${RealColl.keywordsPhrases}/$langCode';
  // --------------------
  static String keywordsPhrases_lang_phid({
    required String langCode,
    required String phid,
  }) => '${RealColl.keywordsPhrases}/$langCode/$phid';
  // -----------------------------------------------------------------------------
}
