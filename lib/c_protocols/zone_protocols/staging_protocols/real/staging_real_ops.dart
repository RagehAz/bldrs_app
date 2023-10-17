import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class StagingRealOps {
  // -----------------------------------------------------------------------------

  const StagingRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT : LEFT FOR REFERENCE ONLY
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
  // --------------------
  /// TESTED : WORKS PERFECT : LEFT FOR REFERENCE ONLY
  static Future<void> createInitialCitiesStagesWithAllCitiesEmpty() async {

    blog('kept for reference only : should never be used again');

    // final List<String> _countriesIDs = Flag.getAllCountriesIDs();
    // final List<String> _countriesIDs = America.getStatesIDs();
    //
    // for (int i = 0; i < _countriesIDs.length; i++){
    //
    //   final String countryID = _countriesIDs[i];
    //
    //   blog('- reading cities for country $countryID');
    //
    //   final List<CityModel> _cities = await CityJsonOps.readCountryCities(
    //     countryID: countryID,
    //   );
    //
    //   final List<String> _citiesIDs = CityModel.getCitiesIDs(_cities);
    //
    //   blog('- found ${_citiesIDs.length} cities');
    //
    //   await Real.createDocInPath(
    //     pathWithoutDocName: '${RealColl.zones}/stages_cities',
    //     doc: countryID,
    //     map: {
    //       '1_empty_stage': _citiesIDs,
    //       // '2_bzz_stage': <String>[],
    //       // '3_flyers_stage': <String>[],
    //       // '4_public_stage': <String>[],
    //     },
    //   );
    //
    //   blog('# # # # # => ${i+1} / ${_countriesIDs.length} - Country is good : $countryID');
    // }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> readCountriesStaging() async {

    if (Authing.userHasID() == true){

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: '${RealColl.zones}/${RealDoc.zones_stages_countries}',
      );

      return StagingModel.decipher(
        map: _map,
        id: StagingModel.countriesStagingId,
      );

    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> readCitiesStaging({
    required String? countryID,
  }) async {
    StagingModel? _output;

    if (Authing.userHasID() == true && TextCheck.isEmpty(countryID) == false){

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: '${RealColl.zones}/${RealDoc.zones_stages_cities}/$countryID',
      );

      _output = StagingModel.decipher(
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
  static Future<void> updateCountriesStaging({
    required StagingModel? newStaging,
  }) async {

    if (Authing.userHasID() == true && newStaging != null){

      await Real.createDocInPath(
        pathWithoutDocName: RealColl.zones,
        doc: RealDoc.zones_stages_countries,
        map: newStaging.toMap(
          toLDB: false,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateCitiesStaging({
    required StagingModel? citiesStages,
  }) async {

    if (Authing.userHasID() == true && citiesStages != null){

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_stages_cities}',
        doc: citiesStages.id,
        map: citiesStages.toMap(
          toLDB: false,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
