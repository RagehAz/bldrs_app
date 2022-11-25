import 'package:bldrs/a_models/d_zone/x_planet/region_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

@immutable
class Continent {
  /// --------------------------------------------------------------------------
  const Continent({
    @required this.name,
    @required this.regions,
  });
  /// --------------------------------------------------------------------------
  final String name;
  final List<Region> regions;
  // -----------------------------------------------------------------------------
  static const continentsMapID = 'continents';
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'regions': Region.cipherRegions(regions),
    };
  }
  // --------------------
  static Continent decipherContinent(Map<String, dynamic> map) {
    return Continent(
      name: map['name'],
      regions: Region.decipherRegions(map['regions']),
    );
  }
  // --------------------
  static Map<String, dynamic> cipherContinents(List<Continent> continents) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(continents)) {
      for (final Continent continent in continents) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: continent.name,
          value: continent.toMap(),
        );
      }

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: continentsMapID,
      );

    }

    return _map;
  }
  // --------------------
  static List<Continent> decipherContinents(Map<String, dynamic> map) {
    final List<Continent> _continents = <Continent>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys)) {
        for (final String key in _keys) {

          if (map[key] != continentsMapID){
            final Continent _continent = decipherContinent(map[key]);
            _continents.add(_continent);
          }

        }
      }
    }

    return _continents;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkContinentsIncludeContinent({
    @required List<Continent> continents,
    @required String name,
  }) {
    bool _includes = false;

    for (final Continent continent in continents) {
      if (continent.name == name) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }
  // --------------------
  static bool checkIconIsContinent(String icon) {
    bool _iconIsContinent;

    if (icon == Iconz.contAfrica ||
        icon == Iconz.contAsia ||
        icon == Iconz.contSouthAmerica ||
        icon == Iconz.contNorthAmerica ||
        icon == Iconz.contEurope ||
        icon == Iconz.contAustralia) {
      _iconIsContinent = true;
    }

    else {
      _iconIsContinent = false;
    }

    return _iconIsContinent;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static Continent getContinentFromContinents({
    @required List<Continent> continents,
    @required String name,
  }) {

    final Continent cont = continents.firstWhere(
            (Continent continent) => continent.name == name,
        orElse: () => null);

    return cont;
  }
  // --------------------
  static Continent getContinentFromContinentsByCountryID({
    @required List<Continent> continents,
    @required String countryID,
  }) {

    Continent _cont;

    if (countryID != null){

      for (final Continent continent in continents) {
        for (final Region region in continent.regions) {
          for (final String id in region.countriesIDs) {

            if (id == countryID) {
              _cont = continent;
              break;
            }

            if (_cont != null) {
              break;
            }
          }

          if (_cont != null) {
            break;
          }
        }

        if (_cont != null) {
          break;
        }
      }

    }

    return _cont;
  }
  // --------------------
  static String getContinentIcon(Continent continent) {
    final String _name = continent.name;

    switch (_name) {
      case 'Africa': return Iconz.contAfrica; break;
      case 'Asia': return Iconz.contAsia; break;
      case 'Oceania': return Iconz.contAustralia; break;
      case 'Europe': return Iconz.contEurope; break;
      case 'North America': return Iconz.contNorthAmerica; break;
      case 'South America': return Iconz.contSouthAmerica; break;
      default: return null;
    }
  }
  // --------------------
  static List<String> getCountriesIDsOfContinent(Continent continent) {
    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions) {
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }
  // -----------------------------------------------------------------------------

  /// LISTS

  // --------------------
  static const List<Map<String, dynamic>> continentsMaps = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Africa',
      'icon': Iconz.contAfrica,
    },
    <String, dynamic>{
      'name': 'Asia',
      'icon': Iconz.contAsia,
    },
    <String, dynamic>{
      'name': 'Oceania',
      'icon': Iconz.contAustralia,
    },
    <String, dynamic>{
      'name': 'Europe',
      'icon': Iconz.contEurope,
    },
    <String, dynamic>{
      'name': 'North America',
      'icon': Iconz.contNorthAmerica,
    },
    <String, dynamic>{
      'name': 'South America',
      'icon': Iconz.contSouthAmerica,
    },
  ];
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogContinent({
    String invoker = '',
  }) {
    blog('CONTINENT : name : $name : regions : $regions');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogContinents(List<Continent> continents){
    if (Mapper.checkCanLoopList(continents) == true){

      for (final Continent cont in continents){
        cont.blogContinent();
      }

    }
  }
  // -----------------------------------------------------------------------------

}
