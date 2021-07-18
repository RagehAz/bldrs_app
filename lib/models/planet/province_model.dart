import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
// -----------------------------------------------------------------------------
class Province{
  final String iso3;
  final String name; /// TASK : should delete this and get the name from names
  final List<District> districts;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Name> namez; // English

  Province({
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
      districts : District.decipherDistrictsMaps(map['areas']),/// TASK should update field name areas to districts in firebase
      population : map['population'],
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
      namez : Name.decipherNamezzMaps(map['names']),
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

    _provincesNames = TextMod.sortAlphabetically(_provincesNames);

    return _provincesNames;
  }
// -----------------------------------------------------------------------------
  static Keyword getKeywordFromProvince(BuildContext context, Province province){

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    // String _name = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, province.name);

    Keyword _keyword = Keyword(
        keywordID: province.name,
        flyerType: FlyerType.Non,
        groupID: province.iso3,
        subGroupID: null,
        // name: _name,
        uses: 0
    );

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsFromProvinces(BuildContext context, List<Province> provinces){
    List<Keyword> _keywords = new List();

    provinces.forEach((province) {

      Keyword _provinceKeyword = getKeywordFromProvince(context, province);

      _keywords.add(_provinceKeyword);

    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
}
