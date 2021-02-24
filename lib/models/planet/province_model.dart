import 'area_model.dart';
import 'namez_model.dart';
// ---------------------------------------------------------------------------
class Province{
  final String iso3;
  final String name;
  final List<Area> areas;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Namez> namez; // English

  Province({
    this.iso3,
    this.name,
    this.areas,
    this.population,
    this.isActivated,
    this.isPublic,
    this.namez,
  });

  Map<String, Object> toMap(){
    return {
      'iso3' : iso3,
      'name' : name,
      'areas' : cipherAreas(areas),
      'population' : population,
      'isActivated' : isActivated,
      'isPublic' : isPublic,
      'namez' : cipherNamezz(namez),
    };
  }

}
// ---------------------------------------------------------------------------
List<Map<String, dynamic>> cipherProvinces(List<Province> provinces){
  List<Map<String, dynamic>> _provincesMaps = new List();
  provinces.forEach((pr) {
    _provincesMaps.add(pr.toMap());
  });
  return _provincesMaps;
}
// ---------------------------------------------------------------------------
Province decipherProvinceMap(Map<String, dynamic> map){
  return Province(
    iso3 : map['iso3'],
    name : map['name'],
    areas : decipherAreasMaps(map['areas']),
    population : map['population'],
    isActivated : map['isActivated'],
    isPublic : map['isPublic'],
    namez : decipherNamezzMaps(map['names']),
  );
}
// ---------------------------------------------------------------------------
List<Province> decipherProvincesMaps(List<dynamic> maps){
  List<Province> _provinces = new List();
  maps?.forEach((map) {
    _provinces.add(decipherProvinceMap(map));
  });
  return _provinces;
}