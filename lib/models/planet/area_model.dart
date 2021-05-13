import 'namez_model.dart';
// -----------------------------------------------------------------------------
class Area{
  /// country id
  final String iso3;
  final String province;
  /// Area id
  final String id;
  final String name;
  final List<Namez> namez;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;


  Area({
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
      'namez' : Namez.cipherNamezz(namez),
      'isActivated' : isActivated,
      'isPublic' : isPublic,
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String,dynamic>> cipherAreas(List<Area> areas){
    List<Map<String, dynamic>> _areasList = new List();
    areas.forEach((ar) {
      _areasList.add(ar.toMap());
    });
    return _areasList;
  }
// -----------------------------------------------------------------------------
  static Area decipherAreaMap(Map<String, dynamic> map){
    return Area(
      iso3 : map['iso3'],
      province : map['province'],
      id : map['id'],
      name : map['name'],
      namez : Namez.decipherNamezzMaps(map['names']),
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
    );
  }
// -----------------------------------------------------------------------------
  static List<Area> decipherAreasMaps(List<dynamic> maps){
    List<Area> _areas = new List();
    maps?.forEach((map) {
      _areas.add(decipherAreaMap(map));
    });
    return _areas;
  }
// -----------------------------------------------------------------------------
}
