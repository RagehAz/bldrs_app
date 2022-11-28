import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class CountriesLevelsRealOps {
  // -----------------------------------------------------------------------------

  const CountriesLevelsRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// creating new country is a Hard code job
  // -----------------------------------------------------------------------------

  /// READ

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

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> updateCountryLevel({
    @required String countryID,
    @required ZoneLevelType newType,
  }) async {

    if (countryID != null && newType != null){

      final ZoneLevel _countriesLevels = await readCountriesLevels();

      final ZoneLevel _newCountriesLevels = ZoneLevel.updateIDLevel(
        oldLevel: _countriesLevels,
        id: countryID,
        newType: newType,
      );

      await Real.createDocInPath(
        pathWithoutDocName: RealColl.zones,
        docName: RealDoc.zones_countriesLevels,
        addDocIDToOutput: false,
        map: _newCountriesLevels.toMap(),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// creating new country is a Hard code task
  // -----------------------------------------------------------------------------
  void f(){}
}
