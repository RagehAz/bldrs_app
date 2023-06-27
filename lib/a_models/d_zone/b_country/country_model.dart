import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class CountryModel {
  /// --------------------------------------------------------------------------
  const CountryModel({
    required this.id,
    required this.citiesIDs,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final StagingModel citiesIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CountryModel copyWith({
    String? id,
    StagingModel? citiesIDs,
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
  Map<String, dynamic> toMap({
    required bool toLDB,
  }) {
    return <String, dynamic>{
      'id': id,
      'citiesIDs': citiesIDs?.toMap(
        toLDB: toLDB,
      ),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CountryModel decipherCountryMap({
    required Map<String, dynamic> map,
  }) {
    CountryModel _countryModel;

    if (map != null) {

      _countryModel = CountryModel(
        id: map['id'],
        citiesIDs: StagingModel.decipher(
          id: map['id'],
          map: map['citiesIDs'],
        ),
      );
    }

    return _countryModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CountryModel> decipherCountriesMaps({
    required List<Map<String, dynamic>> maps,
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

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCountry({String invoker = 'PRINTING COUNTRY'}) {
    blog('$invoker ------------------------------------------- START');

    blog('  id : $id');
    citiesIDs?.blogStaging();

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
          StagingModel.checkStagingsAreIdentical(country1.citiesIDs, country2.citiesIDs) == true
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
    required this.state,
    required this.cities,
  });
  /// --------------------------------------------------------------------------
  final String state;
  final List<CityModel> cities;
  /// --------------------------------------------------------------------------
}
