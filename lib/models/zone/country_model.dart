import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:flutter/foundation.dart';

class CountryModel{
  final String countryID;
  final String region;
  final String continent;
  final String flag;
  /// manual dashboard switch to deactivate an entire country
  final bool isActivated;
  /// automatic switch when country reaches 'Global target' ~ 10'000 flyers
  /// then country flyers will be visible to other countries users 'bzz & users'
  final bool isGlobal;
  final List<CityModel> cities;
  final String language;
  final List<Name> names;

  const CountryModel({
    @required this.countryID,
    @required this.region,
    @required this.continent,
    @required this.flag,
    @required this.isActivated,
    @required this.isGlobal,
    @required this.cities,
    @required this.language,
    @required this.names,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return {
      'countryID' : countryID,
      'region' : region,
      'continent' : continent,
      'flag' : flag,
      'isActivated' : isActivated,
      'isGlobal' : isGlobal,
      'cities' : CityModel.cipherCities(cities: cities, toJSON: toJSON),
      'language' : language,
      'names': Name.cipherNames(names),
    };
  }
// -----------------------------------------------------------------------------
  static CountryModel decipherCountryMap({@required Map<String, dynamic> map, @required bool fromJSON}){

    final List<Name> _names = Name.decipherNames(map['names']);

    return CountryModel(
      countryID : map['countryID'],
      names : _names,
      region : map['region'],
      continent : map['continent'],
      flag : map['flag'],
      isActivated : map['isActivated'],
      isGlobal : map['isGlobal'],
      cities : CityModel.decipherCitiesMap(map: map['cities'], fromJSON: fromJSON),
      language : map['language'],
    );
  }
// -----------------------------------------------------------------------------
  static List<CountryModel> decipherCountriesMaps({@required List<dynamic> maps, @required bool fromJSON}){
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.canLoopList(maps)){
      maps?.forEach((map) {
        _countries.add(decipherCountryMap(
          map: map,
          fromJSON: fromJSON,
        ));
      });
    }

    return _countries;
  }
// -----------------------------------------------------------------------------
static String fixCountryName(String input){

  final String _countryNameTrimmed = TextMod.replaceAllCharactersWith(
    input: input.toLowerCase().trim(),
    CharacterToReplace: ' ',
    replacement: '_',
  );

  final String _countryNameTrimmed2 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed,
    CharacterToReplace: '-',
    replacement: '_',
  );

  final String _countryNameTrimmed3 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed2,
    CharacterToReplace: ',',
    replacement: '',
  );

  final String _countryNameTrimmed4 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed3,
    CharacterToReplace: '(',
    replacement: '',
  );

  final String _countryNameTrimmed5 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed4,
    CharacterToReplace: ')',
    replacement: '',
  );

  final String _countryNameTrimmed6 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed5,
    CharacterToReplace: '’',
    replacement: '',
  );

  final String _countryNameTrimmed7 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed6,
    CharacterToReplace: 'ô',
    replacement: 'o',
  );

  final String _countryNameTrimmed8 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed7,
    CharacterToReplace: '`',
    replacement: '',
  );

  final String _countryNameTrimmed9 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed8,
    CharacterToReplace: '\'',
    replacement: '',
  );

  final String _countryNameTrimmed10 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed9,
    CharacterToReplace: '.',
    replacement: '',
  );

  final String _countryNameTrimmed11 = TextMod.replaceAllCharactersWith(
    input: _countryNameTrimmed10,
    CharacterToReplace: '/',
    replacement: '',
  );


  return _countryNameTrimmed11;
}
// -----------------------------------------------------------------------------

}

class AmericanState extends CountryModel {
  final String state;
  final List<CityModel> cities;

  AmericanState({
    @required this.state,
    @required this.cities,
});




}