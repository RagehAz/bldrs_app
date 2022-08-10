import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:bldrs/e_db/fire/search/zone_search.dart' as ZoneFireSearch;
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/zone_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FetchZoneProtocols {
// -----------------------------------------------------------------------------

  const FetchZoneProtocols();

// -----------------------------------------------------------------------------

  /// COUNTRY

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> fetchCountry({
    @required BuildContext context,
    @required String countryID,
  }) async {

    CountryModel _countryModel = await ZoneLDBOps.readCountry(countryID);

    if (_countryModel != null){
      // blog('fetchCountry : ($countryID) CountryModel FOUND in LDB');
    }

    else {

      _countryModel = await ZoneFireOps.readCountryOps(
        context: context,
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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CountryModel>> fetchCountries({
    @required BuildContext context,
    @required List<String> countriesIDs,
  }) async {

    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.checkCanLoopList(countriesIDs)){

      for (final String id in countriesIDs){

        final CountryModel _country = await fetchCountry(
          context: context,
          countryID: id,
        );

        _countries.add(_country);

      }

    }

    return _countries;
  }
// -----------------------------------------------------------------------------

  /// CITY

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCity({
    @required BuildContext context,
    @required String cityID,
  }) async {

    CityModel _cityModel = await ZoneLDBOps.readCity(cityID);

    if (_cityModel != null){
      // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
    }

    else {

      _cityModel = await ZoneFireOps.readCityOps(
        context: context,
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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> fetchCities({
    @required BuildContext context,
    @required List<String> citiesIDs,
    ValueChanged<CityModel> onCityLoaded,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDs)){

      for (final String id in citiesIDs){

        final CityModel _city = await fetchCity(
            context: context,
            cityID: id,
        );

        if (_city != null){

          _cities.add(_city);

          if (onCityLoaded != null){
            onCityLoaded(_city);
          }

        }

      }

    }

    return _cities;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCityByName({
    @required BuildContext context,
    @required String cityName,
    @required String langCode,
    String countryID,
  }) async {

    CityModel _city;

    if (TextChecker.stringIsNotEmpty(cityName) == true){

      /// A - trial 1 : search by generated cityID
      if (countryID != null){

        final String _cityID = CityModel.createCityID(
          countryID: countryID,
          cityEnName: cityName,
        );

        _city = await fetchCity(
          context: context,
          cityID: _cityID,
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
              context: context,
              cityName: cityName,
              lingoCode: langCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await ZoneFireSearch.citiesByCityNameAndCountryID(
              context: context,
              cityName: cityName,
              countryID: countryID,
              lingoCode: langCode,
            );
          }

          /// C-2 - if firebase returned results
          if (Mapper.checkCanLoopList(_foundCities) == true){

            /// insert all cities in ldb
            for (final CityModel city in _foundCities){
              await LDBOps.insertMap(
                input: city.toMap(toJSON: true),
                docName: LDBDoc.cities,
              );
            }

          }

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

            final CityModel _selectedCity = await Dialogz.confirmCityDialog(
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

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> fetchContinents({
    @required BuildContext context,
  }) async {

    List<Continent> _continents = await ZoneLDBOps.readContinents();

    if (Mapper.checkCanLoopList(_continents) == true){
      blog('fetchContinents : All Continents FOUND in LDB');
    }

    else {

      _continents = await ZoneFireOps.readContinentsOps(
        context: context,
      );

      if (_continents != null){
        blog('fetchContinents : All Continents FOUND in FIREBASE and inserted in LDB');

        await ZoneLDBOps.insertContinents(_continents);

      }

    }

    if (_continents == null){
      blog('fetchContinents : All Continents NOT FOUND');
    }

    return _continents;

  }
// -------------------------------------

}
