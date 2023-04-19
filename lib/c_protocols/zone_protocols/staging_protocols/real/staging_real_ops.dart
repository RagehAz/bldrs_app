import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

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
      id: Staging.countriesStagingId,
    );

  }
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
  static Future<void> updateCountriesStaging({
    @required Staging newStaging,
  }) async {

    if (newStaging != null){

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
    @required Staging citiesStages,
  }) async {

    if (citiesStages != null){

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_stages_cities}',
        doc: citiesStages.id,
        map: citiesStages.toMap(
          toLDB: false,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDistrictsStaging({
    @required Staging districtsStaging,
  }) async {

    if (districtsStaging != null){

      final String _countryID = CityModel.getCountryIDFromCityID(districtsStaging.id);

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_stages_districts}/$_countryID',
        doc: districtsStaging.id,
        map: districtsStaging.toMap(
          toLDB: false,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
