import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

@immutable
class ISO3 {
  // --------------------------------------------------------------------------
  /// THIS CLASS IS USED TO STORE CONSTANT COUNTRY DATA
  // --------------------------------------------------------------------------
  const ISO3({
    @required this.id,
    @required this.iso2,
    @required this.flag,
    @required this.region,
    @required this.continent,
    @required this.language,
    @required this.currencyID,
    @required this.phoneCode,
    @required this.capital,
    @required this.langCodes,
    @required this.areaSqKm,
    @required this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String iso2;
  final String flag;
  final String region;
  final String continent;
  final String language;
  final String currencyID;
  final String phoneCode;
  final String capital;
  final String langCodes;
  final int areaSqKm;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ISO3 copyWith({
    String id,
    String iso2,
    String flag,
    String region,
    String continent,
    String language,
    String currencyID,
    String phoneCode,
    String capital,
    String langCodes,
    int areaSqKm,
    List<Phrase> phrases,
  }){
    return ISO3(
      id: id ?? this.id,
      iso2: iso2 ?? this.iso2,
      flag: flag ?? this.flag,
      region: region ?? this.region,
      continent: continent ?? this.continent,
      language: language ?? this.language,
      currencyID: currencyID ?? this.currencyID,
      phoneCode: phoneCode ?? this.phoneCode,
      capital: capital ?? this.capital,
      langCodes: langCodes ?? this.langCodes,
      areaSqKm: areaSqKm ?? this.areaSqKm,
      phrases: phrases ?? this.phrases,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    blog('.');
    return {
      'id': id,
      'iso2': iso2,
      'flag': flag,
      'region': region,
      'continent': continent,
      'language': language,
      'currencyID': currencyID,
      'phoneCode': phoneCode,
      'capital': capital,
      'langCodes': langCodes,
      'areaSqKm': areaSqKm,
      'phrases': CountryModel.cipherZonePhrases(
        phrases: phrases,
        includeTrigram: false,
      ),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherISO3s(List<ISO3> iso3s){
    final List<Map<String, dynamic>> _maps = [];

    if (Mapper.checkCanLoopList(iso3s) == true){
      for (final ISO3 iso3 in iso3s){
        _maps.add(iso3.toMap());
      }
    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ISO3 decipher(Map<String, dynamic> map){
    ISO3 _iso3;

    if (map != null){
      _iso3 = ISO3(
        id: map['id'],
        iso2: map['iso2'],
        flag: map['flag'],
        region: map['region'],
        continent: map['continent'],
        language: map['language'],
        currencyID: map['currencyID'],
        phoneCode: map['phoneCode'],
        capital: map['capital'],
        langCodes: map['langCodes'],
        areaSqKm: map['areaSqKm'],
        phrases: CountryModel.decipherZonePhrases(
          phrasesMap: map['phrases'],
          zoneID: map['id'],
        ),
      );
    }

    return _iso3;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ISO3> decipherMaps(List<dynamic> maps){
    final List<ISO3> _iso3s = [];

    if (Mapper.checkCanLoopList(maps) == true){
      for (final dynamic map in maps){
        _iso3s.add(decipher(map));
      }
    }

    return _iso3s;
  }
  // -----------------------------------------------------------------------------

  /// JSON GETTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<ISO3>> readAllISO3s() async {
    final String _jsonStringValues = await rootBundle.loadString('assets/planet/iso3.json');
    final List<dynamic> _mappedJson = json.decode(_jsonStringValues);
    return decipherMaps(_mappedJson);
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogISO3(){
    blog('ISO3(');
    blog('  id: $id,');
    blog('  iso2: $iso2,');
    blog('  flag: $flag,');
    blog('  region: $region,');
    blog('  continent: $continent,');
    blog('  language: $language,');
    blog('  currencyID: $currencyID,');
    blog('  phoneCode: $phoneCode,');
    blog('  capital: $capital,');
    blog('  langCodes: $langCodes,');
    blog('  areaSqKm: $areaSqKm,');
    blog(')');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogISO3s(List<ISO3> iso3s){
    if (Mapper.checkCanLoopList(iso3s) == true){
      for (final ISO3 iso3 in iso3s){
        iso3.blogISO3();
      }
    }
  }
  // --------------------

  /// TESTED : WORKS PERFECT
  static void blogISO3sToJSON(List<ISO3> iso3s){
    if (Mapper.checkCanLoopList(iso3s) == true){
      blog('[\n');
      for (int i = 0; i < iso3s.length; i++){

        final ISO3 iso3 = iso3s[i];
        final bool lastItem = i == iso3s.length - 1;

        String _string = '{\n'
            '"id":"${iso3.id}",\n'
            '"iso2":"${iso3.iso2}",\n'
            '"flag":"${iso3.flag}",\n'
            '"region":"${iso3.region}",\n'
            '"continent":"${iso3.continent}",\n'
            '"language":"${iso3.language}",\n'
            '"currencyID":"${iso3.currencyID}",\n'
            '"phoneCode":"${iso3.phoneCode}",\n'
            '"capital":"${iso3.capital}",\n'
            '"langCodes":"${iso3.langCodes}",\n'
            '"areaSqKm":${iso3.areaSqKm},\n'
            '"phrases":${blogPhrasesToJSON(iso3.phrases)}\n'
            '}';

        if (lastItem == false){
          _string = '$_string,';
        }

        blog(_string);

      }
      blog(']');
    }
  }

  static String blogPhrasesToJSON(List<Phrase> phrases){
    String _output = '[\n';

    if (Mapper.checkCanLoopList(phrases) == true) {

      for (int i = 0; i < phrases.length; i++) {

        final Phrase phrase = phrases[i];
        final bool _isLast = i + 1 == phrases.length;

        if (_isLast == false){
          _output = '$_output{"id":"${phrase.id}","langCode":"${phrase.langCode}","value":"${phrase.value}"},\n';
        }
        else {
          /// remove last comma
          _output = '$_output{"id":"${phrase.id}","langCode":"${phrase.langCode}","value":"${phrase.value}"}\n';
        }

      }

  }

    return '$_output]';
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkISO3sAreIdentical(ISO3 iso1, ISO3 iso2){
    bool _identical = false;

    if (iso1 == null && iso2 == null){
      _identical = true;
    }

    else if (iso1 != null && iso2 != null) {
      if (
      iso1.id == iso2.id &&
      iso1.iso2 == iso2.iso2 &&
      iso1.flag == iso2.flag &&
      iso1.region == iso2.region &&
      iso1.continent == iso2.continent &&
      iso1.language == iso2.language &&
      iso1.currencyID == iso2.currencyID &&
      iso1.phoneCode == iso2.phoneCode &&
      iso1.capital == iso2.capital &&
      iso1.langCodes == iso2.langCodes &&
      iso1.areaSqKm == iso2.areaSqKm &&
      Phrase.checkPhrasesListsAreIdentical(phrases1: iso1.phrases, phrases2: iso2.phrases,) == true
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
    if (other is ISO3){
      _areIdentical = checkISO3sAreIdentical(
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
      iso2.hashCode^
      flag.hashCode^
      region.hashCode^
      continent.hashCode^
      language.hashCode^
      currencyID.hashCode^
      phoneCode.hashCode^
      capital.hashCode^
      langCodes.hashCode^
      areaSqKm.hashCode^
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
