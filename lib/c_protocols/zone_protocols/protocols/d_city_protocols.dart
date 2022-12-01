import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/fire/city_phrase_fire_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_city_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
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
    @required CityModel cityModel,
  }) async {

    if (cityModel != null){

      await Future.wait(<Future>[

        /// ADD CITY ID TO CITIES STAGES
        CitiesStagesRealOps.updateCityStage(
          cityID: cityModel.cityID,
          newType: StageType.hidden,
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
  static Future<CityModel> fetchCity({
    @required String cityID,
  }) async {
    CityModel _cityModel;

    if (cityID != null){

      CityModel _cityModel = await CityLDBOps.readCity(
        cityID: cityID,
      );

      if (_cityModel != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
      }

      else {

        final String _countryID = CityModel.getCountryIDFromCityID(cityID);

        _cityModel = await CityRealOps.readCity(
          countryID: _countryID,
          cityID: cityID,
        );

        if (_cityModel != null){
          // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

          await CityLDBOps.insertCity(
            city: _cityModel,
          );

        }

      }

      if (_cityModel == null){
        // blog('fetchCity : ($cityID) CityModel NOT FOUND');
      }

    }

    return _cityModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCities({
    @required List<String> citiesIDs,
    ValueChanged<CityModel> onCityRead,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index) {

          return fetchCity(
            cityID: citiesIDs[index],
          ).then((CityModel city) {

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
    @required String countryID,
    /// If CITY STAGE is null, then all cities will be returned
    StageType cityStageType,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      final ZoneStages _citiesStages = await CitiesStagesRealOps.readCitiesStages(
        countryID: countryID,
      );

      _output = await fetchCitiesOfCountryByIDs(
        citiesIDsOfThisCountry: _citiesStages?.getIDsByStage(cityStageType),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCitiesOfCountryByIDs({
    @required List<String> citiesIDsOfThisCountry,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDsOfThisCountry) == true){

      final List<CityModel> _ldbCities = await CityLDBOps.readCities(
        citiesIDs: citiesIDsOfThisCountry,
      );

      if (_ldbCities.length == citiesIDsOfThisCountry.length){
        _output = _ldbCities;
      }

      else {

        /// ADD FOUND CITIES
        _output.addAll(_ldbCities);

        /// COLLECT NOT FOUND CITIES
        final List<String> _citiesIDsToReadFromReal = <String>[];
        for (final String cityID in citiesIDsOfThisCountry){
          final bool _wasInLDB = CityModel.checkCitiesIncludeCityID(_ldbCities, cityID);
          if (_wasInLDB == false){
            _citiesIDsToReadFromReal.add(cityID);
          }
        }

        /// READ REMAINING CITIES FROM REAL
        final List<CityModel> _remainingCities = await CityRealOps.readCities(
          citiesIDs: _citiesIDsToReadFromReal,
        );

        if (Mapper.checkCanLoopList(_remainingCities) == true){

          await CityLDBOps.insertCities(
            cities: _remainingCities,
          );

          _output.addAll(_remainingCities);

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
    @required CityModel oldCity,
    @required CityModel newCity,
  }) async {

    if (CityModel.checkCitiesAreIdentical(oldCity, newCity) == false){

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
            phrases1: oldCity?.phrases,
            phrases2: newCity?.phrases
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
    @required CityModel cityModel,
  }) async {

    if (cityModel != null){

      await Future.wait(<Future>[

        /// STAGES
        CitiesStagesRealOps.removeCityFromStages(
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
