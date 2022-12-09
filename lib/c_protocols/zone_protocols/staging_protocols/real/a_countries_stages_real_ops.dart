import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CountriesStagesRealOps {
  // -----------------------------------------------------------------------------

  const CountriesStagesRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createInitialCountriesStages() async {

    blog('kept for reference only : should never be used again');

    /*

    const List<Flag> _iso3s = allFlags;

    final List<String> _emptyStageIDs = [];
    final List<String> _bzzStageIDs = [];

    for (final Flag iso3 in _iso3s){

      if (
          iso3.id == 'egy' ||
          iso3.id == 'sau' ||
          iso3.id == 'kwt' ||
          iso3.id == 'and' ||
          iso3.id == 'are' ||
          iso3.id == 'bhr'
      ){
        _bzzStageIDs.add(iso3.id);
      }

      else {
        _emptyStageIDs.add(iso3.id);
      }

    }

    final ZoneStages _stages = ZoneStages(
      emptyStageIDs: _emptyStageIDs,
      bzzStageIDs: _bzzStageIDs,
      flyersStageIDs: const [],
      publicStageIDs: const [],
    );

    _stages.blogStages();

    await Real.createDocInPath(
      pathWithoutDocName: 'zones',
      docName: 'stages_countries',
      addDocIDToOutput: false,
      map: _stages.toMap(),
    );

    */

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> readCountriesStaging() async {

    final dynamic _dynamic = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_stages_countries}',
    );

    final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
      ihlmoo: _dynamic,
    );

    return Staging.decipher(
      map: _map,
      id: 'countries',
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> updateCountryStageType({
    @required String countryID,
    @required StageType newType,
  }) async {

    Staging _output;

    if (countryID != null && newType != null){

      final Staging _countriesStages = await readCountriesStaging();

      _output = Staging.insertIDToStaging(
        staging: _countriesStages,
        id: countryID,
        newType: newType,
      );

      await Real.createDocInPath(
        pathWithoutDocName: RealColl.zones,
        docName: RealDoc.zones_stages_countries,
        addDocIDToOutput: false,
        map: _output.toMap(
          toLDB: false,
        ),
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
