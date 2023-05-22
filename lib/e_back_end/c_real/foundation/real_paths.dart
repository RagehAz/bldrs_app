// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

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
}

/// => TAMAM
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
  /// RECORDERS
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
    @required String bzID,
  }) => '${RealColl.agrees}/$bzID';
  // --------------------
  static String agrees_bzID_flyerID({
    @required String bzID,
    @required String flyerID,
  }) => '${RealColl.agrees}/$bzID/$flyerID';
  // --------------------
  static String agrees_bzID_flyerID_reviewID({
    @required String bzID,
    @required String flyerID,
    @required String reviewID,
  }) => '${RealColl.agrees}/$bzID/$flyerID/$reviewID';
  // --------------------
  static String agrees_bzID_flyerID_reviewID_userID({
    @required String bzID,
    @required String flyerID,
    @required String reviewID,
    @required String userID,
  }) => '${RealColl.agrees}/$bzID/$flyerID/$reviewID/$userID';
  // -----------------------------------------------------------------------------

  /// app

  // --------------------
  static String app_appState() => '${RealColl.app}/${RealDoc.app_appState}';
  // -----------------------------------------------------------------------------

  /// bldrsChains

  // --------------------
  /// NO PATHS
  // -----------------------------------------------------------------------------

  /// BZZ recorders

  // --------------------
  static String recorders_bzz_bzID({
    @required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID';
  // --------------------
  static String recorders_bzz_bzID_counter({
    @required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_counter}';
  // --------------------
  static String recorders_bzz_bzID_recordingCalls({
    @required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_recordingCalls}';
  // --------------------
  static String recorders_bzz_bzID_recordingFollows({
    @required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_bzz}/$bzID/${RealDoc.recorders_bzz_bzID_recordingFollows}';
  // -----------------------------------------------------------------------------

  /// FLYERS recorders

  // --------------------
  static String recorders_flyers_bzID({
    @required String bzID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID';
  // --------------------
  static String recorders_flyers_bzID_flyerID({
    @required String bzID,
    @required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID';
  // --------------------
  static String recorders_flyers_bzID_flyerID_counter({
    @required String bzID,
    @required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_counter}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingSaves({
    @required String bzID,
    @required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_recordingSaves}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingShares({
    @required String bzID,
    @required String flyerID,
  }) => '${RealColl.recorders}/${RealDoc.recorders_flyers}/$bzID/$flyerID/${RealDoc.recorders_flyers_bzID_flyerID_recordingShares}';
  // --------------------
  static String recorders_flyers_bzID_flyerID_recordingViews({
    @required String bzID,
    @required String flyerID,
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
    @required String userID,
  }) => '${RealColl.searches}/$userID';
  // -----------------------------------------------------------------------------

  /// statistics

  // --------------------
  static String statistics_planet() => '${RealColl.statistics}/${RealDoc.statistics_planet}';
  // --------------------
  static String statistics_countries() => '${RealColl.statistics}/${RealDoc.statistics_countries}';
  // --------------------
  static String statistics_countries_countryID({
    @required String countryID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_countries}/$countryID';
  // --------------------
  static String statistics_cities() => '${RealColl.statistics}/${RealDoc.statistics_cities}';
  // --------------------
  static String statistics_cities_countryID({
    @required String countryID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID';
  // --------------------
  static String statistics_cities_countryID_cityID({
    @required String countryID,
    @required String cityID,
  }) => '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID/$cityID';
  // -----------------------------------------------------------------------------

  /// zones

  // --------------------
  static String zones_cities_countryID({
    @required String countryID,
  }) => '${RealColl.zones}/${RealDoc.zones_cities}/$countryID';
  // --------------------
  static String zones_cities_countryID_cityID({
    @required String countryID,
    @required String cityID,
  }) => '${RealColl.zones}/${RealDoc.zones_cities}/$countryID/$cityID';
  // --------------------
  static String zones_stagesCities_countryID({
    @required String countryID,
  }) => '${RealColl.zones}/${RealDoc.zones_stages_cities}/$countryID';
  // --------------------
  static String zones_stagesCountries() => '${RealColl.zones}/${RealDoc.zones_stages_countries}';
  // -----------------------------------------------------------------------------

  /// zonesPhids

  // --------------------
  static String zonesPhids_countryID({
    @required String countryID,
  }) => '${RealColl.zonesPhids}/$countryID';
  // --------------------
  static String zonesPhids_countryID_cityID({
    @required String countryID,
    @required String cityID,
  }) => '${RealColl.zonesPhids}/$countryID/$cityID';
  // -----------------------------------------------------------------------------
}
