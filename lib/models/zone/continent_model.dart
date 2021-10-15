import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class Continent{
  final String name;
  final List<Region> regions;

  const Continent({
    @required this.name,
    @required this.regions,
});

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'regions' : Region.cipherRegions(regions),
    };
  }
// -----------------------------------------------------------------------------
  static Continent decipherContinent(Map<String, dynamic> map){

    return
        Continent(
          name: map['name'],
          regions: Region.decipherRegions(map['regions']),
        );

  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherContinents(List<Continent> continents){

    Map<String, dynamic> _map = {};

    if (Mapper.canLoopList(continents)){

      for (Continent continent in continents){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: continent.name,
          value: continent.toMap(),
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static List<Continent> decipherContinents(Map<String, dynamic> map){

    final List<Continent> _continents = <Continent>[];
    final List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (String key in _keys){

        final Continent _continent = decipherContinent(map[key]);

        _continents.add(_continent);

      }

    }

    return _continents;


  }
// -----------------------------------------------------------------------------
  static bool continentsIncludeContinent({@required List<Continent> continents, @required String name}){

    bool _includes = false;

    for (Continent continent in continents){

      if (continent.name == name){
        _includes = true;
        break;
      }

    }

    return _includes;
  }
// -----------------------------------------------------------------------------
  static Continent getContinentFromContinents({@required List<Continent> continents, @required String name}){

    final Continent cont = continents.firstWhere((continent) => continent.name == name, orElse: () => null);

    return cont;
  }
// -----------------------------------------------------------------------------
}

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

    return {
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

    Map<String, dynamic> _map = {};

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