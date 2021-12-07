import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/region_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountryModel{
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
  final List<Name> names;
  final String currency;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return <String, dynamic>{
      'id' : id,
      'region' : region,
      'continent' : continent,
      'isActivated' : isActivated,
      'isGlobal' : isGlobal,
      'citiesIDs' : citiesIDs,
      'language' : language,
      'names': Name.cipherNames(names: names),
      'currency': currency,
    };
  }
// -----------------------------------------------------------------------------
  static CountryModel decipherCountryMap({@required Map<String, dynamic> map, @required bool fromJSON}){

    CountryModel _countryModel;

    if (map != null){
      final List<Name> _names = Name.decipherNames(map['names']);

      _countryModel = CountryModel(
        id : map['id'],
        names : _names,
        region : map['region'],
        continent : map['continent'],
        isActivated : map['isActivated'],
        isGlobal : map['isGlobal'],
        citiesIDs : Mapper.getStringsFromDynamics(dynamics: map['citiesIDs']),
        language : map['language'],
        currency: map['currency'],
      );

    }

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  static List<CountryModel> decipherCountriesMaps({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.canLoopList(maps)){

      for (final Map<String, dynamic> map in maps){
        _countries.add(decipherCountryMap(
          map: map,
          fromJSON: fromJSON,
        ));
      }

    }

    return _countries;
  }
// -----------------------------------------------------------------------------
  static String fixCountryName(String input){

    String _output;

    if (input != null){
      final String _countryNameTrimmed = TextMod.replaceAllCharactersWith(
        input: input.toLowerCase().trim(),
        characterToReplace: ' ',
        replacement: '_',
      );

      final String _countryNameTrimmed2 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed,
        characterToReplace: '-',
        replacement: '_',
      );

      final String _countryNameTrimmed3 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed2,
        characterToReplace: ',',
        replacement: '',
      );

      final String _countryNameTrimmed4 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed3,
        characterToReplace: '(',
        replacement: '',
      );

      final String _countryNameTrimmed5 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed4,
        characterToReplace: ')',
        replacement: '',
      );

      final String _countryNameTrimmed6 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed5,
        characterToReplace: '’',
        replacement: '',
      );

      final String _countryNameTrimmed7 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed6,
        characterToReplace: 'ô',
        replacement: 'o',
      );

      final String _countryNameTrimmed8 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed7,
        characterToReplace: '`',
        replacement: '',
      );

      final String _countryNameTrimmed9 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed8,
        characterToReplace: "\'",
        replacement: '',
      );

      final String _countryNameTrimmed10 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed9,
        characterToReplace: '.',
        replacement: '',
      );

      final String _countryNameTrimmed11 = TextMod.replaceAllCharactersWith(
        input: _countryNameTrimmed10,
        characterToReplace: '/',
        replacement: '',
      );

      _output = _countryNameTrimmed11;
    }

  return _output;
}
// -----------------------------------------------------------------------------
  static bool countriesIDsIncludeCountryID({@required List<String> countriesIDs, @required String countryID}){
    bool _includes = false;

    for (final String id in countriesIDs){

      if (id == countryID){
        _includes = true;
        break;
      }

    }

    return _includes;

  }
// -----------------------------------------------------------------------------
  static String getTranslatedCountryNameByID({@required BuildContext context, @required String countryID}){
    String _countryName = '...';

    if (countryID != null){
      _countryName = Localizer.translate(context, countryID);
    }

    return _countryName;
  }
// -----------------------------------------------------------------------------
  static List<String> getCountriesIDsOfContinent(Continent continent){

    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions){
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }
// -----------------------------------------------------------------------------
  static List<String> getAllCountriesIDs(){
    final List<String> _ids = <String>[];

    for (final Flag flag in Flag.allFlags){
      _ids.add(flag.countryID);
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static List<MapModel> getAllCountriesNamesMapModels(BuildContext context){

    final List<MapModel> _mapModels = <MapModel>[];

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    for (final String id in _allCountriesIDs){

      final String _countryName = getTranslatedCountryNameByID(context: context, countryID: id);

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
  void printCountry({String methodName = 'PRINTING COUNTRY'}){

    print('${methodName} ------------------------------------------- START');

    print('id : ${id}');
    print('region : ${region}');
    print('continent : ${continent}');
    print('isActivated : ${isActivated}');
    print('isGlobal : ${isGlobal}');
    print('citiesIDs : ${citiesIDs}');
    print('language : ${language}');
    print('names : ${names}');


    print('${methodName} ------------------------------------------- END');

  }
// -----------------------------------------------------------------------------
  static bool countriesAreTheSame(CountryModel countryA, CountryModel countryB){
    bool _areTheSame = false;

    if (countryA != null && countryB != null){
      if (countryA.id == countryB.id){
        _areTheSame = true;
      }
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
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
