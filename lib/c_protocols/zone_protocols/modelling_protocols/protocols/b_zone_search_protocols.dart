import 'package:basics/bldrs_theme/assets/planet/all_flags_list.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:fire/super_fire.dart';
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
    required String text,
  }) async {

    final List<Phrase>? _countriesByIDs = ZoneProtocols.searchCountriesByIDFromAllFlags(
      text: text,
    );

    List<Phrase>? _countriesByName;
    List<Phrase>? _citiesByID;
    List<Phrase>? _citiesByName;

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

    ]);

    return <Phrase>[
      ...?_countriesByIDs,
      ...?_countriesByName,
      ...?_citiesByID,
      ...?_citiesByName,
    ];
  }
  // -----------------------------------------------------------------------------
  /// ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  // -----------------------------------------------------------------------------

  /// COUNTRIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchCountriesByIDFromAllFlags({
    required String? text,
  }) {
    final List<Phrase> _output = <Phrase>[];

    final bool _textIsEng = TextCheck.textIsEnglish(text?.trim());

    if (_textIsEng == true) {
      for (final Flag flag in allFlags) {
        if (text?.trim().toLowerCase() == flag.id.toLowerCase()) {
          final Phrase? _phrase = Phrase.searchFirstPhraseByLang(
            phrases: flag.phrases,
            langCode: 'en',
          );

          if (_phrase != null){
            _output.add(_phrase);
          }

        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchCountriesByISO2FromAllFlags({
    required String? text,
  }) {
    final List<Phrase> _output = <Phrase>[];

    final bool _textIsEng = TextCheck.textIsEnglish(text?.trim());

    if (_textIsEng == true) {
      for (final Flag flag in allFlags) {
        if (text?.trim().toLowerCase() == flag.iso2.toLowerCase()) {
          final Phrase? _phrase = Phrase.searchFirstPhraseByLang(
            phrases: flag.phrases,
            langCode: 'en',
          );

          if (_phrase != null){
            _output.add(_phrase);
          }

        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCountriesByNameFromLDBFlags({
    required String? text,
  }) async {
    List<Phrase> _phrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
      docName: LDBDoc.countriesPhrases,
      langCode: TextCheck.concludeEnglishOrArabicLang(text),
      searchValue: text,
    );

    if (Lister.checkCanLoop(_maps) == true) {
      _phrases = Phrase.decipherMixedLangPhrasesFromMaps(
        maps: _maps,
      );
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
    required String? text,
    int limit = 10,
    QueryDocumentSnapshot<Object>? startAfter,
  }) async {
    final List<Map<String, dynamic>?>? _maps = await Fire.readColl(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        coll: FireColl.phrases_cities,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfPlanetByNameFromFire({
    required String? text,
    int limit = 10,
    QueryDocumentSnapshot<Object>? startAfter,
  }) async {
    final List<Map<String, dynamic>?>? _maps = await Fire.readColl(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        coll: FireColl.phrases_cities,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
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
    required String? text,
    required String countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object>? startAfter,
  }) async {
    final List<Map<String, dynamic>> _maps = await Fire.readColl(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        coll: FireColl.phrases_cities,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: countryID),
          FireFinder(field: 'id', comparison: FireComparison.equalTo, value: text),
        ],
      ),
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
    );

    final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(maps: _maps);

    return Phrase.cleanDuplicateIDs(phrases: _phrases);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchCitiesOfCountryByNameFromFire({
    required String? text,
    required String? countryID,
    int limit = 10,
    QueryDocumentSnapshot<Object>? startAfter,
  }) async {
    final List<Map<String, dynamic>> _maps = await Fire.readColl(
      queryModel: FireQueryModel(
        // idFieldName: 'id', // DEFAULT
        coll: FireColl.phrases_cities,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: countryID),
          FireFinder(field: 'trigram', comparison: FireComparison.arrayContains, value: text),
        ],
      ),
      startAfter: startAfter,
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
    required BuildContext context,
    required List<CityModel> sourceCities,
    required String? inputText,
    List<String> langCodes = const <String>['en', 'ar'],
  }) {
    /// CREATE PHRASES LIST
    final List<Phrase> _citiesPhrases = <Phrase>[];

    /// ADD ALL MIXED LANG PHRASES IN THE LIST
    for (final String langCode in langCodes) {
      for (final CityModel city in sourceCities) {
        final Phrase? _cityPhrase = Phrase.searchPhraseByIDAndLangCode(
          phid: city.cityID,
          langCode: langCode,
          phrases: city.phrases,
        );

        if (_cityPhrase != null){
          _citiesPhrases.add(_cityPhrase);
        }

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
        sourceCities: sourceCities,
    );

    // CityModel.blogCities(_foundCities);

    return _foundCities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> _getCitiesFromPhrases({
    required List<Phrase> phrases,
    required List<CityModel> sourceCities,
  }) {
    final List<CityModel> _foundCities = <CityModel>[];

    if (Lister.checkCanLoop(sourceCities) && Lister.checkCanLoop(phrases)) {
      for (final Phrase phrase in phrases) {
        for (final CityModel city in sourceCities) {

          if (Lister.checkCanLoop(phrases) == true){
            if (city.phrases!.contains(phrase) == true) {
              if (!_foundCities.contains(city) == true) {
                _foundCities.add(city);
              }
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
  static Future<CityModel?> searchFetchCityByName({
    required String? cityName,
    required String? langCode,
    required String? countryID,
  }) async {
    CityModel? _city;

    if (TextCheck.isEmpty(cityName) == false) {
      /// A - trial 1 : search by generated cityID
      if (countryID != null) {
        final String? _cityID = CityModel.createCityID(
          countryID: countryID,
          cityEnName: cityName,
        );

        _city = await ZoneProtocols.fetchCity(
          cityID: _cityID,
        );
      }

      /// B - when trial 1 fails
      if (_city == null) {
        List<CityModel> _foundCities = await _searchLDBCitiesByName(
          cityName: cityName,
          langCode: langCode,
        );

        /// C - trial 3 search firebase if no result found in LDB
        if (Lister.checkCanLoop(_foundCities) == false) {
          /// C-1 - trial 3 if countryID is not available
          if (countryID == null) {
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
        if (Lister.checkCanLoop(_foundCities) == true) {
          // blog('aho fetchCityByName : _foundCities.length = ${_foundCities.length}');

          /// D-1 if only one city found
          if (_foundCities.length == 1) {
            _city = _foundCities[0];
          }

          /// D-2 if multiple cities found
          else {
            final CityModel? _selectedCity = await Dialogs.confirmCityDialog(
              cities: _foundCities,
            );

            if (_selectedCity != null) {
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
    required String? cityName,
    required String? lingoCode,
  }) async {
    List<CityModel> _cities = <CityModel>[];

    if (cityName != null && cityName.isNotEmpty) {
      final List<Phrase> _phrases = await searchCitiesOfPlanetByNameFromFire(
        text: cityName,
        // limit: 10,
      );

      if (Lister.checkCanLoop(_phrases) == true) {
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
    required String? cityName,
    required String? countryID,
    required String? lingoCode,
  }) async {
    List<CityModel> _cities = <CityModel>[];

    if (cityName != null && cityName.isNotEmpty) {
      final List<Phrase> _phrases = await searchCitiesOfCountryByNameFromFire(
        text: cityName,
        countryID: countryID,
        // limit: 10,
      );

      if (Lister.checkCanLoop(_phrases) == true) {
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
    required String? cityName,
    required String? langCode,
  }) async {
    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      searchField: 'phrases.$langCode.trigram',
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.cities),
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
}
