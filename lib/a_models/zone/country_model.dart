import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/region_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
@immutable
class CountryModel {
  /// --------------------------------------------------------------------------
  const CountryModel({
    @required this.id,
    @required this.region,
    @required this.continent,
    @required this.isActivated,
    @required this.isGlobal,
    @required this.citiesIDs,
    @required this.language,
    @required this.currency,
    @required this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String region;
  final String continent;

  /// manual dashboard switch to deactivate an entire country
  final bool isActivated;

  /// automatic switch when country reaches 'Global target' ~ 10'000 flyers
  /// then country flyers will be visible to other countries users 'bzz & users'
  final bool isGlobal;
  final List<String> citiesIDs;
  final String language;
  final String currency;
  /// mixed languages country names
  final List<Phrase> phrases;
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  CountryModel copyWith({
    String id,
    String region,
    String continent,
    bool isActivated,
    bool isGlobal,
    List<String> citiesIDs,
    String language,
    String currency,
    List<Phrase> phrases,
  }){
    return CountryModel(
      id: id ?? this.id,
      region: region ?? this.region,
      continent: continent ?? this.continent,
      isActivated: isActivated ?? this.isActivated,
      isGlobal: isGlobal ?? this.isGlobal,
      citiesIDs: citiesIDs ?? this.citiesIDs,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      phrases: phrases ?? this.phrases,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      'region': region,
      'continent': continent,
      'isActivated': isActivated,
      'isGlobal': isGlobal,
      'citiesIDs': citiesIDs,
      'language': language,
      'currency': currency,
      'phrases' : cipherZonePhrases(
        phrases: phrases,
        toJSON: toJSON,
      ),
    };
  }
// -------------------------------------
  static CountryModel decipherCountryMap({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {

    CountryModel _countryModel;

    if (map != null) {

      _countryModel = CountryModel(
        id: map['id'],
        region: map['region'],
        continent: map['continent'],
        isActivated: map['isActivated'],
        isGlobal: map['isGlobal'],
        citiesIDs: Stringer.getStringsFromDynamics(dynamics: map['citiesIDs']),
        language: map['language'],
        currency: map['currency'],
        phrases: decipherZonePhrases(
          phrasesMap: map['phrases'],
          zoneID: map['id'],
        ),
      );
    }

    return _countryModel;
  }
// -------------------------------------
  static List<CountryModel> decipherCountriesMaps({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _countries.add(
            decipherCountryMap(
              map: map,
              fromJSON: fromJSON,
            )
        );
      }
    }

    return _countries;
  }
// -----------------------------------------------------------------------------

  /// COUNTRY PHRASES CYPHERS

// -------------------------------------
  /// phrases contain mixed languages phrases in one list
  static Map<String, dynamic> cipherZonePhrases({
    @required List<Phrase> phrases,
    @required bool toJSON,
  }){
    Map<String, dynamic> _output = {};

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _output = Mapper.insertPairInMap(
            map: _output,
            key: phrase.langCode,
            value: phrase.toMap(
              includeID: false,
              includeTrigram: toJSON,
              // includeLangCode: false,
            ),
        );

      }

    }

    return _output;
  }
// -------------------------------------
  static List<Phrase> decipherZonePhrases({
    @required Map<String, dynamic> phrasesMap,
    @required String zoneID,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (phrasesMap != null){

      final List<String> _keys = phrasesMap.keys.toList(); // lang codes

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          final Phrase _phrase = Phrase(
            id: zoneID,
            langCode: key,
            value: phrasesMap[key]['value'],
            trigram: Stringer.createTrigram(
                input: TextMod.fixCountryName(phrasesMap[key]['value']),
            ),
          );

          _output.add(_phrase);

        }

      }


    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool countriesIDsIncludeCountryID({
    @required List<String> countriesIDs,
    @required String countryID,
  }) {
    bool _includes = false;

    for (final String id in countriesIDs) {
      if (id == countryID) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool countriesIDsAreTheSame(CountryModel countryA, CountryModel countryB) {
    bool _areTheSame = false;

    if (countryA != null && countryB != null) {
      if (countryA.id == countryB.id) {
        _areTheSame = true;
      }
    }

    return _areTheSame;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool countriesAreIdentical(CountryModel countryA, CountryModel countryB) {
    bool _areTheSame = false;

    if (countryA != null && countryB != null) {
      if (
      countryA.id == countryB.id
      &&
      countryA.continent == countryB.continent
      &&
      countryA.region == countryB.region
      &&
      countryA.currency == countryB.currency
      &&
      countryA.language == countryB.language
      &&
      Phrase.phrasesListsAreIdentical(
          phrases1: countryA.phrases,
          phrases2: countryB.phrases,
      ) == true
      &&
      countryA.isActivated == countryB.isActivated
      &&
      countryA.isGlobal == countryB.isGlobal
      &&
      Mapper.checkListsAreIdentical(
          list1: countryA.citiesIDs,
          list2: countryB.citiesIDs
      ) == true
      ) {
        _areTheSame = true;
      }
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String getTranslatedCountryName({
    @required BuildContext context,
    @required String countryID
  }) {

    String _countryName = '...';

    if (countryID != null) {
      _countryName = Localizer.translate(context, countryID);
    }

    return _countryName;
  }
// -------------------------------------
  static List<String> getCountriesIDsOfContinent(Continent continent) {
    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions) {
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }
// -------------------------------------
  static List<String> getAllCountriesIDs() {
    final List<String> _ids = <String>[];

    for (final Flag flag in Flag.allFlags) {
      _ids.add(flag.countryID);
    }

    return _ids;
  }
// -------------------------------------
  static List<MapModel> getAllCountriesNamesMapModels(BuildContext context) {

    final List<MapModel> _mapModels = <MapModel>[];

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    for (final String id in _allCountriesIDs) {

      final String _countryName = getTranslatedCountryName(
          context: context,
          countryID: id,
      );

      _mapModels.add(
          MapModel(
            key: id,
            value: _countryName,
          )
      );

    }

    return _mapModels;
  }
// -------------------------------------
  static List<String> getAllCountriesIDsSortedByName(BuildContext context){

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    final List<Phrase> _allCountriesPhrasesInCurrentLang = <Phrase>[];

    for (final String id in _allCountriesIDs){

      final String _countryName = getTranslatedCountryName(
          context: context,
          countryID: id,
      );

      final Phrase _phrase = Phrase(
        id: id,
        value: _countryName,
      );

      if (_countryName != null){
        _allCountriesPhrasesInCurrentLang.add(_phrase);
      }
    }

    final List<Phrase> _namesSorted = Phrase.sortNamesAlphabetically(_allCountriesPhrasesInCurrentLang);

    final List<String> _sortedCountriesIDs = <String>[];

    for (final Phrase phrase in _namesSorted){

      _sortedCountriesIDs.add(phrase.id);

    }

    return _sortedCountriesIDs;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// -------------------------------------
  void blogCountry({String methodName = 'PRINTING COUNTRY'}) {
    blog('$methodName ------------------------------------------- START');

    blog('id : $id');
    blog('region : $region');
    blog('continent : $continent');
    blog('isActivated : $isActivated');
    blog('isGlobal : $isGlobal');
    blog('citiesIDs : $citiesIDs');
    Phrase.blogPhrases(phrases);
    blog('language : $language');

    blog('$methodName ------------------------------------------- END');
  }
// -------------------------------------
  static void blogCountries(List<CountryModel> countries){

    if (Mapper.checkCanLoopList(countries) == true){

      for (final CountryModel country in countries){

        country.blogCountry();

      }

    }

  }
// -----------------------------------------------------------------------------

  /// COUNTRY PHRASE CREATION

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> _createCountriesPhrasesByLangCode({
    @required String langCode,
    @required List<String> countriesIDs,
}) async {

    final List<Phrase> _output = <Phrase>[];
    final Map<String, String> _jsonMap = await Localizer.getJSONLangMap(
      langCode: langCode,
    );

    for (final String id in countriesIDs){

      final String _countryName = _jsonMap[id];

      final Phrase _phrase = Phrase(
        id: id,
        value: _countryName,
        langCode: langCode,
        trigram: Stringer.createTrigram(input: _countryName),
      );

      _output.add(_phrase);
    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> createMixedCountriesPhrases({
    @required List<String> langCodes,
    @required List<String> countriesIDs,
  }) async {

    final List<Phrase> _countriesPhrases = <Phrase>[];

    if (Mapper.checkCanLoopList(langCodes) == true){

      for (final String langCode in langCodes){
        final List<Phrase> _phrases = await _createCountriesPhrasesByLangCode(
          langCode: langCode,
          countriesIDs: countriesIDs,
        );
        _countriesPhrases.addAll(_phrases);
      }

    }

    return _countriesPhrases;
  }
}
// -----------------------------------------------------------------------------
@immutable
class AmericanState extends CountryModel {
  /// --------------------------------------------------------------------------
  const AmericanState({
    @required this.state,
    @required this.cities,
  });

  /// --------------------------------------------------------------------------
  final String state;
  final List<CityModel> cities;

  /// --------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
