import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
// -----------------------------------------------------------------------------
class City{
  final String iso3;
  final String name; /// TASK : should delete this and get the name from names
  final List<District> districts;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Name> namez; // English

  City({
    this.iso3,
    this.name,
    this.districts,
    this.population,
    this.isActivated,
    this.isPublic,
    this.namez,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return {
      'iso3' : iso3,
      'name' : name,
      'areas' : District.cipherDistricts(districts), /// TASK should update field name areas to districts in firebase
      'population' : population,
      'isActivated' : isActivated,
      'isPublic' : isPublic,
      'namez' : Name.cipherNamezz(namez),
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherCities(List<City> cities){
    List<Map<String, dynamic>> _citiesMaps = new List();
    cities.forEach((pr) {
      _citiesMaps.add(pr.toMap());
    });
    return _citiesMaps;
  }
// -----------------------------------------------------------------------------
  static City decipherCityMap(Map<String, dynamic> map){
    return City(
      iso3 : map['iso3'],
      name : map['name'],
      districts : District.decipherDistrictsMaps(map['areas']),/// TASK should update field name areas to districts in firebase
      population : map['population'],
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
      namez : Name.decipherNamezzMaps(map['names']),
    );
  }
// -----------------------------------------------------------------------------
  static List<City> decipherCitiesMaps(List<dynamic> maps){
    List<City> _cities = new List();
    maps?.forEach((map) {
      _cities.add(decipherCityMap(map));
    });
    return _cities;
  }
// -----------------------------------------------------------------------------
  static List<String> getCitiesNamesFromCountryModel(Country country){
    List<String> _citiesNames = new List();

    List<City> _cities = country.cities;

    _cities.forEach((pr) {
      _citiesNames.add(pr.name);
    });

    _citiesNames = TextMod.sortAlphabetically(_citiesNames);

    return _citiesNames;
  }
// -----------------------------------------------------------------------------
  static Keyword getKeywordFromCity(BuildContext context, City city){

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    // String _name = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, city.name);

    Keyword _keyword = Keyword(
        keywordID: city.name,
        flyerType: FlyerType.non,
        groupID: city.iso3,
        subGroupID: null,
        // name: _name,
        uses: 0
    );

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsFromCities(BuildContext context, List<City> cities){
    List<Keyword> _keywords = new List();

    cities.forEach((city) {

      Keyword _cityKeyword = getKeywordFromCity(context, city);

      _keywords.add(_cityKeyword);

    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
}
