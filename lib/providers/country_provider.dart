import 'package:bldrs/ambassadors/database/db_planet/db_areas.dart';
import 'package:bldrs/ambassadors/database/db_planet/db_countries.dart';
import 'package:bldrs/ambassadors/database/db_planet/db_provinces.dart';
import 'package:bldrs/models/planet/city_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier{
  /// get user country
  String _currentCountry = 'egy';
  String _currentProvince = 'Cairo';
  String _currentArea = 'Cairo';
  List<Country> _countries = dbCountries;
  List<Province> _provinces = dbProvinces;
  List<Area> _areas = dbAreas;


  String get currentCountry {
    return _currentCountry;
  }

  String get currentProvince{
    return _currentProvince;
  }

  String get currentArea {
    return _currentArea;
  }

  void changeCountry(String country){
    _currentCountry = country;
    notifyListeners();
  }

  void changeProvince(String province){
    _currentProvince = province;
    notifyListeners();
  }


  void changeArea(String area){
    _currentArea = area;
    notifyListeners();
  }

  String superFlag(String iso3){
    String flag;
    flagsMaps.forEach((map) {
      if(map['iso3'] == iso3){flag = map['flag'];}
    });
    return flag;
  }

  String superCountryName(BuildContext context, String iso3){
    return translate(context, iso3);
  }

  /// get available countries
  List<Map<String,String>> getAvailableCountries(){
    List<Map<String,String>> _countriesMaps = new List();
    _countries.forEach((co) {
      if (co.isActivated){_countriesMaps.add(
        { "iso3" : co.iso3, "flag" : co.flag}
      );}
    });
    return _countriesMaps;
  }

  /// get Provinces list by country iso3
  List<Map<String,String>> getProvincesNames(BuildContext context, String iso3){
    List<Map<String,String>> _provincesNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);

    _provinces.forEach((pr) {
      if (pr.iso3 == iso3){
        if (_currentLanguageCode == 'en'){_provincesNames.add({'id': pr.name, 'name': pr.name});}
        else
          {
            String _areaNameInCurrentLanguage = pr.names.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
            if (_areaNameInCurrentLanguage == null){_provincesNames.add({'id': pr.name, 'name': pr.name});}
            else {_provincesNames.add({'id': pr.name, 'name': _areaNameInCurrentLanguage});}
          }
      }
    });

    return _provincesNames;
  }

  /// get Areas list by Province name
  /// uses provinceName in English as ID
  List<Map<String, String>> getAreasNames(BuildContext context, String provinceID){
    List<Map<String, String>> _areasNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);
    _areas.forEach((ar) {
      if(ar.province == provinceID){
          String _areaNameInCurrentLanguage = ar.names.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
          if (_areaNameInCurrentLanguage == null){_areasNames.add({'id': ar.name, 'name': ar.name});}
          else {_areasNames.add({'id': ar.name, 'name': _areaNameInCurrentLanguage});}
      }
    });
    return _areasNames;
  }

  String getAreaNameWithCurrentLanguageIfPossible(BuildContext context, String areaName){
    String _currentLanguageCode = Wordz.languageCode(context);
    Area area = _areas.singleWhere((ar) => ar.name == areaName, orElse: ()=> null);
    String nameInCurrentLanguage = area?.names?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

    return nameInCurrentLanguage == null ? areaName : nameInCurrentLanguage;
  }

}