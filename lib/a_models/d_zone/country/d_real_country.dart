import 'package:bldrs/a_models/d_zone/zoning/a_zone_level.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:flutter/material.dart';

class RealCountryModel {
  /// --------------------------------------------------------------------------
  const RealCountryModel({
    @required this.id,
    @required this.citiesIDs,
    @required this.internetUsers,
    @required this.gdp, // in Millions
  });
  /// --------------------------------------------------------------------------
  final String id;
  final ZoneLevel citiesIDs;
  final int internetUsers;
  final double gdp;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TASK : TEST ME
  RealCountryModel copyWith({
    String id,
    ZoneLevel citiesIDs,
    List<Phrase> phrases,
    int internetUsers,
    double gdp,
  }) {
    return RealCountryModel(
      id: id ?? this.id,
      citiesIDs: citiesIDs ?? this.citiesIDs,
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
      'citiesIDs': citiesIDs.toMap(),
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
        citiesIDs: ZoneLevel.decipher(map['citiesIDs']),
        internetUsers: map['internetUsers'],
        gdp: map['gdp'],
      );
    }

    return _output;
  }
  // --------------------------------------------------------------------------
  void f(){}
}
