import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/zone_policy.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:flutter/material.dart';

class RealCountryModel {
  /// --------------------------------------------------------------------------
  const RealCountryModel({
    @required this.id,
    @required this.region,
    @required this.continent,
    @required this.citiesIDs,
    @required this.language,
    @required this.currencyID,
    @required this.phrases,
    @required this.iso2,
    @required this.phoneCode,
    @required this.capital,
    @required this.langCodes,
    @required this.areaSqKm,
    @required this.internetUsers,
    @required this.gdp, // in Millions
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String iso2;
  final String region;
  final String continent;
  final ZoneLevel citiesIDs;
  final String language;
  final String currencyID;
  final List<Phrase> phrases;
  final String phoneCode;
  final String capital;
  final String langCodes;
  final int areaSqKm;
  final int internetUsers;
  final double gdp;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TASK : TEST ME
  RealCountryModel copyWith({
    String id,
    String iso2,
    String region,
    String continent,
    ZoneLevel citiesIDs,
    String language,
    String currencyID,
    List<Phrase> phrases,
    String phoneCode,
    String capital,
    String langCodes,
    int areaSqKm,
    int internetUsers,
    double gdp,
  }) {
    return RealCountryModel(
      id: id ?? this.id,
      iso2: iso2 ?? this.iso2,
      region: region ?? this.region,
      continent: continent ?? this.continent,
      citiesIDs: citiesIDs ?? this.citiesIDs,
      language: language ?? this.language,
      currencyID: currencyID ?? this.currencyID,
      phrases: phrases ?? this.phrases,
      phoneCode: phoneCode ?? this.phoneCode,
      capital: capital ?? this.capital,
      langCodes: langCodes ?? this.langCodes,
      areaSqKm: areaSqKm ?? this.areaSqKm,
      internetUsers: internetUsers ?? this.internetUsers,
      gdp: gdp ?? this.gdp,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TASK : TEST ME
  Map<String, dynamic> toMap({
    @required bool includePhrasesTrigrams, /// is true in LDB
  }) {
    return {
      'id': id,
      'iso2': iso2,
      'region': region,
      'continent': continent,
      'citiesIDs': citiesIDs.toMap(),
      'language': language,
      'currencyID': currencyID,
      'phrases' : CountryModel.cipherZonePhrases(phrases: phrases, includeTrigram: includePhrasesTrigrams,),
      'phoneCode': phoneCode,
      'capital': capital,
      'langCodes': langCodes,
      'areaSqKm': areaSqKm,
      'internetUsers': internetUsers,
      'gdp': gdp,
    };
  }
  // --------------------
  /// TASK : TEST ME
  static RealCountryModel decipher(Map<String, dynamic> map){
    RealCountryModel _output;

    if (map != null) {

      _output = RealCountryModel(
        id: map['id'],
        region: map['region'],
        continent: map['continent'],
        citiesIDs: ZoneLevel.decipher(map['citiesIDs']),
        language: map['language'],
        currencyID: map['currencyID'],
        phrases: map['phrases'],
        iso2: map['iso2'],
        phoneCode: map['phoneCode'],
        capital: map['capital'],
        langCodes: map['langCodes'],
        areaSqKm: map['areaSqKm'],
        internetUsers: map['internetUsers'],
        gdp: map['gdp'],
      );
    }

    return _output;
  }
  // --------------------------------------------------------------------------
  void f(){}
}
