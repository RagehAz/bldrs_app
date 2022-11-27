import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/json/zone_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/zone_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/location/location_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/searchg_zones.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/zone_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class FetchZoneProtocols {
  // -----------------------------------------------------------------------------

  const FetchZoneProtocols();

  // -----------------------------------------------------------------------------

  /// ZONE

  // --------------------
  /// TASK : TEST ME
  static Future<ZoneModel> fetchZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await LocationOps.getPlaceMarksFromGeoPoint(geoPoint: geoPoint);

      // blog('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.checkCanLoopList(_marks) == true){

        final Placemark _mark = _marks[0];

        // blog('mark is : $_mark');

        final String _countryISO2 = _mark.isoCountryCode;
        final String _countryID = Flag.getCountryIDByISO2(_countryISO2);

        final List<CityModel> _countryCities = await ZoneProtocols.fetchCitiesOfCountryByLevel(
          countryID: _countryID,
        );

        CityModel _foundCity;

        if (Mapper.checkCanLoopList(_countryCities) == true) {

          /// by subAdministrativeArea
          List<CityModel> _foundCities = ZoneSearchOps.searchCitiesByName(
            context: context,
            sourceCities: _countryCities,
            inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
              input: TextMod.fixCountryName(_mark.subAdministrativeArea),
              numberOfChars: Standards.maxTrigramLength,
            ),
            langCodes: ['en'],
          );

          /// by administrativeArea
          if (Mapper.checkCanLoopList(_foundCities) == false) {
            _foundCities = ZoneSearchOps.searchCitiesByName(
              context: context,
              sourceCities: _countryCities,
              inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: TextMod.fixCountryName(_mark.administrativeArea),
                numberOfChars: Standards.maxTrigramLength,
              ),
              langCodes: ['en'],
            );
          }

          /// by locality
          if (Mapper.checkCanLoopList(_foundCities) == false) {
            _foundCities = ZoneSearchOps.searchCitiesByName(
              context: context,
              sourceCities: _countryCities,
              inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: TextMod.fixCountryName(_mark.locality),
                numberOfChars: Standards.maxTrigramLength,
              ),
              langCodes: ['en'],
            );
          }

          _foundCity = _foundCities?.first;

        }

        _zoneModel = ZoneModel(
          countryID: _countryID,
          cityID: _foundCity?.cityID,
        );

      }

    }

    return _zoneModel;
  }
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
  /// TESTED : WORKS PERFECT
  static Future<CityModel> fetchCity({
    @required String cityID,
  }) async {

    CityModel _cityModel = await ZoneLDBOps.readCity(cityID);

    if (_cityModel != null){
      // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
    }

    else {

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);

      _cityModel = await ZoneRealOps.readCity(
        countryID: _countryID,
        cityID: cityID,
      );

      if (_cityModel != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

        // await ZoneLDBOps.insertCity(_cityModel);

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
    ValueChanged<CityModel> onCityLoaded,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index) {

          return fetchCity(
            cityID: citiesIDs[index],
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
  // -----------------------------------------------------------------------------

  /// COUNTRY CITIES

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

        final ZoneLevel _citiesIDs = await ZoneRealOps.readCitiesLevels(countryID);

        _output = await fetchCitiesFromSomeOfCountry(
          citiesIDsOfThisCountry: _citiesIDs?.getIDsByCityLevel(cityLevel),
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

      _output = await ZoneRealOps.readCountryCities(countryID: countryID);

      if (Mapper.checkCanLoopList(_output) == true){
        await ZoneLDBOps.insertCities(_output);
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

      final List<CityModel> _ldbCities = await ZoneLDBOps.readCities(citiesIDsOfThisCountry);

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
        final List<CityModel> _remainingCities = await ZoneRealOps.readCities(
          citiesIDs: _citiesIDsToReadFromReal,
        );

        if (Mapper.checkCanLoopList(_remainingCities) == true){
          await ZoneLDBOps.insertCities(_remainingCities);
          _output.addAll(_remainingCities);
        }

      }

    }

    return _output;
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
