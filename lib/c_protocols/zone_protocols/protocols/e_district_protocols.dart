import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/fire/district_phrase_fire_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/c_district_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_districts_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictProtocols {
  // -----------------------------------------------------------------------------

  const DistrictProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeDistrict({
    @required BuildContext context,
    @required DistrictModel districtModel,
  }) async {

    if (districtModel != null){

      await Future.wait(<Future>[

        /// ADD CITY ID TO CITIES STAGES
        DistrictsStagesRealOps.updateDistrictStage(
          context: context,
          districtID: districtModel.id,
          newType: StageType.hidden,
        ),

        /// CREATE CITY MODEL - CITY FIRE PHRASES - INSERT IN LDB
        renovateDistrict(
          oldDistrict: null,
          newDistrict: districtModel,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DistrictModel> fetchDistrict({
    @required String districtID,
  }) async {
    DistrictModel _output;

    if (districtID != null){

      _output = await DistrictLDBOps.readDistrict(
        districtID: districtID,
      );

      if (_output != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
      }

      else {

        _output = await DistrictRealOps.readDistrict(
          districtID: districtID,
        );

        if (_output != null){
          // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

          await DistrictLDBOps.insertDistrict(
            districtModel: _output,
          );

        }

      }

      if (_output == null){
        // blog('fetchCity : ($cityID) CityModel NOT FOUND');
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> fetchDistricts({
    @required List<String> districtsIDs,
    ValueChanged<DistrictModel> onDistrictRead,
  }) async {
    final List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(districtsIDs.length, (index) {

          return fetchDistrict(
            districtID: districtsIDs[index],
          ).then((DistrictModel district) {

            if (district != null) {

              _output.add(district);

              if (onDistrictRead != null) {
                onDistrictRead(district);
              }

            }

          });
        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITY DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> fetchDistrictsOfCity({
    @required String cityID,
    /// If DISTRICT STAGE TYPE is null, then all cities will be returned
    StageType districtStageType,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (TextCheck.isEmpty(cityID) == false){

      final ZoneStages _districtsStages = await DistrictsStagesRealOps.readDistrictsStages(
        cityID: cityID,
      );

      if (_districtsStages != null){

        _output = await fetchDistrictsOfCityByIDs(
          districtsIDsOfThisCity: _districtsStages?.getIDsByStage(districtStageType),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> fetchDistrictsOfCityByIDs({
    @required List<String> districtsIDsOfThisCity,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDsOfThisCity) == true){

      final List<DistrictModel> _ldbDistricts = await DistrictLDBOps.readDistricts(
        districtsIDs: districtsIDsOfThisCity,
      );

      if (_ldbDistricts.length == districtsIDsOfThisCity.length){
        _output = _ldbDistricts;
      }

      else {

        /// ADD FOUND DISTRICTS
        _output.addAll(_ldbDistricts);

        /// COLLECT NOT FOUND DISTRICTS
        final List<String> _districtsIDsToReadFromReal = <String>[];
        for (final String districtID in districtsIDsOfThisCity){
          final bool _wasInLDB = DistrictModel.checkDistrictsIncludeDistrictID(_ldbDistricts, districtID);
          if (_wasInLDB == false){
            _districtsIDsToReadFromReal.add(districtID);
          }
        }

        /// READ REMAINING CITIES FROM REAL
        final List<DistrictModel> _remainingDistricts = await DistrictRealOps.readDistricts(
          districtsIDs: _districtsIDsToReadFromReal,
        );

        if (Mapper.checkCanLoopList(_remainingDistricts) == true){
          await DistrictLDBOps.insertDistricts(
            districts: _remainingDistricts,
          );
          _output.addAll(_remainingDistricts);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> fetchDistrictsOfCountry({
    @required String countryID,
    StageType citiesStage,
    StageType districtsStage,
  }) async {
    final List<DistrictModel> _output = <DistrictModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      final ZoneStages _citiesStages = await ZoneProtocols.readCitiesStages(
        countryID: countryID,
      );

      if (_citiesStages != null){

        final List<String> _citiesIDs = _citiesStages.getIDsByStage(citiesStage);

        for (final String cityID in _citiesIDs){

          final List<DistrictModel> _cityDistricts = await fetchDistrictsOfCity(
            cityID: cityID,
            districtStageType: districtsStage,
          );

          if (Mapper.checkCanLoopList(_cityDistricts) == true){
            _output.addAll(_cityDistricts);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateDistrict({
    @required DistrictModel newDistrict,
    @required DistrictModel oldDistrict,
  }) async {

    if (DistrictModel.checkDistrictsAreIdentical(oldDistrict, newDistrict) == false){

      await Future.wait(<Future>[

        /// UPDATE DISTRICT IN REAL
        DistrictRealOps.updateDistrict(
          newDistrict: newDistrict,
        ),

        /// UPDATE DISTRICT IN LDB
        DistrictLDBOps.insertDistrict(
          districtModel: newDistrict,
        ),

        /// UPDATE DISTRICT PHRASE IN FIRE
        if (Phrase.checkPhrasesListsAreIdentical(
            phrases1: oldDistrict?.phrases,
            phrases2: newDistrict?.phrases
        ) == false)
          DistrictPhraseFireOps.updateDistrictPhrases(
              districtModel: newDistrict
          ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeDistrict({
    @required DistrictModel districtModel,
  }) async {

    if (districtModel != null){

      await Future.wait(<Future>[

        /// STAGES
        DistrictsStagesRealOps.removeDistrictFromStages(
          districtID: districtModel.id,
        ),

        /// MODEL
        DistrictRealOps.deleteDistrict(
          districtID: districtModel.id,
        ),

        /// FIRE PHRASES
        DistrictPhraseFireOps.deleteDistrictPhrases(
            districtModel: districtModel
        ),

        /// LDB
        DistrictLDBOps.deleteDistrict(
          districtID: districtModel.id,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
