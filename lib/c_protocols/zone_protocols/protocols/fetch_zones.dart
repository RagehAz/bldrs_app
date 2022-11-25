import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/a_models/d_zone/zz_old/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/zone_protocols/fire/zone_search.dart' as ZoneFireSearch;
import 'package:bldrs/c_protocols/zone_protocols/json/zone_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/zone_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/zone_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FetchZoneProtocols {
  // -----------------------------------------------------------------------------

  const FetchZoneProtocols();

  // -----------------------------------------------------------------------------

  /// COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> fetchCountry({
    @required String countryID,
  }) async {

    CountryModel _countryModel = await ZoneLDBOps.readCountry(countryID);

    if (_countryModel != null){
      // blog('fetchCountry : ($countryID) CountryModel FOUND in LDB');
    }

    else {

      _countryModel = await ZoneRealOps.readCountry(
        countryID: countryID,
      );

      if (_countryModel != null){
        // blog('fetchCountry : ($countryID) CountryModel FOUND in FIRESTORE and inserted in LDB');

        await ZoneLDBOps.insertCountry(_countryModel);

      }

    }

    // if (_countryModel == null){
    //   blog('fetchCountry : ($countryID) CountryModel NOT FOUND');
    // }

    return _countryModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CountryModel>> fetchCountries({
    @required List<String> countriesIDs,
  }) async {
    final List<CountryModel> _output = <CountryModel>[];

    if (Mapper.checkCanLoopList(countriesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(countriesIDs.length, (index){

          return fetchCountry(
            countryID: countriesIDs[index],
          ).then((CountryModel country){
            if (country != null){
              _output.add(country);
            }
          });

        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CITY

  // --------------------
  /// TASK : TEST ME
  static Future<CityModel> fetchCity({
    @required String countryID,
    @required String cityID,
  }) async {

    CityModel _cityModel = await ZoneLDBOps.readCity(cityID);

    if (_cityModel != null){
      // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
    }

    else {

      _cityModel = await ZoneRealOps.readCity(
        countryID: countryID,
        cityID: cityID,
      );

      if (_cityModel != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

        await ZoneLDBOps.insertCity(_cityModel);

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
    @required String countryID,
    @required List<String> citiesIDsOfThisCountry,
    ValueChanged<CityModel> onCityLoaded,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDsOfThisCountry) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDsOfThisCountry.length, (index) {

          return fetchCity(
            cityID: citiesIDsOfThisCountry[index],
            countryID: countryID,
          ).then((value) {

            if (value != null) {

              _cities.add(value);

              if (onCityLoaded != null) {
                onCityLoaded(value);
              }

            }

          });
        }),

      ]);

    }

    return _cities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCityByName({
    @required BuildContext context,
    @required String cityName,
    @required String langCode,
    @required String countryID,
  }) async {

    CityModel _city;

    if (TextCheck.isEmpty(cityName) == false){

      /// A - trial 1 : search by generated cityID
      if (countryID != null){

        final String _cityID = CityModel.createCityID(
          countryID: countryID,
          cityEnName: cityName,
        );

        _city = await fetchCity(
          cityID: _cityID,
          countryID: countryID,
        );

      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities = await ZoneLDBOps.searchCitiesByName(
          cityName: cityName,
          langCode: langCode,
        );

        /// C - trial 3 search firebase if no result found in LDB
        if (Mapper.checkCanLoopList(_foundCities) == false){

          /// C-1 - trial 3 if countryID is not available
          if (countryID == null){
            _foundCities = await ZoneFireSearch.citiesByCityName(
              cityName: cityName,
              lingoCode: langCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await ZoneFireSearch.citiesByCityNameAndCountryID(
              cityName: cityName,
              countryID: countryID,
              lingoCode: langCode,
            );
          }

          /// C-2 - if firebase returned results
          await ZoneLDBOps.insertCities(_foundCities);

        }

        /// D - if firebase or LDB found any cities
        if (Mapper.checkCanLoopList(_foundCities) == true){

          blog('aho fetchCityByName : _foundCities.length = ${_foundCities.length}');

          /// D-1 if only one city found
          if (_foundCities.length == 1){
            _city = _foundCities[0];
          }

          /// D-2 if multiple cities found
          else {

            final CityModel _selectedCity = await Dialogs.confirmCityDialog(
              context: context,
              cities: _foundCities,
            );

            if (_selectedCity != null){
              _city = _selectedCity;
            }

          }

        }

      }

    }

    return _city;
  }
  // -----------------------------------------------------------------------------

  /// CONTINENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> fetchContinents() async {
    final List<Continent> _continents = await ZoneJSONOps.readAllContinents();
    return _continents;
  }
  // --------------------

}
