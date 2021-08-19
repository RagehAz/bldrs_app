import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/dashboard/zones_manager/db_districts.dart';
import 'package:bldrs/dashboard/zones_manager/db_countries.dart';
import 'package:bldrs/dashboard/zones_manager/db_cities.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/city_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class CountryProvider with ChangeNotifier{
  /// get user country
  String _currentCountryID = 'egy';
  String _currentCityID = 'Cairo';
  String _currentDistrictID = '1';
  List<Country> _countries = DbCountries.dbCountries();
  List<City> _cities = DbCities.dbCities();
  List<District> _districts = DbDistricts.dbDistricts();
// -----------------------------------------------------------------------------
  String get currentCountryID {
    return _currentCountryID;
  }
// -----------------------------------------------------------------------------
  String get currentCityID{
    return _currentCityID;
  }
// -----------------------------------------------------------------------------
  String get currentDistrictsID {
    return _currentDistrictID;
  }
// -----------------------------------------------------------------------------
  Zone get currentZone {
    return Zone(
      countryID: currentCountryID,
      cityID: currentCityID,
      districtID: currentDistrictsID,
    );
  }
// -----------------------------------------------------------------------------
  void changeCountry(String country){
    _currentCountryID = country;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void changeCity(String cityID){
    _currentCityID = cityID;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void changeDistrict(String districtID){
    _currentDistrictID = districtID;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  String getCountryNameInCurrentLanguageByIso3(BuildContext context, String iso3){
    return Localizer.translate(context, iso3);
  }
// -----------------------------------------------------------------------------
  /// get available countries
  List<Map<String,String>> getAvailableCountries(BuildContext context){
    List<Map<String,String>> _countriesMaps = new List();
    _countries.forEach((co) {
      if (co.isActivated){_countriesMaps.add(
        { "id" : co.iso3, "value" : Localizer.translate(context, co.iso3)}
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
  /// get Cities list by country iso3
  List<Map<String,String>> getCitiesNamesMapsByIso3(BuildContext context, String iso3){
    List<Map<String,String>> _citiesNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);

    _cities.forEach((pr) {
      if (pr.iso3 == iso3){
        if (_currentLanguageCode == 'en'){_citiesNames.add({'id': pr.name, 'value': pr.name});}
        else
          {
            String _areaNameInCurrentLanguage = pr.namez.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
            if (_areaNameInCurrentLanguage == null){_citiesNames.add({'id': pr.name, 'value': pr.name});}
            else {_citiesNames.add({'id': pr.name, 'value': _areaNameInCurrentLanguage});}
          }
      }
    });

    return _citiesNames;
  }
// -----------------------------------------------------------------------------
  /// get Areas list by City name
  /// uses cityName in English as ID
  List<Map<String, String>> getDistrictsNameMapsByCityID(BuildContext context, String cityID){
    List<Map<String, String>> _districtsNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);
    _districts.forEach((ar) {
      if(ar.city == cityID){
          String _districtNameInCurrentLanguage = ar.namez.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
          if (_districtNameInCurrentLanguage == null){_districtsNames.add({'id': ar.id, 'value': ar.name});}
          else {_districtsNames.add({'id': ar.id, 'value': _districtNameInCurrentLanguage});}
      }
    });
    return _districtsNames;
  }
// -----------------------------------------------------------------------------
  List<District> getDistrictsByCityID(BuildContext context, String cityID){
    List<District> _cityDistricts = new List();

    _districts.forEach((ar) {
      if(ar.city == cityID){
        _cityDistricts.add(ar);
      }
    });

    return _cityDistricts;
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
  String getCityNameWithCurrentLanguageIfPossible(BuildContext context, String cityID){
  City _city = _cities.firstWhere((ar) => ar.name == cityID, orElse: ()=> null);
  // String _nameInCurrentLanguage = _city?.namez?.singleWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;

  // print('city is : ${_city.iso3} : ${_city.name} : ${_city.districts.length} : ${_city.namez}');

  String _nameInCurrentLanguage = Name.getNameByCurrentLingoFromNames(context, _city?.namez);

  return _nameInCurrentLanguage == null ? cityID : _nameInCurrentLanguage;
}
// -----------------------------------------------------------------------------
  String getCityIDByCityName(BuildContext context, String cityName){
    String _cityName;

    String _languageCode = Wordz.languageCode(context);

    if (_languageCode != 'en'){
      for (var city in _cities){

        for (var nmz in city.namez){

          bool _searchIsTrue = nmz.code == _languageCode && nmz.value == cityName ? true : false;

          if (_searchIsTrue == true){
            _cityName = city.name;
            break;
          }

        }

      }
    }

    else {
      _cityName = cityName;
    }

    return _cityName;
  }
// -----------------------------------------------------------------------------
}

