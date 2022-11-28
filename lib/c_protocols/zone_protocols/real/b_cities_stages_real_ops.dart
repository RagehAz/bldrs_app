import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';

class CitiesStagesRealOps {
  // -----------------------------------------------------------------------------

  const CitiesStagesRealOps();

  // -----------------------------------------------------------------------------

  /// READ CITIES STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> readCitiesStages(String countryID) async {
    ZoneStages _output;

    if (TextCheck.isEmpty(countryID) == false){

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_citiesStages}/$countryID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = ZoneStages.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void f(){}
}
