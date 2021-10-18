import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CityModel{
  final String countryID;
  String cityID;
  final List<DistrictModel> districts;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Name> names;
  final GeoPoint position;
  final String state; // only for USA

  CityModel({
    this.countryID,
    this.cityID,
    this.districts,
    this.population,
    this.isActivated,
    this.isPublic,
    this.names,
    this.position,
    this.state,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap({@required bool toJSON}){
    return {
      'countryID' : countryID,
      'cityID' : CountryModel.fixCountryName(cityID),
      'districts' : DistrictModel.cipherDistricts(districts),
      'population' : population,
      'isActivated' : isActivated,
      'isPublic' : isPublic,
      'names' : Name.cipherNames(names),
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: toJSON)

    };
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherCities({@required List<CityModel> cities, @required bool toJSON}){
    Map<String, dynamic> _citiesMap = {};

    if (Mapper.canLoopList(cities)){

      for (CityModel city in cities){

        _citiesMap = Mapper.insertPairInMap(
          map: _citiesMap,
          key: CountryModel.fixCountryName(city.cityID),
          value: city.toMap(toJSON: toJSON),
        );

      }

    }

    return _citiesMap;
  }
// -----------------------------------------------------------------------------
  static CityModel decipherCityMap({@required Map<String, dynamic> map, @required bool fromJSON}){
    return CityModel(
      countryID : map['countryID'],
      cityID : map['cityID'],
      districts : DistrictModel.decipherDistrictsMap(map['districts']),
      population : map['population'],
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
      names : Name.decipherNames(map['names']),
      position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
    );
  }
// -----------------------------------------------------------------------------
  static List<CityModel> decipherCitiesMap({@required Map<String, dynamic> map, @required bool fromJSON}){
    final List<CityModel> _cities = <CityModel>[];

    final List<String> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final CityModel _city = decipherCityMap(
          map: _values[i],
          fromJSON: fromJSON,
        );

        _cities.add(_city);

      }

    }

    return _cities;
  }
// -----------------------------------------------------------------------------
  static List<String> getCitiesNamesFromCountryModelByCurrentLingo({@required BuildContext context, @required CountryModel country}){
    List<String> _citiesNames = <String>[];

    final List<CityModel> _cities = country.cities;

    _cities.forEach((city) {

      String _cityName = Name.getNameByCurrentLingoFromNames(context, city.names);

      _citiesNames.add(_cityName);
    });

    _citiesNames = TextMod.sortAlphabetically(_citiesNames);

    return _citiesNames;
  }
// -----------------------------------------------------------------------------
  static Keyword getKeywordFromCity({@required BuildContext context,@required  CityModel city}){

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    // String _name = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, city.name);

    final Keyword _keyword = Keyword(
        keywordID: city.cityID,
        flyerType: FlyerType.non,
        groupID: city.countryID,
        subGroupID: null,
        // name: _name,
        uses: 0
    );

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsFromCities({@required BuildContext context, @required List<CityModel> cities}){
    final List<Keyword> _keywords = <Keyword>[];

    cities.forEach((city) {

      final Keyword _cityKeyword = getKeywordFromCity(context: context, city: city);

      _keywords.add(_cityKeyword);

    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  void printCity(){

    print('CITY - PRINT --------------------------------------- START');

    print('countryID : $countryID');
    print('cityID : $cityID');
    print('districts : $districts');
    print('population : $population');
    print('isActivated : $isActivated');
    print('isPublic : $isPublic');
    print('names : $names');
    print('position : $position');

    print('CITY - PRINT --------------------------------------- END');

  }
// -----------------------------------------------------------------------------
  static List<MapModel> getCitiesNamesMapModels({@required BuildContext context, @required List<CityModel> cities}){

    final List<MapModel> _citiesMapModels = <MapModel>[];

    if (Mapper.canLoopList(cities)){

      cities.forEach((city) {

        _citiesMapModels.add(
            MapModel(
                key: city.cityID,
                value: Name.getNameByCurrentLingoFromNames(context, city.names)
            )
        );

      });

    }

    return _citiesMapModels;
  }
// -----------------------------------------------------------------------------
  static CityModel getCityFromCities({@required List<CityModel> cities, @required String cityID}){
    CityModel _city;
    if (Mapper.canLoopList(cities)){

      _city = cities.firstWhere((city) => city.cityID == cityID, orElse: () => null);

    }
    return _city;
  }
// -----------------------------------------------------------------------------
  static String getTranslatedCityNameFromCountry({@required BuildContext context, @required CountryModel country, @required String cityID}){
    String _cityName = '...';

    if (country != null && cityID != null){
      final CityModel _city = CityModel.getCityFromCities(cities: country.cities, cityID: cityID);
      _cityName = Name.getNameByCurrentLingoFromNames(context, _city?.names);
    }

    return _cityName;
  }
// -----------------------------------------------------------------------------
}

/*

/// non production method

//   static List<CityModel> getFixedCities(List<CityModel> inputs){
//
//     final List<CityModel> _fixed = <CityModel>[];
//
//     for (CityModel city in inputs){
//
//       final CityModel _fixedCity = city .. cityID = CountryModel.fixCountryName(city.cityID);
//       _fixed.add(_fixedCity);
//     }
//
//     return _fixed;
//   }


 */