import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/zone_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class ZoneSearchOps {
  // -----------------------------------------------------------------------------

  const ZoneSearchOps();

  // -----------------------------------------------------------------------------

  /// PLANET COUNTRIES

  // --------------------
  /// TASK : WRITE ME
  static List<Flag> searchPlanetCountriesByID(String countryID){
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static List<Flag> searchPlanetCountriesByName(String name){
    return null;
  }
  // -----------------------------------------------------------------------------

  /// PLANET CITIES

  // --------------------
  /// TASK : WRITE ME
  static Future<List<CityModel>> searchPlanetCitiesByID(String cityID) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<CityModel>> searchPlanetCitiesByName(String name) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// COUNTRY CITIES

  // --------------------
  /// TASK : WRITE ME
  static Future<List<CityModel>> searchCountryCitiesByID(String cityID) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<CityModel>> searchCountryCitiesByName(String name) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// PLANET DISTRICTS

  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchPlanetDistrictsByID(String districtID) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchPlanetDistrictsByName(String name) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// CITY DISTRICTS

  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchCityDistrictsByID(String districtID) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchCityDistrictsByName(String name) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// OLD AND DEPRECATED : TASK : DELETE WHEN TAMAM

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> searchCitiesByName({
    @required BuildContext context,
    @required List<CityModel> sourceCities,
    @required String inputText,
    List<String> langCodes = const <String>['en', 'ar'],
  }){

    /// CREATE PHRASES LIST
    final List<Phrase> _citiesPhrases = <Phrase>[];

    /// ADD ALL MIXED LANG PHRASES IN THE LIST
    for (final String langCode in langCodes){
      for (final CityModel city in sourceCities){

        final Phrase _cityPhrase = Phrase.searchPhraseByIDAndLangCode(
          phid: city.cityID,
          langCode: langCode,
          phrases: city.phrases,
        );
        _citiesPhrases.add(_cityPhrase);

      }

    }


    /// SEARCH PHRASES
    final List<Phrase> _foundPhrases = Phrase.searchPhrasesTrigrams(
      sourcePhrases: _citiesPhrases,
      inputText: inputText,
    );

    /// GET CITIES BY IDS FROM NAMES
    final List<CityModel> _foundCities = _getCitiesFromPhrases(
        phrases: _foundPhrases,
        sourceCities: sourceCities
    );

    // CityModel.blogCities(_foundCities);

    return _foundCities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> _getCitiesFromPhrases({
    @required List<Phrase> phrases,
    @required List<CityModel> sourceCities,
  }){
    final List<CityModel> _foundCities = <CityModel>[];

    if (Mapper.checkCanLoopList(sourceCities) && Mapper.checkCanLoopList(phrases)){

      for (final Phrase phrase in phrases){

        for (final CityModel city in sourceCities){

          if (city.phrases.contains(phrase)){

            if (!_foundCities.contains(city)){
              _foundCities.add(city);

            }

          }

        }

      }

    }

    return _foundCities;
  }
  // --------------------
  /// DEPRECATED
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

        _city = await ZoneProtocols.fetchCity(
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
            _foundCities = await oldFireSearchCitiesByCityName(
              cityName: cityName,
              lingoCode: langCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await oldSearchCitiesByCityNameAndCountryID(
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

  /// OLD FIRE SEARCH : TASK : DELETE WHEN TAMAM

  // --------------------
    /// DEPRECATED
  /*
  Future<List<CountryModel>> countriesModelsByCountryNameX({
    @required String countryName,
    @required String lingoCode
  }) async {

    List<CountryModel> _countries = <CountryModel>[];

    if (countryName != null && countryName.isNotEmpty) {

      final List<Map<String, dynamic>> _result = await Search.subCollectionMapsByFieldValue(
        collName: FireColl.zones,
        docName: FireDoc.zones_countries,
        subCollName: FireSubColl.zones_countries_countries,
        field: 'phrases.$lingoCode.trigram',
        compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
          input: TextMod.fixCountryName(countryName),
          numberOfChars: Standards.maxTrigramLength,
        ),
        valueIs: FireComparison.arrayContains,
      );

      if (Mapper.checkCanLoopList(_result)) {
        _countries = CountryModel.decipherCountriesMaps(
          maps: _result,
        );
      }

    }

    return _countries;
  }
   */
  // --------------------
  /// DEPRECATED
  static Future<List<CityModel>> oldFireSearchCitiesByCityName({
    @required String cityName,
    @required String lingoCode,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    // if (cityName != null && cityName.isNotEmpty) {
    //
    //   final List<Map<String, dynamic>> _result = await Search.subCollectionMapsByFieldValue(
    //     collName: FireColl.zones,
    //     docName: FireDoc.zones_cities,
    //     subCollName: FireSubColl.zones_cities_cities,
    //     field: 'names.$lingoCode.trigram',
    //     compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
    //       input: TextMod.fixCountryName(cityName),
    //       numberOfChars: Standards.maxTrigramLength,
    //     ),
    //     valueIs: FireComparison.arrayContains,
    //   );
    //
    //   if (Mapper.checkCanLoopList(_result) == true) {
    //     _cities = CityModel.decipherCitiesMaps(
    //       maps: _result,
    //       fromJSON: false,
    //
    //     );
    //   }
    // }

    return _cities;
  }
// --------------------
  /// DEPRECATED
  static Future<List<CityModel>> oldSearchCitiesByCityNameAndCountryID({
    @required String cityName,
    @required String countryID,
    @required String lingoCode,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    await tryAndCatch(
        invoker: 'mapsByTwoValuesEqualTo',
        functions: () async {

          // final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
          //   collName: FireColl.zones,
          //   docName: FireDoc.zones_cities,
          //   subCollName: FireSubColl.zones_cities_cities,
          // );
          //
          // final String _searchValue =
          // TextMod.removeAllCharactersAfterNumberOfCharacters(
          //   input: TextMod.fixCountryName(cityName),
          //   numberOfChars: Standards.maxTrigramLength,
          // );
          //
          // final QuerySnapshot<Object> _collectionSnapshot = await _collRef
          //     .where('countryID', isEqualTo: countryID)
          //     .where('names.$lingoCode.trigram', arrayContains: _searchValue)
          //     .get();
          //
          // final List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
          //   querySnapshot: _collectionSnapshot,
          //   addDocsIDs: false,
          //   addDocSnapshotToEachMap: false,
          // );
          //
          // _cities = CityModel.decipherCitiesMaps(maps: _maps, fromJSON: false);

        });

    return _cities;
  }
  // -----------------------------------------------------------------------------
}
