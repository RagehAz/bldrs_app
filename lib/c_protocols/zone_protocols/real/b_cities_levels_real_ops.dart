import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';

class CitiesLevelsRealOps {
  // -----------------------------------------------------------------------------

  const CitiesLevelsRealOps();

  // -----------------------------------------------------------------------------

  /// READ CITIES LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneLevel> readCitiesLevels(String countryID) async {
    ZoneLevel _output;

    if (TextCheck.isEmpty(countryID) == false){

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_citiesLevels}/$countryID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = ZoneLevel.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void f(){}
}
