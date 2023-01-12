import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class ZoneSearchOps {
  // -----------------------------------------------------------------------------

  const ZoneSearchOps();

  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// COSMIC SEARCH

  // --------------------
  /// I GUESS NO NEED FOR THIS GODZILLA
  static Future<List<Phrase>> searchTheCosmos({
    @required String text,
  }) async {

    final List<Phrase> _countriesByIDs = ZoneProtocols.searchCountriesByIDFromAllFlags(
      text: text,
    );

    List<Phrase> _countriesByName;
    List<Phrase> _citiesByID;
    List<Phrase> _citiesByName;
    List<Phrase> _districtsByID;
    List<Phrase> _districtsByName;

    await Future.wait(<Future>[

      /// COUNTRIES BY NAME
      ZoneProtocols.searchCountriesByNameFromLDBFlags(
        text: text,
      ).then((value) => _countriesByName = value),

      /// CITIES BY ID
      ZoneProtocols.searchCitiesOfPlanetByIDFromFire(
        text: text,
      ).then((value) => _citiesByID = value),

      /// CITIES BY NAME
      ZoneProtocols.searchCitiesOfPlanetByNameFromFire(
        text: text,
      ).then((value) => _citiesByName = value),

      /// DISTRICTS BY ID
      ZoneProtocols.searchDistrictsOfPlanetByIDFromFire(
        text: text,
      ).then((value) => _districtsByID = value),

      /// DISTRICTS BY NAME
      ZoneProtocols.searchDistrictOfPlanetByNameFromFire(
        text: text,
      ).then((value) => _districtsByName = value),

    ]);

    return <Phrase>[
      ...?_countriesByIDs,
      ...?_countriesByName,
      ...?_citiesByID,
      ...?_citiesByName,
      ...?_districtsByID,
      ...?_districtsByName,
    ];
  }
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
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
      langCode: TextCheck.concludeEnglishOrArabicLang(text),
      searchValue: text,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps,);
    }

    final List<Phrase> _cleaned = Phrase.cleanDuplicateIDs(
      phrases: _phrases,
    );

    return _cleaned;
  }
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

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

  /// CITY SEARCH FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> searchFetchCityByName({
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
        );

      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities = await _searchLDBCitiesByName(
          cityName: cityName,
          langCode: langCode,
        );

        /// C - trial 3 search firebase if no result found in LDB
        if (Mapper.checkCanLoopList(_foundCities) == false){

          /// C-1 - trial 3 if countryID is not available
          if (countryID == null){
            _foundCities = await _fetchCitiesByCityName(
              cityName: cityName,
              lingoCode: langCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await _fetchCitiesOfCountryByCityName(
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

          // blog('aho fetchCityByName : _foundCities.length = ${_foundCities.length}');

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> _fetchCitiesByCityName({
    @required String cityName,
    @required String lingoCode,
  }) async {

    List<CityModel> _cities = <CityModel>[];

    if (cityName != null && cityName.isNotEmpty) {

      final List<Phrase> _phrases = await searchCitiesOfPlanetByNameFromFire(
        text: cityName,
        // limit: 10,
      );

      if (Mapper.checkCanLoopList(_phrases) == true) {

        final List<String> _citiesIDs = Phrase.getPhrasesIDs(_phrases);

        _cities = await ZoneProtocols.fetchCities(
          citiesIDs: _citiesIDs,
        );

      }
    }

    return _cities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> _fetchCitiesOfCountryByCityName({
    @required String cityName,
    @required String countryID,
    @required String lingoCode,
  }) async {
    List<CityModel> _cities = <CityModel>[];

    if (cityName != null && cityName.isNotEmpty) {

      final List<Phrase> _phrases = await searchCitiesOfCountryByNameFromFire(
        text: cityName,
        countryID: countryID,
        // limit: 10,
      );

      if (Mapper.checkCanLoopList(_phrases) == true) {

        final List<String> _citiesIDs = Phrase.getPhrasesIDs(_phrases);

        _cities = await ZoneProtocols.fetchCitiesOfCountryByIDs(
          citiesIDsOfThisCountry: _citiesIDs,
        );

      }
    }

    return _cities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> _searchLDBCitiesByName({
    @required String cityName,
    @required String langCode,
  }) async {

    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      langCode: langCode,
    );

    final List<CityModel> _foundCities = CityModel.decipherCities(
      maps: _foundMaps,
      fromJSON: true,
      fromLDB: true,
    );

    return _foundCities;
  }
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchDistrictsOfPlanetByIDFromFire({
    @required String text,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchDistrictOfPlanetByNameFromFire({
    @required String text,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT : NO NEED REALLY
  static Future<List<Phrase>> searchDistrictsOfCountryByIDFromFire({
    @required String text,
    @required String countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchDistrictsOfCountryByNameFromFire({
    @required String text,
    @required String countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
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

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF CITY

  // --------------------
  /// TESTED : WORKS PERFECT : NO NEED REALLY
  static Future<List<Phrase>> searchDistrictsOfCityByIDFromFire({
    @required String text,
    @required String cityID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final String _countryID = CityModel.getCountryIDFromCityID(cityID);

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: _countryID),
          FireFinder(field: 'cityID', comparison: FireComparison.equalTo, value: cityID),
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchDistrictsOfCityByNameFromFire({
    @required String text,
    @required String cityID,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final String _countryID = CityModel.getCountryIDFromCityID(cityID);

    final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        collRef: Fire.getCollectionRef(FireColl.phrases_districts),
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: _countryID),
          FireFinder(field: 'cityID', comparison: FireComparison.equalTo, value: cityID),
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------
}
