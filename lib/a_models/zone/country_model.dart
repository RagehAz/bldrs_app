import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/region_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

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
    @required this.names,
    @required this.currency,
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
  final List<Phrase> names;
  final String currency;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}) {
    return <String, dynamic>{
      'id': id,
      'region': region,
      'continent': continent,
      'isActivated': isActivated,
      'isGlobal': isGlobal,
      'citiesIDs': citiesIDs,
      'language': language,
      'names': Phrase.cipherPhrases(phrases: names),
      'currency': currency,
    };
  }
// -----------------------------------------------------------------------------
  static CountryModel decipherCountryMap({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    CountryModel _countryModel;

    if (map != null) {
      final List<Phrase> _names = Phrase.decipherPhrases(map['names']);

      _countryModel = CountryModel(
        id: map['id'],
        names: _names,
        region: map['region'],
        continent: map['continent'],
        isActivated: map['isActivated'],
        isGlobal: map['isGlobal'],
        citiesIDs: Mapper.getStringsFromDynamics(dynamics: map['citiesIDs']),
        language: map['language'],
        currency: map['currency'],
      );
    }

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  static List<CountryModel> decipherCountriesMaps({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _countries.add(decipherCountryMap(
          map: map,
          fromJSON: fromJSON,
        ));
      }
    }

    return _countries;
  }

// ----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  static String getTranslatedCountryNameByID({
    @required BuildContext context,
    @required String countryID
  }) {

    String _countryName = '...';

    if (countryID != null) {
      _countryName = Localizer.translate(context, countryID);
    }

    return _countryName;
  }
// -----------------------------------------------------------------------------
  static List<String> getCountriesIDsOfContinent(Continent continent) {
    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions) {
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }
// -----------------------------------------------------------------------------
  static List<String> getAllCountriesIDs() {
    final List<String> _ids = <String>[];

    for (final Flag flag in Flag.allFlags) {
      _ids.add(flag.countryID);
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static List<MapModel> getAllCountriesNamesMapModels(BuildContext context) {

    final List<MapModel> _mapModels = <MapModel>[];

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    for (final String id in _allCountriesIDs) {

      final String _countryName = getTranslatedCountryNameByID(
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
// -----------------------------------------------------------------------------
  void blogCountry({String methodName = 'PRINTING COUNTRY'}) {
    blog('$methodName ------------------------------------------- START');

    blog('id : $id');
    blog('region : $region');
    blog('continent : $continent');
    blog('isActivated : $isActivated');
    blog('isGlobal : $isGlobal');
    blog('citiesIDs : $citiesIDs');
    blog('language : $language');
    blog('names : $names');

    blog('$methodName ------------------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static bool countriesAreTheSame(CountryModel countryA, CountryModel countryB) {
    bool _areTheSame = false;

    if (countryA != null && countryB != null) {
      if (countryA.id == countryB.id) {
        _areTheSame = true;
      }
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
  static List<String> getAllCountriesIDsSortedByName(BuildContext context){

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    final List<Phrase> _allCountriesNamesInCurrentLanguage = <Phrase>[];

    for (final String id in _allCountriesIDs){

      final String _countryName = getTranslatedCountryNameByID(context: context, countryID: id);

      final Phrase _name = Phrase(
          langCode: id,
          value: _countryName,
      );

      if (_countryName != null){
        _allCountriesNamesInCurrentLanguage.add(_name);
      }
    }

    final List<Phrase> _namesSorted = Phrase.sortNamesAlphabetically(_allCountriesNamesInCurrentLanguage);

    final List<String> _sortedCountriesIDs = <String>[];

    for (final Phrase name in _namesSorted){

      _sortedCountriesIDs.add(name.langCode);

    }

    return _sortedCountriesIDs;
  }


}

// -----------------------------------------------------------------------------
class AmericanState extends CountryModel {
  /// --------------------------------------------------------------------------
  AmericanState({
    @required this.state,
    @required this.cities,
  });

  /// --------------------------------------------------------------------------
  final String state;
  final List<CityModel> cities;

  /// --------------------------------------------------------------------------
}
