import 'dart:convert';

import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZoneJSONOps {
  // -----------------------------------------------------------------------------

  const ZoneJSONOps();

  // -----------------------------------------------------------------------------

  /// READ ALL ISO3s

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Flag>> readAllISO3s() async {
    final String _jsonStringValues = await rootBundle.loadString('assets/planet/iso3.json');
    final List<dynamic> _mappedJson = json.decode(_jsonStringValues);
    return Flag.decipherMaps(_mappedJson);
  }
  // -----------------------------------------------------------------------------

  /// READ ISO3

  // --------------------
  ///
  static Future<Flag> readISO3ByCountryID({
    @required String countryID,
  }) async {
    final List<Flag> _allISO3s = await readAllISO3s();
    return Flag.getFlagFromFlagsByCountryID(
      flags: _allISO3s,
      countryID: countryID,
    );
  }
  // -----------------------------------------------------------------------------

  /// READ CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> readAllContinents() async {
    final String _jsonStringValues = await rootBundle.loadString('assets/planet/continents.json');
    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);
    return Continent.decipherContinents(_mappedJson);
  }
  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CurrencyModel>> readAllCurrencies() async {
    final String _jsonStringValues = await rootBundle.loadString('assets/planet/currencies.json');
    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);
    return CurrencyModel.decipherCurrencies(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
