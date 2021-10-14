import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
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
  Map<String, dynamic> toMap(){

    return {
      'countryID' : countryID,
      'region' : region,
      'continent' : continent,
      'flag' : flag,
      'isActivated' : isActivated,
      'isGlobal' : isGlobal,
      'cities' : CityModel.cipherCities(cities),
      'language' : language,
      'names': Name.cipherNames(names),
    };
  }
// -----------------------------------------------------------------------------
  static String createCountryKey({@required String countryID, @required List<Name> names}){
    final String _countryNameEN = Name.getNameByLingoFromNames(names: names, lingoCode: Lingo.englishCode);

    final String _fixedName = fixCountryName(_countryNameEN);

    print('createCountryKey : _countryNameTrimmed : $_fixedName');

    final String _countryID_name = '${countryID}_${_fixedName}';
    return _countryID_name;
  }
// -----------------------------------------------------------------------------
  static CountryModel decipherCountryMap(dynamic map){

    final List<Name> _names = Name.decipherNames(map['names']);

    return CountryModel(
      countryID : map['countryID'],
      names : _names,
      region : map['region'],
      continent : map['continent'],
      flag : map['flag'],
      isActivated : map['isActivated'],
      isGlobal : map['isGlobal'],
      cities : CityModel.decipherCitiesMap(map['cities']),
      language : map['language'],
    );
  }
// -----------------------------------------------------------------------------
  static List<CountryModel> decipherCountriesMaps(List<dynamic> maps){
    final List<CountryModel> _countries = <CountryModel>[];
    maps?.forEach((map) {
      _countries.add(decipherCountryMap(map));
    });
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

  return _countryNameTrimmed7;

}
// -----------------------------------------------------------------------------

}
