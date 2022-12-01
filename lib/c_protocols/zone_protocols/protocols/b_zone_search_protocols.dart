import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZoneSearchOps {
  // -----------------------------------------------------------------------------

  const ZoneSearchOps();

  // -----------------------------------------------------------------------------

  /// COUNTRIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchCountriesByIDFromAllFlags({
    @required String text,
  }){
    final List<Phrase> _output = <Phrase>[];

    final bool _textIsEng = TextCheck.textIsEnglish(text?.trim());

    if (_textIsEng == true){

      for (final Flag flag in allFlags){

        if (text == flag.id){

          final Phrase _phrase = Phrase.searchFirstPhraseByLang(
            phrases: flag.phrases,
            langCode: 'en',
          );

          _output.add(_phrase);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCountriesByNameFromLDBFlags({
    @required String text,
  }) async {
    List<Phrase> _phrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
      docName: LDBDoc.countriesPhrases,
      lingCode: TextCheck.concludeEnglishOrArabicLang(text),
      searchValue: text,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      _phrases = Phrase.decipherMixedLangPhrases(maps: _maps,);
    }

    final List<Phrase> _cleaned = Phrase.cleanDuplicateIDs(
      phrases: _phrases,
    );

    return _cleaned;
  }
  // -----------------------------------------------------------------------------

  /// CITIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfPlanetByIDFromFire({
    @required String text,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_cities),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrases(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfPlanetByNameFromFire({
    @required String text,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_cities),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrases(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // -----------------------------------------------------------------------------

  /// CITIES OR COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfCountryByIDFromFire({
    @required String text,
    @required String countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_cities),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: countryID),
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrases(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfCountryByNameFromFire({
    @required String text,
    @required String countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_cities),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: countryID),
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrases(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // -----------------------------------------------------------------------------

  /// CITIES OF LIST

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> searchCitiesByNameFromCities({
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
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF PLANET

  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictsOfPlanetByIDFromFire({
    @required String districtID,
  }) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictOfPlanetByNameFromFire({
    @required String text,
  }) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF COUNTRY

  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictsOfCountryByIDFromFire({
    @required String text,
  }) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictsOfCountryByNameFromFire({
    @required String text,
  }) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF CITY

  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictsOfCityByIDFromFire({
    @required String text,
  }) async {
    return null;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<DistrictModel>> searchDistrictsOfCityByNameFromFire({
    @required String text,
  }) async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// OLD AND DEPRECATED : TASK : DELETE WHEN TAMAM

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

        final String _cityID = CityModel.oldCreateCityID(
          countryID: countryID,
          cityEnName: cityName,
        );

        _city = await ZoneProtocols.fetchCity(
          cityID: _cityID,
        );

      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities = await ZoneSearchOps.searchLDBCitiesByName(
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
          await CityLDBOps.insertCities(
            cities: _foundCities,
          );

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

  /// OLD LDB SEARCH

  // --------------------
  /// TASK : TEST ME
  static Future<List<CityModel>> searchLDBCitiesByName({
    @required String cityName,
    @required String langCode,
  }) async {

    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      lingoCode: langCode,
    );

    final List<CityModel> _foundCities = CityModel.decipherCities(
      maps: _foundMaps,

      fromJSON: true,
    );

    return _foundCities;
  }
  // --------------------
  void f(){}
  // -----------------------------------------------------------------------------
}
