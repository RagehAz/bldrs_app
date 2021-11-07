import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class DistrictModel{
  final String countryID;
  final String cityID;
  final String districtID;
  final List<Name> names;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;


  const DistrictModel({
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
      'districtID' : CountryModel.fixCountryName(districtID),
      'names' : Name.cipherNames(names: names, addTrigrams: true),
      'isActivated' : isActivated,
      'isPublic' : isPublic,
    };
  }
// -----------------------------------------------------------------------------
  static Map<String,dynamic> cipherDistricts(List<DistrictModel> districts){
    Map<String, dynamic> _districtsMap = {};

    for (DistrictModel district in districts){

      _districtsMap = Mapper.insertPairInMap(
        map: _districtsMap,
        key: CountryModel.fixCountryName(district.districtID),
        value: district.toMap(),
      );

    }

    return _districtsMap;
  }
// -----------------------------------------------------------------------------
  static DistrictModel decipherDistrictMap(Map<String, dynamic> map){
    return DistrictModel(
      countryID : map['countryID'],
      cityID : map['cityID'],
      districtID : map['districtID'],
      names : Name.decipherNames(map['names']),
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
    );
  }
// -----------------------------------------------------------------------------
  static List<DistrictModel> decipherDistrictsMap(Map<String, dynamic> map){
    final List<DistrictModel> _districts = <DistrictModel>[];

    final List<String> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final DistrictModel _district = decipherDistrictMap(_values[i]);

        _districts.add(_district);

      }

    }

    return _districts;
  }
// -----------------------------------------------------------------------------
  static List<MapModel> getDistrictsNamesMapModels({@required BuildContext context, @required List<DistrictModel> districts}){
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
  static DistrictModel getDistrictFromDistricts({@required List<DistrictModel> districts, @required String districtID}){
    DistrictModel _district;
    if (Mapper.canLoopList(districts)){

      _district = districts.firstWhere((district) => district.districtID == districtID, orElse: () => null);

    }
    return _district;
  }
// -----------------------------------------------------------------------------
  static String getTranslatedDistrictNameFromCity({@required BuildContext context, @required CityModel city, @required String districtID}){

    String _districtName = '...';

    if (city != null && districtID != null){
      final DistrictModel _district = DistrictModel.getDistrictFromDistricts(districts: city.districts, districtID: districtID);
      _districtName = Name.getNameByCurrentLingoFromNames(context, _district?.names);
    }

    return _districtName;
  }
// -----------------------------------------------------------------------------
}