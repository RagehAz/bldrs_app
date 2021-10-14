import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
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
      'names' : Name.cipherNames(names),
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
}