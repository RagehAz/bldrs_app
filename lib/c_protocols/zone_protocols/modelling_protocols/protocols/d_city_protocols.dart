import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/fire/city_phrase_fire_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/city_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/real/b_city_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CityProtocols {
  // -----------------------------------------------------------------------------

  const CityProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeCity({
    required CityModel? cityModel,
  }) async {

    if (cityModel != null){

      await Future.wait(<Future>[

        /// ADD CITY ID TO CITIES STAGES
        StagingLeveller.changeCityStageType(
          cityID: cityModel.cityID,
          newType: StageType.emptyStage,
        ),

        /// CREATE CITY MODEL - CITY FIRE PHRASES - INSERT IN LDB
        renovateCity(
          oldCity: null,
          newCity: cityModel,
        ),

      ]);

      await ZoneProtocols.refetchCountry(
        countryID: cityModel.getCountryID(),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel?> fetchCity({
    required String? cityID,
  }) async {
    CityModel? _output;

    if (cityID != null){

      _output = await CityLDBOps.readCity(
        cityID: cityID,
      );

      if (_output != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
      }

      else {

        _output = await CityJsonOps.readCity(
          cityID: cityID,
        );

        if (_output != null){
          // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

          await CityLDBOps.insertCity(
            city: _output,
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
  static Future<List<CityModel>> fetchCities({
    required List<String> citiesIDs,
    ValueChanged<CityModel>? onCityRead,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Lister.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index) {

          return fetchCity(
            cityID: citiesIDs[index],
          ).then((CityModel? city) {

            if (city != null) {

              _cities.add(city);

              if (onCityRead != null) {
                onCityRead(city);
              }

            }

          });
        }),

      ]);

    }

    return _cities;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCitiesOfCountry({
    required String countryID,
    /// If CITY STAGE is null, then all cities will be returned
    StageType? cityStageType,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      final StagingModel? _citiesStages = await StagingProtocols.fetchCitiesStaging(
        countryID: countryID,
        invoker: 'fetchCitiesOfCountry'
      );

      _output = await fetchCitiesOfCountryByIDs(
        citiesIDsOfThisCountry: _citiesStages?.getIDsByType(cityStageType),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCitiesOfCountryByIDs({
    required List<String>? citiesIDsOfThisCountry,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (Lister.checkCanLoopList(citiesIDsOfThisCountry) == true){

      final List<CityModel> _ldbCities = await CityLDBOps.readCities(
        citiesIDs: citiesIDsOfThisCountry,
      );

      // blog('ldb cities aho');
      // CityModel.blogCities(_ldbCities);

      if (_ldbCities.length == citiesIDsOfThisCountry!.length){
        _output = _ldbCities;
      }

      else {

        /// ADD FOUND CITIES
        _output.addAll(_ldbCities);

        /// COLLECT NOT FOUND CITIES
        final List<String> _citiesIDsToReadFromReal = <String>[];

        if (Lister.checkCanLoopList(citiesIDsOfThisCountry) == true){

          for (final String cityID in citiesIDsOfThisCountry){
            final bool _wasInLDB = CityModel.checkCitiesIncludeCityID(_ldbCities, cityID);
            if (_wasInLDB == false){
              _citiesIDsToReadFromReal.add(cityID);
            }
          }

          /// READ REMAINING CITIES FROM REAL
          final List<CityModel> _remainingCities = await CityJsonOps.readCities(
            citiesIDs: _citiesIDsToReadFromReal,
          );

          if (Lister.checkCanLoopList(_remainingCities) == true){

            await CityLDBOps.insertCities(
              cities: _remainingCities,
            );

            _output.addAll(_remainingCities);

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
  static Future<void> renovateCity({
    required CityModel? oldCity,
    required CityModel? newCity,
  }) async {

    if (
        oldCity != null
        &&
        newCity != null
        &&
        CityModel.checkCitiesAreIdentical(oldCity, newCity) == false
    ){

      await Future.wait(<Future>[

        /// UPDATE CITY IN REAL
        CityRealOps.updateCity(
          newCity: newCity,
        ),

        /// UPDATE CITY IN LDB
        CityLDBOps.insertCity(
          city: newCity,
        ),

        /// UPDATE CITY PHRASE IN FIRE
        if (Phrase.checkPhrasesListsAreIdentical(
            phrases1: oldCity.phrases,
            phrases2: newCity.phrases
        ) == false)
        CityPhraseFireOps.updateCityPhrases(
            cityModel: newCity
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeCity({
    required CityModel? cityModel,
  }) async {

    if (cityModel != null){


      await Future.wait(<Future>[

        /// STAGES
        StagingProtocols.removeCityFromStages(
          cityID: cityModel.cityID,
        ),

        /// MODEL
        CityRealOps.deleteCity(
          cityID: cityModel.cityID,
        ),

        /// FIRE PHRASES
        CityPhraseFireOps.deleteCityPhrases(
            cityModel: cityModel
        ),

        /// LDB
        CityLDBOps.deleteCity(
          cityID: cityModel.cityID,
        ),

      ]);

      await ZoneProtocols.refetchCountry(
        countryID: CityModel.getCountryIDFromCityID(cityModel.cityID),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
