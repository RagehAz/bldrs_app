// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/classes/time/timers.dart';

/// => TAMAM
class RealColl {
  // -----------------------------------------------------------------------------

  const RealColl();

  // -----------------------------------------------------------------------------
  static const String agrees = 'agrees';
  // --------------------
  static const String app = 'app';
  // --------------------
  static const String bldrsChains = 'bldrsChains';
  // --------------------
  static const String recorders = 'recorders';
  // --------------------
  static const String feedbacks = 'feedbacks';
  // --------------------
  static const String phrases = 'phrases';
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
  /// RECORDERS
  // --------------------
  static const String recorders_users = 'users';
  static const String recorders_users_userID_counter = 'counter';
  static const String recorders_users_userID_records = 'records';
  // --------------------
  static const String recorders_bzz = 'bzz';
  static const String recorders_bzz_bzID_counter = 'counter';
  static const String recorders_bzz_bzID_recordingCalls = 'recordingCalls';
  static const String recorders_bzz_bzID_recordingFollows = 'recordingFollows';
  // --------------------
  static const String recorders_flyers = 'flyers';
  static const String recorders_flyers_bzID_flyerID_counter = 'counter';
  static const String recorders_flyers_bzID_flyerID_recordingSaves = 'recordingSaves';
  static const String recorders_flyers_bzID_flyerID_recordingShares = 'recordingShares';
  static const String recorders_flyers_bzID_flyerID_recordingViews = 'recordingViews';
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

  /// bldrsChains

  // --------------------
  /// NO PATHS
  // -----------------------------------------------------------------------------

  /// USERS recorders

  // --------------------
  static String recorders_users_userID_counter({
    required String userID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_users}/$userID/${RealDoc.recorders_users_userID_counter}';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? recorders_users_userID_records_date({
    required String? userID,
  }){

    if (TextCheck.isEmpty(userID) == true){
      return null;
    }
    else {
      final String _day = cipherDayNodeName(
          dateTime: DateTime.now(),
      )!;

      final String _output =  '${RealColl.recorders}/'
                              '${RealDoc.recorders_users}/'
                              '$userID/'
                              '${RealDoc.recorders_users_userID_records}/'
                              '$_day';
      return _output;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherDayNodeName({
    required DateTime? dateTime,
  }){

    if (dateTime == null){
      return null;
    }
    else {

      final String? _year = Numeric.formatNumberWithinDigits(
        num: dateTime.year,
        digits: 4,
      );
      final String? _month = Numeric.formatNumberWithinDigits(
        num: dateTime.month,
        digits: 2,
      );
      final String? _day = Numeric.formatNumberWithinDigits(
        num: dateTime.day,
        digits: 2,
      );

      if (_year == null || _month == null || _day == null){
        return null;
      }
      else {
        return 'd_${_year}_${_month}_$_day';
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? decipherDayNodeName({
    required String? nodeName,
  }){

    /// d_yyyy_mm_dd

    if (TextCheck.isEmpty(nodeName) == true){
      return null;
    }
    else {

      final String yyyy_mm_dd = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: nodeName,
          specialCharacter: '_',
      )!;
      final String yyyy_mm = TextMod.removeTextAfterLastSpecialCharacter(
          text: yyyy_mm_dd,
          specialCharacter: '_',
      )!;

      final String yyyy = TextMod.removeTextAfterLastSpecialCharacter(
          text: yyyy_mm,
          specialCharacter: '_',
      )!;
      final String mm = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: yyyy_mm,
          specialCharacter: '_',
      )!;
      final String dd = TextMod.removeTextBeforeLastSpecialCharacter(
          text: yyyy_mm_dd,
          specialCharacter: '_',
      )!;

      final int? year = Numeric.transformStringToInt(yyyy);
      final int? month = Numeric.transformStringToInt(mm);
      final int? day = Numeric.transformStringToInt(dd);

      if (year == null || month == null || day == null){
        return null;
      }

      else {
        return Timers.createDate(
            year: year,
            month: month,
            day: day
        );
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// BZZ recorders

  // --------------------
  static String recorders_bzz_bzID({
    required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID';
  // --------------------
  static String recorders_bzz_bzID_counter({
    required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_counter}';
  // --------------------
  static String recorders_bzz_bzID_recordingCalls({
    required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_recordingCalls}';
  // --------------------
  static String recorders_bzz_bzID_recordingFollows({
    required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_recordingFollows}';
  // -----------------------------------------------------------------------------

  /// FLYERS recorders

  // --------------------
  static String recorders_flyers_bzID({
    required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID';
  // --------------------
  static String recorders_flyers_bzID_flyerID({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID';
  // --------------------
  static String recorders_flyers_bzID_flyerID_counter({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_counter}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingSaves({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_recordingSaves}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingShares({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_recordingShares}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingViews({
    required String bzID,
    required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_recordingViews}';
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
}
