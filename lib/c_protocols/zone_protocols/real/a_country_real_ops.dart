import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_cities_levels_real_ops.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CountryRealOps {
  // -----------------------------------------------------------------------------

  const CountryRealOps();

  // -----------------------------------------------------------------------------

  /// READ COUNTRY MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> readCountry({
    @required String countryID,
  }) async {
    CountryModel _output;

    final ZoneLevel _citiesIDs = await CitiesLevelsRealOps.readCitiesLevels(countryID);

    if (_citiesIDs != null){
      _output = CountryModel(
        id: countryID,
        citiesIDs: _citiesIDs,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
