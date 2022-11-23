import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';


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
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
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
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap(){
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
    };
  }
  // --------------------
  ///
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
  ///
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
      );
    }

    return _iso3;
  }
  // --------------------
  ///
  static List<ISO3> decipherMaps(List<Map<String, dynamic>> maps){
    final List<ISO3> _iso3s = [];

    if (Mapper.checkCanLoopList(maps) == true){
      for (final Map<String, dynamic> map in maps){
        _iso3s.add(decipher(map));
      }
    }

    return _iso3s;
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
      for (final ISO3 iso3 in iso3s){
        blog(
            '{'
            '"id":"${iso3.id}",'
            '"iso2":"${iso3.iso2}",'
            '"flag":"${iso3.flag}",'
            '"region":"${iso3.region}",'
            '"continent":"${iso3.continent}",'
            '"language":"${iso3.language}",'
            '"currencyID":"${iso3.currencyID}",'
            '"phoneCode":"${iso3.phoneCode}",'
            '"capital":"${iso3.capital}",'
            '"langCodes":"${iso3.langCodes}",'
            '"areaSqKm":${iso3.areaSqKm}'
            '},'
        );

      }
    }
  }

  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  ///
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
      iso1.areaSqKm == iso2.areaSqKm
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
      areaSqKm.hashCode;
  // -----------------------------------------------------------------------------
}
