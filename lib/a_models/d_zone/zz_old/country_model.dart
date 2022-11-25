import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

@immutable
class CountryModel {
  /// --------------------------------------------------------------------------
  const CountryModel({
    @required this.id,
    @required this.citiesIDs,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final ZoneLevel citiesIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CountryModel copyWith({
    String id,
    ZoneLevel citiesIDs,
  }){
    return CountryModel(
      id: id ?? this.id,
      citiesIDs: citiesIDs ?? this.citiesIDs,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'citiesIDs': citiesIDs?.toMap(),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CountryModel decipherCountryMap({
    @required Map<String, dynamic> map,
  }) {
    CountryModel _countryModel;

    if (map != null) {

      _countryModel = CountryModel(
        id: map['id'],
        citiesIDs: ZoneLevel.decipher(map['citiesIDs']),
      );
    }

    return _countryModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CountryModel> decipherCountriesMaps({
    @required List<Map<String, dynamic>> maps,
  }) {
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _countries.add(
            decipherCountryMap(
              map: map,
            )
        );
      }
    }

    return _countries;
  }
  // -----------------------------------------------------------------------------

  /// COUNTRY PHRASES CYPHERS

  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> oldCipherZonePhrases({
    @required List<Phrase> phrases,
    @required bool includeTrigram,
  }){

    /// phrases contain mixed languages phrases in one list

    Map<String, dynamic> _output = {};

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: phrase.langCode,
          value: phrase.toMap(
            includeID: false,
            includeTrigram: includeTrigram,
            // includeLangCode: false,
          ),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Phrase> oldDecipherZonePhrases({
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

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCountry({String invoker = 'PRINTING COUNTRY'}) {
    blog('$invoker ------------------------------------------- START');

    blog('  id : $id');
    citiesIDs?.blogLeveL();

    blog('$invoker ------------------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCountries(List<CountryModel> countries){

    if (Mapper.checkCanLoopList(countries) == true){

      for (final CountryModel country in countries){

        country.blogCountry();

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// COUNTRY PHRASE CREATION

  // --------------------
  /// DEPRECATED
  /*
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
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<List<Phrase>> createMixedCountriesPhrasesXX({
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
   */
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool countriesIDsAreIdentical(CountryModel country1, CountryModel country2) {
    bool _identical = false;

    if (country1 == null && country2 == null){
      _identical = true;
    }
    else if (country1 != null && country2 != null) {
      if (country1.id == country2.id) {
        _identical = true;
      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCountriesAreIdentical(CountryModel country1, CountryModel country2) {
    bool _identical = false;

    if (country1 == null && country2 == null){
      _identical = true;
    }
    else if (country1 != null && country2 != null) {
      if (
          country1.id == country2.id &&
          ZoneLevel.checkLevelsAreIdentical(country1.citiesIDs, country2.citiesIDs) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CountryModel){
      _areIdentical = checkCountriesAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      citiesIDs.hashCode;
  // -----------------------------------------------------------------------------
}

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
