import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
// -----------------------------------------------------------------------------
class District{
  final String iso3;
  final String province;
  final String id;
  final String name;
  final List<Name> namez;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;


  District({
    this.iso3,
    this.province,
    this.id,
    this.name,
    this.namez,
    this.isActivated,
    this.isPublic,
  });

  Map<String, Object> toMap(){
    return {
      'iso3' : iso3,
      'province' : province,
      'id' : id,
      'name' : name,
      'namez' : Name.cipherNamezz(namez),
      'isActivated' : isActivated,
      'isPublic' : isPublic,
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String,dynamic>> cipherDistricts(List<District> districts){
    List<Map<String, dynamic>> _districtsList = new List();
    districts.forEach((ar) {
      _districtsList.add(ar.toMap());
    });
    return _districtsList;
  }
// -----------------------------------------------------------------------------
  static District decipherDistrictMap(Map<String, dynamic> map){
    return District(
      iso3 : map['iso3'],
      province : map['province'],
      id : map['id'],
      name : map['name'],
      namez : Name.decipherNamezzMaps(map['names']),
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
    );
  }
// -----------------------------------------------------------------------------
  static List<District> decipherDistrictsMaps(List<dynamic> maps){
    List<District> _districts = new List();
    maps?.forEach((map) {
      _districts.add(decipherDistrictMap(map));
    });
    return _districts;
  }
// -----------------------------------------------------------------------------
}
