

import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RawCities{

  static List<CityModel> getFixedCities(List<CityModel> inputs){

    final List<CityModel> _fixed = <CityModel>[];

    for (CityModel city in inputs){

      final CityModel _fixedCity = city .. cityID = CountryModel.fixCountryName(city.cityID);
      _fixed.add(_fixedCity);
    }

    return _fixed;
  }

  // = "CityModel(countryID: '"&&"', cityID: '"&&"', districts: [], population: "&&", isPublic: true, isActivated: true, position: GeoPoint(, ) ,names: [Name(code: 'en', value: '"&&"')]),
  static List<CityModel> and (){
    return <CityModel>[
      CityModel(countryID: 'and', cityID: 'Andorra la Vella', districts: [], population: 22151, isPublic: true, isActivated: true, position: GeoPoint(42.5,1.5) ,names: [Name(code: 'en', value: 'Andorra la Vella')]),
      CityModel(countryID: 'and', cityID: 'Canillo', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.567,1.5981) ,names: [Name(code: 'en', value: 'Canillo')]),
      CityModel(countryID: 'and', cityID: 'Ordino', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.555,1.5331) ,names: [Name(code: 'en', value: 'Ordino')]),
      CityModel(countryID: 'and', cityID: 'La Massana', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.5434,1.5148) ,names: [Name(code: 'en', value: 'La Massana')]),
      CityModel(countryID: 'and', cityID: 'Encamp', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.5167,1.5667) ,names: [Name(code: 'en', value: 'Encamp')]),
      CityModel(countryID: 'and', cityID: 'Escaldes-Engordany', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.5085,1.5385) ,names: [Name(code: 'en', value: 'Escaldes-Engordany')]),
      CityModel(countryID: 'and', cityID: 'Sant Julia de Loria', districts: [], population: 0, isPublic: true, isActivated: true, position: GeoPoint(42.4664,1.4933) ,names: [Name(code: 'en', value: 'Sant Julia de Loria')]),
    ];
  }

}