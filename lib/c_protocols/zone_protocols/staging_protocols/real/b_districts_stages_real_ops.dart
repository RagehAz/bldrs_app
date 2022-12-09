import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictsStagesRealOps {
  // -----------------------------------------------------------------------------

  const DistrictsStagesRealOps();

  // -----------------------------------------------------------------------------

  /// COMPOSE / RESET

  // --------------------
  /// TESTED : WORKS PERFECT : LEFT FOR REFERENCE ONLY
  static Future<void> createInitialDistrictsStagesWithAllDistrictsEmpty() async {

    blog('kept for reference only : should never be used again');

    /*

    final List<String> _countriesIDs = Flag.getAllCountriesIDs();

    for (int i = 0; i < _countriesIDs.length; i++){

      final String countryID = _countriesIDs[i];

      blog('- reading districts for country $countryID');

      final List<DistrictModel> _countyDistricts = await DistrictRealOps.readCountryDistricts(countryID);

      if (Mapper.checkCanLoopList(_countyDistricts) == true){

        final List<CityModel> _cities = await CityRealOps.readCountryCities(countryID: countryID);

        for (final CityModel city in _cities){

          final List<DistrictModel> _cityDistricts = await DistrictRealOps.readCityDistricts(cityID: city.cityID);

          if (Mapper.checkCanLoopList(_cityDistricts) == true){

            final List<String> _districtsIDs = DistrictModel.getDistrictsIDs(_cityDistricts);

            blog('- found ${_districtsIDs.length} districts for city ${city.cityID}');

            await Real.createDocInPath(
              pathWithoutDocName: '${RealColl.zones}/stages_districts/$countryID',
              docName: city.cityID,
              addDocIDToOutput: false,
              map: {
                '1_empty_stage': _districtsIDs,
                '2_bzz_stage': <String>[],
                '3_flyers_stage': <String>[],
                '4_public_stage': <String>[],
              },
            );


          }

        }


      }

      else {
        blog('- not districts found for $countryID');
      }

      blog('# # # # # => ${i+1} / ${_countriesIDs.length} - Country is good : $countryID');

    }

    */

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _uploadDistrictsStages({
    @required String cityID,
    @required Staging districtsStages,
  }) async {

    if (districtsStages != null && cityID != null){

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_stages_districts}/$_countryID',
        docName: cityID,
        addDocIDToOutput: false,
        map: districtsStages.toMap(
          toLDB: false,
        ),
      );

    }

}
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> resetDistrictsStaging({
    @required String cityID,
  }) async {

    Staging _stages;

    if (cityID != null){

      final List<DistrictModel> _districts = await DistrictRealOps.readCityDistricts(
        cityID: cityID,
      );

      if (Mapper.checkCanLoopList(_districts) == false){
        blog('resetDistrictsStages : no districts found for city ( $cityID )');
      }

      else {


        final List<String> _districtsIDs = DistrictModel.getDistrictsIDs(_districts);
        _stages = Staging(
            id: cityID,
            emptyStageIDs: _districtsIDs,
            bzzStageIDs: null,
            flyersStageIDs: null,
            publicStageIDs: null
        );

        await _uploadDistrictsStages(
          cityID: cityID,
          districtsStages: _stages,
        );

      }

    }

    return _stages;
  }
  // -----------------------------------------------------------------------------

  /// READ DISTRICTS STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> readDistrictsStaging({
    @required String cityID,
  }) async {
    Staging _output;

    if (TextCheck.isEmpty(cityID) == false){

      final String countryID = CityModel.getCountryIDFromCityID(cityID);

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_stages_districts}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = Staging.decipher(
        id: cityID,
        map: _map,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> updateDistrictStageType({
    @required String districtID,
    @required StageType newType,
  }) async {

    Staging _output;

    if (districtID != null && newType != null){

      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);

      Staging _districtsStages = await readDistrictsStaging(
        cityID: _cityID,
      );

      /// DISTRICTS STAGES MIGHT BE NULL IF NO DISTRICTS ARE THERE YET,,
      if (_districtsStages == null){

        final List<DistrictModel> _districts = await ZoneProtocols.fetchDistrictsOfCity(
          cityID: _cityID,
        );

        if (Mapper.checkCanLoopList(_districts) == true){

          await Dialogs.errorDialog(
            context: BldrsAppStarter.navigatorKey.currentContext,
            titleVerse: Verse.plain('Something is seriously going wrong here'),
            bodyVerse: Verse.plain('District stages have not been updated,,, take care !'),
          );

        }
        else {

          _districtsStages = Staging.emptyStaging();

        }

      }

      if (_districtsStages != null){

        // _districtsStages.blogStages();

        _output = Staging.insertIDToStaging(
          staging: _districtsStages,
          id: districtID,
          newType: newType,
        );

        // _output.blogStages();

        await _uploadDistrictsStages(
          cityID: _cityID,
          districtsStages: _output,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeDistrictFromStages({
    @required String districtID,
  }) async {

    if (districtID != null){

      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);

      final Staging _districtsStages = await readDistrictsStaging(
        cityID: _cityID,
      );

      if (_districtsStages != null){

        final Staging _new = Staging.removeIDFromStaging(
          staging: _districtsStages,
          id: districtID,
        );

        await _uploadDistrictsStages(
          cityID: _cityID,
          districtsStages: _new,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
