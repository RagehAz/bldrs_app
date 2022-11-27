import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_city_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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

    final ZoneLevel _citiesIDs = await CityRealOps.readCitiesLevels(countryID);

    if (_citiesIDs != null){
      _output = CountryModel(
        id: countryID,
        citiesIDs: _citiesIDs,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRIES LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneLevel> readCountriesLevels() async {

    final dynamic _dynamic = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_countriesLevels}',
    );

    final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
      ihlmoo: _dynamic,
    );

    return ZoneLevel.decipher(_map);
  }
  // -----------------------------------------------------------------------------
}
