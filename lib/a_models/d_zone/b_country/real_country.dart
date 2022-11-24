import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:flutter/material.dart';

@immutable
class RealCountry {
  /// --------------------------------------------------------------------------
  const RealCountry({
    @required this.id,
    @required this.citiesIDs,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final ZoneLevel citiesIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TASK : TEST ME
  RealCountry copyWith({
    String id,
    ZoneLevel citiesIDs,
    List<Phrase> phrases,
    int internetUsers,
    double gdp,
  }) {
    return RealCountry(
      id: id ?? this.id,
      citiesIDs: citiesIDs ?? this.citiesIDs,
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
    };
  }
  // --------------------
  /// TASK : TEST ME
  static RealCountry decipher(Map<String, dynamic> map){
    RealCountry _output;

    if (map != null) {

      _output = RealCountry(
        id: map['id'],
        citiesIDs: ZoneLevel.decipher(map['citiesIDs']),
      );
    }

    return _output;
  }
  // --------------------------------------------------------------------------
  void f(){}
}
