import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class DistrictsLevelsRealOps {
  /// --------------------------------------------------------------------------

  const DistrictsLevelsRealOps();

  // -----------------------------------------------------------------------------

  /// READ DISTRICTS LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneLevel> readDistrictsLevels({
    @required String cityID,
  }) async {
    ZoneLevel _output;

    if (TextCheck.isEmpty(cityID) == false){

      final String countryID = CityModel.getCountryIDFromCityID(cityID);

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_districtsLevels}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = ZoneLevel.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
