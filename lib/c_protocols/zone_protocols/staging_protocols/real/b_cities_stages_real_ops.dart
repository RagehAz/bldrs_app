import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CitiesStagesRealOps {
  // -----------------------------------------------------------------------------

  const CitiesStagesRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _uploadDCitiesStages({
    @required String countryID,
    @required Staging citiesStages,
  }) async {

    if (citiesStages != null && countryID != null){

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_stages_cities}',
        docName: countryID,
        addDocIDToOutput: false,
        map: citiesStages.toMap(
          toLDB: false,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createInitialCitiesStagesWithAllCitiesEmpty() async {

    blog('kept for reference only : should never be used again');

    /*
    final List<String> _countriesIDs = Flag.getAllCountriesIDs();

    for (int i = 0; i < _countriesIDs.length; i++){

      final String countryID = _countriesIDs[i];

      blog('- reading cities for country $countryID');

      final List<CityModel> _cities = await CityRealOps.readCountryCities(countryID: countryID);
      final List<String> _citiesIDs = CityModel.getCitiesIDs(_cities);

      blog('- found ${_citiesIDs.length} cities');

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/stages_cities',
        docName: countryID,
        addDocIDToOutput: false,
        map: {
          '1_empty_stage': _citiesIDs,
          '2_bzz_stage': <String>[],
          '3_flyers_stage': <String>[],
          '4_public_stage': <String>[],
        },
      );

      blog('# # # # # => ${i+1} / ${_countriesIDs.length} - Country is good : $countryID');
    }

    */

  }
  // -----------------------------------------------------------------------------

  /// READ CITIES STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> readCitiesStaging({
    @required String countryID,
  }) async {
    Staging _output;

    if (TextCheck.isEmpty(countryID) == false){

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_stages_cities}/$countryID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = Staging.decipher(
        map: _map,
        id: countryID,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> updateCityStageType({
    @required String cityID,
    @required StageType newType,
  }) async {

    Staging _output;

    if (cityID != null && newType != null){

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      final Staging _citiesStages = await readCitiesStaging(
        countryID: _countryID,
      );

      _output = Staging.insertIDToStaging(
        staging: _citiesStages,
        id: cityID,
        newType: newType,
      );

      await _uploadDCitiesStages(
        countryID: _countryID,
        citiesStages: _output,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeCityFromStages({
    @required String cityID,
  }) async {

    if (cityID != null){

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);

      final Staging _citiesStages = await readCitiesStaging(
        countryID: _countryID,
      );

      if (_citiesStages != null){

        final Staging _new = Staging.removeIDFromStaging(
          staging: _citiesStages,
          id: cityID,
        );

        await _uploadDCitiesStages(
          countryID: _countryID,
          citiesStages: _new,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
