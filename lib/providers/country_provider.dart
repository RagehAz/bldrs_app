import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/dashboard/zones_manager/db_districts.dart';
import 'package:bldrs/dashboard/zones_manager/db_countries.dart';
import 'package:bldrs/dashboard/zones_manager/db_provinces.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class CountryProvider with ChangeNotifier{
  /// get user country
  String _currentCountryID = 'egy';
  String _currentProvinceID = 'Cairo';
  String _currentDistrictID = '1';
  List<Country> _countries = DbCountries.dbCountries();
  List<Province> _provinces = DbProvinces.dbProvinces();
  List<District> _districts = DbDistricts.dbDistricts();
// -----------------------------------------------------------------------------
  String get currentCountryID {
    return _currentCountryID;
  }
// -----------------------------------------------------------------------------
  String get currentProvinceID{
    return _currentProvinceID;
  }
// -----------------------------------------------------------------------------
  String get currentDistrictsID {
    return _currentDistrictID;
  }
// -----------------------------------------------------------------------------
  Zone get currentZone {
    return Zone(
      countryID: currentCountryID,
      provinceID: currentProvinceID,
      districtID: currentDistrictsID,
    );
  }
// -----------------------------------------------------------------------------
  void changeCountry(String country){
    _currentCountryID = country;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void changeProvince(String provinceID){
    _currentProvinceID = provinceID;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void changeDistrict(String districtID){
    _currentDistrictID = districtID;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  String getCountryNameInCurrentLanguageByIso3(BuildContext context, String iso3){
    return translate(context, iso3);
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  /// get available countries
  List<String> getCountriesIDsByContinent({BuildContext context,String continent}){
    List<String> _countriesIDs = new List();

    _countries.forEach((co) {
      if (
      // co.isActivated == true &&
          co.continent == continent) {
        _countriesIDs.add(co.iso3);
      }
    });

    return _countriesIDs;
  }
// -----------------------------------------------------------------------------
  /// get Provinces list by country iso3
  List<Map<String,String>> getProvincesNameMapsByIso3(BuildContext context, String iso3){
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
// -----------------------------------------------------------------------------
  /// get Areas list by Province name
  /// uses provinceName in English as ID
  List<Map<String, String>> getDistrictsNameMapsByProvinceID(BuildContext context, String provinceID){
    List<Map<String, String>> _districtsNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);
    _districts.forEach((ar) {
      if(ar.province == provinceID){
          String _districtNameInCurrentLanguage = ar.namez.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
          if (_districtNameInCurrentLanguage == null){_districtsNames.add({'id': ar.id, 'value': ar.name});}
          else {_districtsNames.add({'id': ar.id, 'value': _districtNameInCurrentLanguage});}
      }
    });
    return _districtsNames;
  }
// -----------------------------------------------------------------------------
  List<District> getDistrictsByProvinceID(BuildContext context, String provinceID){
    List<District> _provinceDistricts = new List();

    _districts.forEach((ar) {
      if(ar.province == provinceID){
        _provinceDistricts.add(ar);
      }
    });

    return _provinceDistricts;
  }
// -----------------------------------------------------------------------------
  String getDistrictNameWithCurrentLanguageIfPossible(BuildContext context, String districtID){
    String _currentLanguageCode = Wordz.languageCode(context);
    District _district = _districts.singleWhere((ar) => ar.id == districtID, orElse: ()=> null);
    String _nameInCurrentLanguage = _district?.namez?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

    // print('Area _nameInCurrentLanguage = ($_nameInCurrentLanguage) ,,_district?.name is (${_district?.name}) ');

    return _nameInCurrentLanguage == null ? _district?.name : _nameInCurrentLanguage;
  }
// -----------------------------------------------------------------------------
  String getProvinceNameWithCurrentLanguageIfPossible(BuildContext context, String provinceID){
  Province _province = _provinces.firstWhere((ar) => ar.name == provinceID, orElse: ()=> null);
  // String _nameInCurrentLanguage = _province?.namez?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

  // print('province is : ${_province.iso3} : ${_province.name} : ${_province.districts.length} : ${_province.namez}');

  String _nameInCurrentLanguage = Name.getNameWithCurrentLanguageFromListOfNames(context, _province?.namez);

  return _nameInCurrentLanguage == null ? provinceID : _nameInCurrentLanguage;
}
// -----------------------------------------------------------------------------
  String getProvinceIDByProvinceName(BuildContext context, String provinceName){
    String _provinceID;

    String _languageCode = Wordz.languageCode(context);

    if (_languageCode != 'en'){
      for (var province in _provinces){

        for (var nmz in province.namez){

          bool _searchIsTrue = nmz.code == _languageCode && nmz.value == provinceName ? true : false;

          if (_searchIsTrue == true){
            _provinceID = province.name;
            break;
          }

        }

      }
    }

    else {
      _provinceID = provinceName;
    }

    return _provinceID;
  }
// -----------------------------------------------------------------------------
}

