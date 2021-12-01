import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/zone/region_model.dart';
import 'package:flutter/material.dart';

class Continent{
  final String name;
  final List<Region> regions;
  final List<String> activatedCountriesIDs;
  final List<String> globalCountriesIDs;

  const Continent({
    @required this.name,
    @required this.regions,
    @required this.activatedCountriesIDs,
    @required this.globalCountriesIDs,
});

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'regions' : Region.cipherRegions(regions),
      'activatedCountriesIDs' : activatedCountriesIDs,
      'globalCountriesIDs' : globalCountriesIDs,
    };
  }
// -----------------------------------------------------------------------------
  static Continent decipherContinent(Map<String, dynamic> map){

    return
      Continent(
        name: map['name'],
        regions: Region.decipherRegions(map['regions']),
        activatedCountriesIDs: Mapper.getStringsFromDynamics(dynamics : map['activatedCountriesIDs']),
        globalCountriesIDs: Mapper.getStringsFromDynamics(dynamics : map['globalCountriesIDs']),
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
  static Continent getContinentFromContinentsByCountryID({@required List<Continent> continents, @required String countryID}) {

    Continent _cont;

    for (Continent continent in continents){

      for (Region region in continent.regions){

        for (String id in region.countriesIDs){

          if (id == countryID){

            _cont = continent;
            break;

          }

          if(_cont != null){
            break;
          }

        }

        if(_cont != null){
          break;
        }

      }

      if(_cont != null){
        break;
      }
    }

    return _cont;
  }
// -----------------------------------------------------------------------------
  void printContinent({String methodName = 'CONTINENT - PRINT'}){

    print('$methodName ------------------------------- START');

    print('name : ${name}');
    print('regions : ${regions}');
    print('activatedCountriesIDs : ${activatedCountriesIDs}');
    print('globalCountriesIDs : ${globalCountriesIDs}');

    print('$methodName ------------------------------- END');

  }
// -----------------------------------------------------------------------------
}