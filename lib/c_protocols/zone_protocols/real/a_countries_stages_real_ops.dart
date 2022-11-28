import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CountriesStagesRealOps {
  // -----------------------------------------------------------------------------

  const CountriesStagesRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// creating new country is a Hard code job
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> readCountriesStages() async {

    final dynamic _dynamic = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_countriesStages}',
    );

    final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
      ihlmoo: _dynamic,
    );

    return ZoneStages.decipher(_map);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> updateCountryStage({
    @required String countryID,
    @required StageType newType,
  }) async {

    ZoneStages _output;

    if (countryID != null && newType != null){

      final ZoneStages _countriesStages = await readCountriesStages();

      _output = ZoneStages.insertIDToZoneStages(
        zoneStages: _countriesStages,
        id: countryID,
        newType: newType,
      );

      await Real.createDocInPath(
        pathWithoutDocName: RealColl.zones,
        docName: RealDoc.zones_countriesStages,
        addDocIDToOutput: false,
        map: _output.toMap(),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// creating new country is a Hard code job
  // -----------------------------------------------------------------------------
}
