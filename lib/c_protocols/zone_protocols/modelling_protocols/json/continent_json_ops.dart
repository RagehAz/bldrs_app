import 'dart:convert';
import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:flutter/services.dart';
/// => TAMAM
class ContinentJsonOps {
  // -----------------------------------------------------------------------------

  const ContinentJsonOps();

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
}
