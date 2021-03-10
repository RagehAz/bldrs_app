import 'package:bldrs/dashboard/zones_manager/db_areas.dart';
import 'package:bldrs/dashboard/zones_manager/db_countries.dart';
import 'package:bldrs/dashboard/zones_manager/db_provinces.dart';
import 'package:bldrs/models/planet/area_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
class CountryProvider with ChangeNotifier{
  /// get user country
  String _currentCountryID = 'egy';
  String _currentProvinceID = 'Cairo';
  String _currentAreaID = '1';
  List<Country> _countries = dbCountries;
  List<Province> _provinces = dbProvinces;
  List<Area> _areas = dbAreas;
// ---------------------------------------------------------------------------
  String get currentCountryID {
    return _currentCountryID;
  }
// ---------------------------------------------------------------------------
  String get currentProvinceID{
    return _currentProvinceID;
  }
// ---------------------------------------------------------------------------
  String get currentAreaID {
    return _currentAreaID;
  }
// ---------------------------------------------------------------------------
  void changeCountry(String country){
    _currentCountryID = country;
    notifyListeners();
  }
// ---------------------------------------------------------------------------
  void changeProvince(String provinceID){
    _currentProvinceID = provinceID;
    notifyListeners();
  }
// ---------------------------------------------------------------------------
  void changeArea(String areaID){
    _currentAreaID = areaID;
    notifyListeners();
  }
// ---------------------------------------------------------------------------
  String getCountryNameInCurrentLanguageByIso3(BuildContext context, String iso3){
    return translate(context, iso3);
  }
// ---------------------------------------------------------------------------
  /// get available countries
  List<Map<String,String>> getAvailableCountries(BuildContext context){
    List<Map<String,String>> _countriesMaps = new List();
    _countries.forEach((co) {
      if (co.isActivated){_countriesMaps.add(
        { "id" : co.iso3, "value" : translate(context, co.iso3)}
      );}
    });
    return _countriesMaps;
  }
// ---------------------------------------------------------------------------
  /// get Provinces list by country iso3
  List<Map<String,String>> getProvincesNamesByIso3(BuildContext context, String iso3){
    List<Map<String,String>> _provincesNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);

    _provinces.forEach((pr) {
      if (pr.iso3 == iso3){
        if (_currentLanguageCode == 'en'){_provincesNames.add({'id': pr.name, 'value': pr.name});}
        else
          {
            String _areaNameInCurrentLanguage = pr.namez.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
            if (_areaNameInCurrentLanguage == null){_provincesNames.add({'id': pr.name, 'value': pr.name});}
            else {_provincesNames.add({'id': pr.name, 'value': _areaNameInCurrentLanguage});}
          }
      }
    });

    return _provincesNames;
  }
// ---------------------------------------------------------------------------
  /// get Areas list by Province name
  /// uses provinceName in English as ID
  List<Map<String, String>> getAreasNamesByProvinceID(BuildContext context, String provinceID){
    List<Map<String, String>> _areasNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);
    _areas.forEach((ar) {
      if(ar.province == provinceID){
          String _areaNameInCurrentLanguage = ar.namez.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
          if (_areaNameInCurrentLanguage == null){_areasNames.add({'id': ar.id, 'value': ar.name});}
          else {_areasNames.add({'id': ar.id, 'value': _areaNameInCurrentLanguage});}
      }
    });
    return _areasNames;
  }
// ---------------------------------------------------------------------------
  String getAreaNameWithCurrentLanguageIfPossible(BuildContext context, String areaID){
    String _currentLanguageCode = Wordz.languageCode(context);
    Area area = _areas.singleWhere((ar) => ar.id == areaID, orElse: ()=> null);
    String nameInCurrentLanguage = area?.namez?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

    // print('Area nameInCurrentLanguage = ($nameInCurrentLanguage) ,,area?.name is (${area?.name}) ');

    return nameInCurrentLanguage == null ? area?.name : nameInCurrentLanguage;
  }
// ---------------------------------------------------------------------------
  String getProvinceNameWithCurrentLanguageIfPossible(BuildContext context, String provinceName){
  String _currentLanguageCode = Wordz.languageCode(context);
  Province province = _provinces.singleWhere((ar) => ar.name == provinceName, orElse: ()=> null);
  String nameInCurrentLanguage = province?.namez?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

  return nameInCurrentLanguage == null ? provinceName : nameInCurrentLanguage;
}
// ---------------------------------------------------------------------------
}
// === === === === === === === === === === === === === === === === === === ===
String getFlagByIso3(String iso3){
  String flag;
  flagsMaps.forEach((map) {
    if(map['id'] == iso3){flag = map['value'];}
  });
  return flag;
}
// === === === === === === === === === === === === === === === === === === ===

