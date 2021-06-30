import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'area_model.dart';
import 'country_model.dart';
import 'namez_model.dart';
// -----------------------------------------------------------------------------
class Province{
  final String iso3;
  final String name;
  final List<Area> areas;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Namez> namez; // English

  Province({
    this.iso3,
    this.name,
    this.areas,
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
      'areas' : Area.cipherAreas(areas),
      'population' : population,
      'isActivated' : isActivated,
      'isPublic' : isPublic,
      'namez' : Namez.cipherNamezz(namez),
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherProvinces(List<Province> provinces){
    List<Map<String, dynamic>> _provincesMaps = new List();
    provinces.forEach((pr) {
      _provincesMaps.add(pr.toMap());
    });
    return _provincesMaps;
  }
// -----------------------------------------------------------------------------
  static Province decipherProvinceMap(Map<String, dynamic> map){
    return Province(
      iso3 : map['iso3'],
      name : map['name'],
      areas : Area.decipherAreasMaps(map['areas']),
      population : map['population'],
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
      namez : Namez.decipherNamezzMaps(map['names']),
    );
  }
// -----------------------------------------------------------------------------
  static List<Province> decipherProvincesMaps(List<dynamic> maps){
    List<Province> _provinces = new List();
    maps?.forEach((map) {
      _provinces.add(decipherProvinceMap(map));
    });
    return _provinces;
  }
// -----------------------------------------------------------------------------
  static List<String> getProvincesNamesFromCountryModel(Country country){
    List<String> _provincesNames = new List();

    List<Province> _provinces = country.provinces;

    _provinces.forEach((pr) {
      _provincesNames.add(pr.name);
    });

    _provincesNames = sortAlphabetically(_provincesNames);

    return _provincesNames;
  }
// -----------------------------------------------------------------------------
  static KeywordModel getKeywordModelFromProvinceModel(BuildContext context, Province province){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    String _name = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, province.name);

    KeywordModel _keyword = KeywordModel(
        keywordID: province.name,
        filterID: 'provinces',
        groupID: province.iso3,
        subGroupID: null,
        name: _name,
        uses: 0
    );

    return _keyword;
  }
}
