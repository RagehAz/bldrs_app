import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_city_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class CityProtocols {
  // -----------------------------------------------------------------------------

  const CityProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// FETCH CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCity({
    @required String cityID,
  }) async {

    CityModel _cityModel = await CityLDBOps.readCity(cityID);

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

        await CityLDBOps.insertCity(_cityModel);

      }

    }

    if (_cityModel == null){
      // blog('fetchCity : ($cityID) CityModel NOT FOUND');
    }

    return _cityModel;
  }
  // --------------------
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<List<CityModel>> fetchCitiesOfCountryByLevel({
    @required String countryID,
    /// If cityLevel is null, then all cities will be returned
    ZoneLevelType cityLevel,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      /// SHOULD FETCH ALL CITIES
      if (cityLevel == null){
        _output = await fetchCitiesFromAllOfCountry(countryID: countryID);
      }

      /// SHOULD FETCH ONLY CITIES OF THIS LEVEL
      else {

        final ZoneLevel _citiesIDs = await CityRealOps.readCitiesLevels(countryID);

        _output = await fetchCitiesFromSomeOfCountry(
          citiesIDsOfThisCountry: _citiesIDs?.getIDsByLevel(cityLevel),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<CityModel>> fetchCitiesFromAllOfCountry({
    @required String countryID,
  }) async {
    List<CityModel> _output = <CityModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      _output = await CityRealOps.readCountryCities(countryID: countryID);

      if (Mapper.checkCanLoopList(_output) == true){
        await CityLDBOps.insertCities(_output);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<CityModel>> fetchCitiesFromSomeOfCountry({
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
          await CityLDBOps.insertCities(_remainingCities);
          _output.addAll(_remainingCities);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
