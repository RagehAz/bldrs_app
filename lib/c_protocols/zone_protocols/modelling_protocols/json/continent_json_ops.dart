import 'dart:convert';

import 'package:bldrs/world_zoning/world_zoning.dart';
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
    final String _jsonStringValues = await rootBundle.loadString('packages/basics/lib/bldrs_theme/assets/planet/continents.json');
    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);
    return Continent.decipherContinents(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
