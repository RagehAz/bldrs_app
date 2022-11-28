import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class DistrictsStagesRealOps {
  /// --------------------------------------------------------------------------

  const DistrictsStagesRealOps();

  // -----------------------------------------------------------------------------

  /// READ DISTRICTS STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> readDistrictsStages({
    @required String cityID,
  }) async {
    ZoneStages _output;

    if (TextCheck.isEmpty(cityID) == false){

      final String countryID = CityModel.getCountryIDFromCityID(cityID);

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_districtsStages}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = ZoneStages.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
