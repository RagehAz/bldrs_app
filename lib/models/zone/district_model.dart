import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class District{
  final String countryID;
  final String cityID;
  final String districtID;
  final List<Name> names;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;


  const District({
    this.countryID,
    this.cityID,
    this.districtID,
    this.names,
    this.isActivated,
    this.isPublic,
  });

  Map<String, Object> toMap(){
    return {
      'countryID' : countryID,
      'cityID' : cityID,
      'districtID' : Country.fixCountryName(districtID),
      'names' : Name.cipherNames(names),
      'isActivated' : isActivated,
      'isPublic' : isPublic,
    };
  }
// -----------------------------------------------------------------------------
  static Map<String,dynamic> cipherDistricts(List<District> districts){
    Map<String, dynamic> _districtsMap = {};

    for (District district in districts){

      _districtsMap = Mapper.insertPairInMap(
        map: _districtsMap,
        key: Country.fixCountryName(district.districtID),
        value: district.toMap(),
      );

    }

    return _districtsMap;
  }
// -----------------------------------------------------------------------------
  static District decipherDistrictMap(Map<String, dynamic> map){
    return District(
      countryID : map['countryID'],
      cityID : map['cityID'],
      districtID : map['districtID'],
      names : Name.decipherNames(map['names']),
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
    );
  }
// -----------------------------------------------------------------------------
  static List<District> decipherDistrictsMap(Map<String, dynamic> map){
    final List<District> _districts = <District>[];

    final List<String> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final District _district = decipherDistrictMap(_values[i]);

        _districts.add(_district);

      }

    }

    return _districts;
  }
// -----------------------------------------------------------------------------
  static List<MapModel> getDistrictsNamesMapModels({@required BuildContext context, @required List<District> districts}){
    final List<MapModel> _districtsMapModels = <MapModel>[];

    if (Mapper.canLoopList(districts)){

      districts.forEach((district) {

        _districtsMapModels.add(
            MapModel(
                key: district.districtID,
                value: Name.getNameByCurrentLingoFromNames(context, district.names)
            )
        );

      });

    }

    return _districtsMapModels;

  }
// -----------------------------------------------------------------------------
  static District getDistrictFromDistricts({@required List<District> districts, @required String districtID}){
    District _district;
    if (Mapper.canLoopList(districts)){

      _district = districts.firstWhere((district) => district.districtID == districtID, orElse: () => null);

    }
    return _district;
  }
// -----------------------------------------------------------------------------
  static String getTranslatedDistrictNameFromCountry({@required BuildContext context, @required Country country, @required String cityID, @required String districtID}){

    String _districtName = '...';

    if (country != null && cityID != null && districtID != null){
      final City _city = City.getCityFromCities(cities: country.cities, cityID: cityID);
      final District _district = District.getDistrictFromDistricts(districts: _city.districts, districtID: districtID);
      _districtName = Name.getNameByCurrentLingoFromNames(context, _district.names);
    }

    return _districtName;
  }
// -----------------------------------------------------------------------------
static List<District> getDistrictsFromCountryModel({@required Country country, @required String cityID}){
  final City _city = City.getCityFromCities(cities: country.cities, cityID: cityID);
  return _city.districts;
}
// -----------------------------------------------------------------------------
}