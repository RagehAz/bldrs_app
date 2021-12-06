import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:flutter/foundation.dart';

class Region{
  final String continent;
  final String name;
  final List<String> countriesIDs;

  const Region({
    @required this.continent,
    @required this.name,
    @required this.countriesIDs,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){

    return <String, dynamic>{
      'continent' : continent,
      'name' : name,
      'countriesIDs' : countriesIDs,
    };

  }
// -----------------------------------------------------------------------------
  static Region decipherRegion(Map<String, dynamic> map){
    return
      Region(
        name: map['name'],
        continent: map['continent'],
        countriesIDs: Mapper.getStringsFromDynamics(dynamics: map['countriesIDs']),
      );
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherRegions(List<Region> regions){

    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(regions)){

      for (Region region in regions){

        _map = Mapper.insertPairInMap(
          map: _map,
          value: region.toMap(),
          key: region.name,
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static List<Region> decipherRegions(Map<String, dynamic> map){

    final List<Region> _regions = <Region>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (String key in _keys){

        _regions.add(decipherRegion(map[key]));

      }

    }

    return _regions;
  }
// -----------------------------------------------------------------------------
  static bool regionsIncludeRegion({@required List<Region> regions, @required String name}){

    bool _includes = false;

    for (Region region in regions){

      if (region.name == name){
        _includes = true;
        break;
      }

    }

    return _includes;
  }

}
